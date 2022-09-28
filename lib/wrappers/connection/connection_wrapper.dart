import 'package:fire_base_app/screens/disconnected/disconnected_screen.dart';
import 'package:fire_base_app/shared/widgets/loading_widget.dart';
import 'package:fire_base_app/wrappers/connection/bloc/connection_wrapper_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectionWrapper extends StatelessWidget {
  const ConnectionWrapper({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionWrapperBloc, ConnectionWrapperState>(
        builder: (context, state) {
      if (state is ConnectionWrapperConnected) {
        print('Connected State');
        return child;
      }
      if (state is ConnectionWrapperDisconnected) {
        return DisconnectedScreen();
      }
      return Scaffold(body: Center(child: LoadingWidget()));
    });
  }
}
