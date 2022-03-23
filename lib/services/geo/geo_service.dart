import 'package:fire_base_app/services/geo/geo_service_interface.dart';
import 'package:geolocator/geolocator.dart';

class GeoService implements GeoServiceInterface{
  @override
  Future<Position?> getPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print('here');
    if(!serviceEnabled){
      print('Location service is disabled');
      return null;
    }
    print('enabled');
    var permission = await Geolocator.checkPermission();
    //TODO: Test
    permission = LocationPermission.denied;
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied || permission == LocationPermission.deniedForever){
        print('Location permission is denied');
        return null;
      }
    }
    return await Geolocator.getCurrentPosition();
  }

}