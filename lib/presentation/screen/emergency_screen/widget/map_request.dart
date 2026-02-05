import 'package:geolocator/geolocator.dart';

class MapRequest {


 static Future<void> requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 🔹 Check location service
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    // 🔹 Check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
    }
  }
}