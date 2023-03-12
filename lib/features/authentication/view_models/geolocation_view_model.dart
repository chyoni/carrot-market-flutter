import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationViewModel extends AsyncNotifier<List<Placemark>> {
  List<Placemark> _places = [];

  Future<List<Placemark>> getPlaces(double latitude, double longitude) async {
    return await placemarkFromCoordinates(
      latitude,
      longitude,
    );
  }

  @override
  FutureOr<List<Placemark>> build() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    const AsyncValue.loading();
    _places = await getPlaces(position.latitude, position.longitude);
    state = AsyncValue.data(_places);
    return _places;
  }
}

final geoLocationProvider =
    AsyncNotifierProvider<GeoLocationViewModel, List<Placemark>>(
  () => GeoLocationViewModel(),
);
