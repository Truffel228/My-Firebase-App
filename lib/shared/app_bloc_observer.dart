import 'package:fire_base_app/shared/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.i('EVENT ${event.runtimeType} in ${bloc.runtimeType}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.i(
        'TRANSITION in ${bloc.runtimeType} with event ${transition.event.runtimeType} \n CURRENT STATE: ${transition.currentState.runtimeType} \n NEXT STATE: ${transition.nextState.runtimeType}');
  }
}
