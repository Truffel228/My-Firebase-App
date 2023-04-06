import 'package:geolocator/geolocator.dart';

abstract class GeolocationServiceInterface {
  Future<Position?> getPosition();
  Stream<Position?> onPositionChanged();
  Stream<ServiceStatus> onGeoserviceStatusChanged();
}
