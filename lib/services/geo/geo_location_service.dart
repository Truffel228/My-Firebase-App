import 'package:fire_base_app/services/geo/geo_service_interface.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:location/location.dart';

class GeoLocationService implements GeoServiceInterface {
  final location = Location();
  @override
  Future<Position?> getPosition() async {
    var serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        print('Location service denied');
        return null;
      }
    }
    var permission = await location.hasPermission();
    if (permission == LocationPermission.denied) {
      permission = await location.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        print('Location permission denied');
        return null;
      }
    }
    final position = await location.getLocation();
    return Position(
      latitude: position.latitude!,
      longitude: position.longitude!,
      heading: 5,
      timestamp: DateTime.now(),
      altitude: 5,
      speed: 3,
      accuracy: 3,
      speedAccuracy: 4,
    );
  }
}
