import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'connection_wrapper_event.dart';
part 'connection_wrapper_state.dart';

class ConnectionWrapperBloc
    extends Bloc<ConnectionWrapperEvent, ConnectionWrapperState> {
  final Connectivity _connectivity = Connectivity();
  late final StreamSubscription _connectivitySubscription;

  ConnectionWrapperBloc() : super(ConnectionWrapperLoading()) {
    on<ConnectionWrapperDisconnectedEvent>(
        _onConnectionWrapperDisconnectedEvent);
    on<ConnectionWrapperConnectedEvent>(_onConnectionWrapperConnectedEvent);
    listenConnectionState();
  }

  void _onConnectionWrapperDisconnectedEvent(event, emit) {
    emit(ConnectionWrapperDisconnected());
  }

  void _onConnectionWrapperConnectedEvent(event, emit) {
    emit(ConnectionWrapperConnected());
  }

  void listenConnectionState() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      add(ConnectionWrapperConnectedEvent());
    } else {
      add(ConnectionWrapperDisconnectedEvent());
    }
    _connectivitySubscription = _connectivity.onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        if (state is! ConnectionWrapperConnected) {
          add(ConnectionWrapperConnectedEvent());
        }
      } else {
        if (state is! ConnectionWrapperDisconnected) {
          add(ConnectionWrapperDisconnectedEvent());
        }
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
