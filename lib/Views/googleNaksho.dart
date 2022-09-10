import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  //-------------------------------------------------variables--------------------------------------------------------------//

  late GoogleMapController _googleMapController;
  static const CameraPosition initialCamaraPosition = CameraPosition(
      target: LatLng(37.42796133580664, -122.0857496555962), zoom: 14);
  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    //-------------------------------------------------------------------UI-------------------------------------------------------------------//
    return Scaffold(
      appBar: AppBar(title: const Text("Current Location")),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: markers,
        initialCameraPosition: initialCamaraPosition,
        zoomControlsEnabled: false,
        onMapCreated: (GoogleMapController controller) {
          _googleMapController = controller;
        },
      ),

      ///FloatingActionButton-------------------//
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Position position = await _determinePosition();
          _googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 14),
            ),
          );

          markers.clear();
          markers.add(
            Marker(
              markerId: const MarkerId("CurrentLocation"),
              position: LatLng(position.latitude, position.longitude),
            ),
          );
          setState(() {});
        },
        label: const Text("Current Location"),
        icon: const Icon(Icons.location_history),
      ),
    );
  }

  ///Position Function-------------------///
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error("Location service are disabled");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        return Future.error("Location Permission  denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error("Location permission are Permanently denied");
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }
}
