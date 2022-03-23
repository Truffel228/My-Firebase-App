import 'package:fire_base_app/screens/map/bloc/map_bloc.dart';
import 'package:fire_base_app/screens/map/widgets/map_widget.dart';
import 'package:fire_base_app/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<MapBloc>()..add(MapLoadEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(builder: (context, state) {
      if (state is MapLoading) {
        return Center(
          child: LoadingWidget(),
        );
      }
      if (state is MapLoaded) {
        return MapWidget(
          userPosition: state.position,
        );
      }
      return Center(
        child: Text('dalfafdk'),
      );
    });
  }
}
