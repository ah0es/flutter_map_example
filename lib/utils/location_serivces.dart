import 'package:location/location.dart';

class LocationService {
  Location location = Location();

  Future<void> checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        throw Exception();
      }
    }
  }

  Future<void> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      throw Exception();
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        throw Exception();
      }
    }
  }

  void getRealTimeLocationData(void Function(LocationData)? onData) {
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getCurrentLocation() async {
    checkAndRequestLocationService();
    checkAndRequestLocationPermission();
    return location.getLocation();
  }
}
