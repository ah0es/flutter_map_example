import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMapWidget extends StatefulWidget {
  const CustomGoogleMapWidget({super.key});

  @override
  State<CustomGoogleMapWidget> createState() => _CustomGoogleMapWidgetState();
}

class _CustomGoogleMapWidgetState extends State<CustomGoogleMapWidget> {
  @override
  Widget build(BuildContext context) {
    return const GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(30.04422632972928, 31.247551793100282),
      ),
    );
  }
}
