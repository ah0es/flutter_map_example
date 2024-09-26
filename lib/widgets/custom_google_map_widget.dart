import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMapWidget extends StatefulWidget {
  const CustomGoogleMapWidget({super.key});

  @override
  State<CustomGoogleMapWidget> createState() => _CustomGoogleMapWidgetState();
}

class _CustomGoogleMapWidgetState extends State<CustomGoogleMapWidget> {
  late GoogleMapController googleMapController;
  String? _mapStyle;

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  void initMapStyle() async {
    var mapNightMode = await DefaultAssetBundle.of(context).loadString('assets/map_styles/map_styles_night_mode.json');
    setState(() {
      _mapStyle = mapNightMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) {
            googleMapController = controller;
            initMapStyle();
          },
          style: _mapStyle,
          initialCameraPosition: const CameraPosition(
            zoom: 13,
            target: LatLng(30.04422632972928, 31.247551793100282),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          right: 10,
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                googleMapController.animateCamera(
                  CameraUpdate.newLatLng(
                    const LatLng(31.78383500939122, 35.07237155452735),
                  ),
                );
              });
            },
            child: const Text('change direction'),
          ),
        )
      ],
    );
  }
}
