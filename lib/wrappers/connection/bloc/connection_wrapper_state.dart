part of 'connection_wrapper_bloc.dart';

abstract class ConnectionWrapperState extends Equatable {
  const ConnectionWrapperState();
}

class ConnectionWrapperLoading extends ConnectionWrapperState {
  @override
  List<Object> get props => [];
}

class ConnectionWrapperDisconnected extends ConnectionWrapperState {
  @override
  List<Object?> get props => [];
}

class ConnectionWrapperConnected extends ConnectionWrapperState {
  @override
  List<Object?> get props => [];
}
