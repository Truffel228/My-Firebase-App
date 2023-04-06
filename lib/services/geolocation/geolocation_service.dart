import 'package:fire_base_app/services/geolocation/geolocation_service_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationService implements GeolocationServiceInterface {
  @override
  Future<Position?> getPosition() async {
    LocationPermission permission;

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw GeoServiceDisabledException();
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          throw NoLocationPermissionException();
        }
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw NoLocationPermissionException();
    }

    return await Geolocator.getCurrentPosition();
    // try {
    //   var serviceEnabled = await location.serviceEnabled();
    //   if (!serviceEnabled) {
    //     serviceEnabled = await location.requestService();
    //     if (!serviceEnabled) {
    //       print('Location service denied');
    //       return null;
    //     }
    //   }
    //   var permission = await location.hasPermission();
    //   if (permission == PermissionStatus.denied) {
    //     permission = await location.requestPermission();
    //     if (permission == PermissionStatus.denied ||
    //         permission == PermissionStatus.deniedForever) {
    //       print('Location permission denied');
    //       return null;
    //     }
    //   }
    //   final position = await location.getLocation();
    //   return (position.latitude != null && position.longitude != null)
    //       ? LatLng(position.latitude!, position.longitude!)
    //       : null;
    // } catch (e) {
    //   print(e);
    //   return null;
    // }
  }

  @override
  Stream<Position?> onPositionChanged() async* {
    try {
      yield* Geolocator.getPositionStream();
    } catch (e) {
      print(
          'No location access in onPositionChanged method in GeolocatonService');
      yield null;
    }
  }

  Stream<ServiceStatus> onGeoserviceStatusChanged() async* {
    yield* Geolocator.getServiceStatusStream();
  }
}

class NoLocationPermissionException implements Exception {}

class GeoServiceDisabledException implements Exception {}
