import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:map_example/models/places_model.dart';

class CustomGoogleMapWidget extends StatefulWidget {
  const CustomGoogleMapWidget({super.key});

  @override
  State<CustomGoogleMapWidget> createState() => _CustomGoogleMapWidgetState();
}

class _CustomGoogleMapWidgetState extends State<CustomGoogleMapWidget> {
  late GoogleMapController googleMapController;
  String? _mapStyle;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  late Location location;
  @override
  void initState() {
    initMapStyle();
    location = Location();
    initLocationServices();
    super.initState();
  }

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

  initLocationServices() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      var isRequestService = await location.requestService();
      if (isRequestService) {
        print('ss');
      }
    }
  }

  void initMapMarkers() {
    var myMarkers = places
        .map(
          (places) => Marker(
            position: places.latLong,
            markerId: MarkerId(places.id),
          ),
        )
        .toSet();
    _markers.addAll(myMarkers);
  }

  void initPolyLines() {
    const myPolyLines = Polyline(startCap: Cap.roundCap, color: Colors.red, polylineId: PolylineId('1'), points: [
      LatLng(27.243644005046896, 31.17669837899221),
      LatLng(27.221916394928794, 31.13309209071705),
      LatLng(27.266672616962804, 31.149413763848838),
      LatLng(27.2464447097953, 31.102592099353522)
    ]);

    setState(() {
      _polyLines.add(myPolyLines);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          polylines: _polyLines,
          style: _mapStyle,
          markers: _markers,
          onMapCreated: (controller) {
            googleMapController = controller;
            //  googleMapController.setMapStyle(_mapStyle);
            initMapMarkers();
            initPolyLines();
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
}
