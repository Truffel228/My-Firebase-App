import 'package:fire_base_app/services/auth/auth_service.dart';
import 'package:fire_base_app/services/database/database_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setUp() {
  locator.registerLazySingleton<AuthService>(() => AuthService());
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
}
