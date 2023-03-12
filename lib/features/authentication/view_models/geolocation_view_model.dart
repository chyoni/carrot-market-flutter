import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationViewModel extends AsyncNotifier<List<Placemark>> {
  List<Placemark> _places = [];

  Future<List<Placemark>> getPlacesFromCoords(
    double latitude,
    double longitude,
  ) async {
    return await placemarkFromCoordinates(
      latitude,
      longitude,
    );
  }

  Future<void> getPlacesFromAddress(String addr) async {
    if (addr == "") return;
    const AsyncValue.loading();
    try {
      List<Location> locations = await locationFromAddress(addr);
      List<Placemark> p = await placemarkFromCoordinates(
          locations[0].latitude, locations[0].longitude);
      _places = p;
      state = AsyncValue.data(_places);
    } on NoResultFoundException catch (e) {
      state =
          AsyncValue.error("검색 결과가 없습니다.", StackTrace.fromString(e.toString()));
    }
  }

  Future<void> refresh() async {
    const AsyncValue.loading();
    final Position position = await _getCurrentCoords();
    final refreshData =
        await getPlacesFromCoords(position.latitude, position.longitude);
    _places = refreshData;
    state = AsyncValue.data(_places);
  }

  Future<Position> _getCurrentCoords() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return position;
  }

  @override
  FutureOr<List<Placemark>> build() async {
    const AsyncValue.loading();
    final Position position = await _getCurrentCoords();
    _places = await getPlacesFromCoords(position.latitude, position.longitude);
    state = AsyncValue.data(_places);
    return _places;
  }
}

final geoLocationProvider =
    AsyncNotifierProvider<GeoLocationViewModel, List<Placemark>>(
  () => GeoLocationViewModel(),
);
