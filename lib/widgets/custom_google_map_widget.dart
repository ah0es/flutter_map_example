import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_example/utils/location_serivces.dart';

class CustomGoogleMapWidget extends StatefulWidget {
  const CustomGoogleMapWidget({super.key});

  @override
  State<CustomGoogleMapWidget> createState() => _CustomGoogleMapWidgetState();
}

class _CustomGoogleMapWidgetState extends State<CustomGoogleMapWidget> {
  late GoogleMapController googleMapController;
  String? _mapStyle;
  final Set<Marker> _markers = {};
  late LocationService locationService;
  @override
  void initState() {
    locationService = LocationService();
    //initMapStyle();
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  // void initMapStyle() async {
  //   var mapNightMode = await DefaultAssetBundle.of(context).loadString('assets/map_styles/map_styles_night_mode.json');
  //   setState(() {
  //     _mapStyle = mapNightMode;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          style: _mapStyle,
          markers: _markers,
          onMapCreated: (controller) {
            googleMapController = controller;
            getUserLocation();
          },
          initialCameraPosition: const CameraPosition(
            zoom: 14,
            target: LatLng(30.04422632972928, 31.247551793100282),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: ElevatedButton(
            onPressed: () {
              googleMapController.animateCamera(
                CameraUpdate.newLatLng(
                  const LatLng(31.78383500939122, 35.07237155452735),
                ),
              );
            },
            child: const Text('Change direction'),
          ),
        ),
      ],
    );
  }

  void getUserLocation() async {
    try {
      var locationData = await locationService.getCurrentLocation();
      LatLng initialPosition = LatLng(locationData.latitude!, locationData.longitude!);
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: initialPosition, zoom: 16),
        ),
      );
      _markers.add(
        Marker(markerId: const MarkerId('1'), position: initialPosition),
      );
      setState(() {});
    } catch (e) {
      log('getCurrentLocation $e');
    }
  }
}
