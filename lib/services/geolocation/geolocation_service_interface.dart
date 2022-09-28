import 'package:latlong2/latlong.dart';

abstract class GeolocationServiceInterface{
  Future<LatLng?> getPosition();
  Stream<LatLng?> onPositionChanged();
}