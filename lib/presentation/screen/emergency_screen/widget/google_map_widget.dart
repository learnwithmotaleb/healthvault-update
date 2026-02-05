import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class CurrentLocationMap extends StatefulWidget {
  const CurrentLocationMap({super.key});

  @override
  State<CurrentLocationMap> createState() => _CurrentLocationMapState();
}

class _CurrentLocationMapState extends State<CurrentLocationMap> {
  GoogleMapController? _mapController;
  LatLng? _currentLatLng;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLatLng = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10), // ✅ 10px padding
      child: Container(
        height: 250,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: _currentLatLng == null
            ? const Center(child: CircularProgressIndicator())
            : ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentLatLng!,
              zoom: 15,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: {
              Marker(
                markerId: const MarkerId('current_location'),
                position: _currentLatLng!,
              ),
            },
            onMapCreated: (controller) {
              _mapController = controller;
            },
          ),
        ),
      ),
    );
  }
}
