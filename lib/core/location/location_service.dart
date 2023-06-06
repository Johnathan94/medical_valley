import 'package:geolocator/geolocator.dart';

class LocationServiceProvider {
  static late Position _currentPosition;
  static Future determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    _currentPosition = await Geolocator.getCurrentPosition();
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
