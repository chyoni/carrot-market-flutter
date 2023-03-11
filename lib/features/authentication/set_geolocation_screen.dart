import 'dart:io';

import 'package:carrotmarket/constants/gaps.dart';
import 'package:carrotmarket/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class SetGeolocationScreen extends StatefulWidget {
  static const String routeName = "setLocation";
  static const String routeURL = "/location";

  const SetGeolocationScreen({super.key});

  @override
  State<SetGeolocationScreen> createState() => _SetGeolocationScreenState();
}

class _SetGeolocationScreenState extends State<SetGeolocationScreen> {
  late final bool _serviceEnabled;
  late LocationPermission _permission;
  late final List<Placemark> _places;

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

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _places =
        await placemarkFromCoordinates(position.latitude, position.longitude);
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
        title: FractionallySizedBox(
          widthFactor: 1,
          child: TextField(
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
                  children: const [
                    Icon(
                      Icons.gps_not_fixed,
                      size: Sizes.size14,
                      color: Colors.white,
                    ),
                    Gaps.h8,
                    Text(
                      "현재위치로 찾기",
                      style: TextStyle(
                        height: Sizes.size2,
                        fontSize: Sizes.size14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
