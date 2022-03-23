import 'package:fire_base_app/screens/map/bloc/map_bloc.dart';
import 'package:fire_base_app/screens/profile/bloc/profile_bloc.dart';
import 'package:fire_base_app/services/auth/auth_service_interface.dart';
import 'package:fire_base_app/services/database/database_service.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';
import 'package:fire_base_app/services/geo/geo_service_interface.dart';
import 'package:fire_base_app/shared/locator.dart';
import 'package:fire_base_app/models/app_user/app_user.dart';
import 'package:fire_base_app/shared/router.dart';
import 'package:fire_base_app/screens/log_home_wrapper/log_home_wrapper.dart';
import 'package:fire_base_app/services/auth/auth_service.dart';
import 'package:fire_base_app/shared/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AuthServiceInterface _authService = locator.get<AuthServiceInterface>();
  final DatabaseServiceInterface _databaseService =
      locator.get<DatabaseServiceInterface>();
  final GeoServiceInterface _geoService = locator.get<GeoServiceInterface>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProfileBloc(databaseService: _databaseService),
        ),
        BlocProvider(create: (context) => MapBloc(geoService: _geoService)),
      ],
      child: StreamProvider<AppUser?>.value(
        initialData: null,
        value: _authService.onAuthStateChanged,
        child: MaterialApp(
          theme: lightTheme,
          title: 'Flutter Demo',
          home: LogHomeWrapper(),
          routes: Routes.routes,
        ),
      ),
    );
  }
}
