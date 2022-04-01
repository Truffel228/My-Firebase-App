import 'package:fire_base_app/services/geo/geolocation_service_interface.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class GeolocationService implements GeolocationServiceInterface {
  final location = Location();
  @override
  Future<LatLng?> getPosition() async {
    try {
      var serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          print('Location service denied');
          return null;
        }
      }
      var permission = await location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await location.requestPermission();
        if (permission == PermissionStatus.denied ||
            permission == PermissionStatus.deniedForever) {
          print('Location permission denied');
          return null;
        }
      }
      final position = await location.getLocation();
      return (position.latitude != null && position.longitude != null)
          ? LatLng(position.latitude!, position.longitude!)
          : null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
