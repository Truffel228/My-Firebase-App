part of 'connection_wrapper_bloc.dart';

abstract class ConnectionWrapperEvent extends Equatable {
  const ConnectionWrapperEvent();
}

class ConnectionWrapperDisconnectedEvent extends ConnectionWrapperEvent {
  @override
  List<Object?> get props => [];
}

class ConnectionWrapperConnectedEvent extends ConnectionWrapperEvent {
  @override
  List<Object?> get props => [];
}
