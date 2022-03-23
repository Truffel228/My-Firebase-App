import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fire_base_app/services/geo/geo_service_interface.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GeoServiceInterface _geoService;
  MapBloc({required GeoServiceInterface geoService})
      : _geoService = geoService,
        super(MapLoading()) {
    on<MapLoadEvent>(_onMapLoadEvent);
  }
  void _onMapLoadEvent(event, emit) async {
    try {
      final position = await _geoService.getPosition();
      print('$position');
      emit(
        MapLoaded(position: position),
      );
    } catch (e) {
      emit(
        MapLoaded(position: null),
      );
    }
  }
}
