import 'package:fire_base_app/services/auth/auth_service.dart';
import 'package:fire_base_app/services/auth/auth_service_interface.dart';
import 'package:fire_base_app/services/database/database_service.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';
import 'package:fire_base_app/services/file_helper/file_helper_service.dart';
import 'package:fire_base_app/services/file_helper/file_helper_service_interface.dart';
import 'package:fire_base_app/services/geolocation/geolocation_service.dart';
import 'package:fire_base_app/services/geolocation/geolocation_service_interface.dart';
import 'package:fire_base_app/services/image_picker_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setUp() {
  locator.registerLazySingleton<AuthServiceInterface>(() => AuthService());
  locator
      .registerLazySingleton<DatabaseServiceInterface>(() => DatabaseService());
  locator.registerLazySingleton<GeolocationServiceInterface>(
      () => GeolocationService());
  locator.registerLazySingleton<ImagePickerService>(() => ImagePickerService());
  locator.registerLazySingleton<FileHelperServiceInterface>(
      () => FileHelperService());
}
