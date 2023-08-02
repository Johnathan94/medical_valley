import 'package:geolocator/geolocator.dart';

class LocationServiceProvider {
  static late Position _currentPosition;
  static Future<Position?> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    _currentPosition = await Geolocator.getCurrentPosition();
    return _currentPosition;
  }

  static double getDistanceBetweenCurrentAndLocation(
      {required double longitude, required double latitude}) {
    double distanceInMeters = Geolocator.distanceBetween(
        _currentPosition.latitude,
        _currentPosition.longitude,
        latitude,
        longitude);
    return distanceInMeters;
  }

  static Position get currentPosition => _currentPosition;
}
