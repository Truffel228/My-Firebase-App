import 'package:fire_base_app/services/auth/auth_service.dart';
import 'package:fire_base_app/services/auth/auth_service_interface.dart';
import 'package:fire_base_app/services/database/database_service.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';
import 'package:fire_base_app/services/geo/geo_location_service.dart';
import 'package:fire_base_app/services/geo/geo_service.dart';
import 'package:fire_base_app/services/geo/geo_service_interface.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setUp() {
  locator.registerLazySingleton<AuthServiceInterface>(() => AuthService());
  locator
      .registerLazySingleton<DatabaseServiceInterface>(() => DatabaseService());
  locator
      .registerLazySingleton<GeoServiceInterface>(() => GeoLocationService());
}
