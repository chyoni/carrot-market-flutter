import 'dart:io';

import 'package:carrotmarket/constants/gaps.dart';
import 'package:carrotmarket/constants/sizes.dart';
import 'package:carrotmarket/features/authentication/view_models/geolocation_view_model.dart';
import 'package:carrotmarket/features/authentication/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class SetGeolocationScreen extends ConsumerStatefulWidget {
  static const String routeName = "setLocation";
  static const String routeURL = "/location";

  const SetGeolocationScreen({super.key});

  @override
  SetGeolocationScreenState createState() => SetGeolocationScreenState();
}

class SetGeolocationScreenState extends ConsumerState<SetGeolocationScreen> {
  late final bool _serviceEnabled;
  late LocationPermission _permission;
  final TextEditingController _controller = TextEditingController();

  Future<void> _getPermission() async {
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      return Future.error("위치 서비스를 이용할 수 없는 상태입니다.");
    }

    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
      if (_permission == LocationPermission.denied) {
        return Future.error("위치 서비스를 사용하지 않으면 앱을 사용할 수 없습니다.");
      }
    }

    if (_permission == LocationPermission.deniedForever) {
      return Future.error("위치 서비스를 사용하지 않으면 앱을 사용할 수 없습니다.");
    }
  }

  Future<void> _tapFindCurrentPosition() async {
    await ref.read(geoLocationProvider.notifier).refresh();
  }

  Future<void> _onChangedOrSubmittedSearchField(String value) async {
    await ref.read(geoLocationProvider.notifier).getPlacesFromAddress(value);
  }

  _onTapListTile(String selectedPlace) {
    context.pushNamed(
      LoginScreen.routeName,
      queryParams: {"place": selectedPlace},
    );
  }

  @override
  void initState() {
    super.initState();
    _getPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: Sizes.size20,
        title: TextField(
          controller: _controller,
          onSubmitted: (value) => _onChangedOrSubmittedSearchField(value),
          onChanged: (value) => _onChangedOrSubmittedSearchField(value),
          autocorrect: false,
          style: const TextStyle(
            fontSize: Sizes.size14,
            height: Sizes.size2,
          ),
          decoration: InputDecoration(
            fillColor: Colors.white,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade500,
            ),
            hintText: "동명(읍, 면)으로 검색 (ex. 서초동)",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: Platform.isAndroid ? 3 : 1.5,
                color: Colors.grey.shade500,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: Platform.isAndroid ? 3 : 1.5,
                color: Colors.grey.shade500,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: Sizes.size12,
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size14),
        child: Column(
          children: [
            Gaps.v10,
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size20,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.shade700,
                  borderRadius: BorderRadius.circular(Sizes.size5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.gps_not_fixed,
                      size: Sizes.size14,
                      color: Colors.white,
                    ),
                    Gaps.h8,
                    GestureDetector(
                      onTap: _tapFindCurrentPosition,
                      child: const Text(
                        "현재위치로 찾기",
                        style: TextStyle(
                          height: Sizes.size2,
                          fontSize: Sizes.size14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ref.watch(geoLocationProvider).when(
                    loading: () => Center(
                      widthFactor: 1,
                      child: Platform.isAndroid
                          ? CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            )
                          : const CircularProgressIndicator.adaptive(),
                    ),
                    error: (error, stackTrace) => Center(
                      child: Text(
                        error.toString(),
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: Sizes.size20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    data: (places) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: places.length,
                        separatorBuilder: (context, index) => Divider(
                          color: Colors.grey.shade300,
                          height: Sizes.size1,
                        ),
                        itemBuilder: (context, index) {
                          final place = places[index];
                          if (place.administrativeArea == "" ||
                              place.locality == "" ||
                              place.subLocality == "" ||
                              place.thoroughfare == "") {
                            return const SizedBox.shrink();
                          }
                          return ListTile(
                            dense: true,
                            onTap: () => _onTapListTile(
                                "${place.administrativeArea} ${place.locality} ${place.subLocality} ${place.thoroughfare}"),
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              "${place.administrativeArea} ${place.locality} ${place.subLocality} ${place.thoroughfare}",
                              style: const TextStyle(
                                fontSize: Sizes.size14,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
            )
          ],
        ),
      ),
    );
  }
}
