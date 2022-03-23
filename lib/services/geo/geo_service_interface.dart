import 'package:geolocator/geolocator.dart';

abstract class GeoServiceInterface{
  Future<Position?> getPosition();
}