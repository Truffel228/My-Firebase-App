import 'package:fire_base_app/screens/map/bloc/map_bloc.dart';
import 'package:fire_base_app/screens/map_comment/bloc/map_comment_screen_bloc.dart';
import 'package:fire_base_app/screens/profile/bloc/profile/profile_bloc.dart';
import 'package:fire_base_app/services/auth/auth_service_interface.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';
import 'package:fire_base_app/services/geolocation/geolocation_service_interface.dart';
import 'package:fire_base_app/services/image_picker_service.dart';
import 'package:fire_base_app/shared/app_bloc_observer.dart';
import 'package:fire_base_app/shared/locator.dart';
import 'package:fire_base_app/models/app_user/app_user.dart';
import 'package:fire_base_app/shared/router.dart';
import 'package:fire_base_app/screens/log_home_wrapper/log_home_wrapper.dart';
import 'package:fire_base_app/shared/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'wrappers/connection/bloc/connection_wrapper_bloc.dart';
import 'wrappers/connection/connection_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setUp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final AuthServiceInterface _authService = locator.get<AuthServiceInterface>();
  final DatabaseServiceInterface _databaseService =
      locator.get<DatabaseServiceInterface>();
  final GeolocationServiceInterface _geoService =
      locator.get<GeolocationServiceInterface>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ConnectionWrapperBloc()),
        BlocProvider(
          create: (context) =>
              MapCommentScreenBloc(databaseService: _databaseService),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(databaseService: _databaseService),
        ),
        BlocProvider(
          create: (context) => MapBloc(
              geoService: _geoService, databaseService: _databaseService),
        ),
      ],
      child: StreamProvider<AppUser?>.value(
        initialData: null,
        value: _authService.onAuthStateChanged,
        child: MaterialApp(
          theme: lightTheme,
          title: 'Flutter Demo',
          home: ConnectionWrapper(child: LogHomeWrapper()),
          routes: Routes.routes,
        ),
      ),
    );
  }
}
