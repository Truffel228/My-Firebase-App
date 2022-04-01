import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';
import 'package:fire_base_app/services/geo/geolocation_service_interface.dart';
import 'package:meta/meta.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final GeolocationServiceInterface _geoService;
  final DatabaseServiceInterface _databaseService;
  MapBloc(
      {required GeolocationServiceInterface geoService,
      required DatabaseServiceInterface databaseService})
      : _geoService = geoService,
        _databaseService = databaseService,
        super(MapLoading()) {
    on<MapLoadEvent>(_onMapLoadEvent);
    on<MapSaveCommentEvent>(_onMapSaveCommentEvent);
  }
  void _onMapLoadEvent(MapLoadEvent event, emit) async {
    try {
      final position = await _geoService.getPosition();
      print('here');
      emit(
        MapLoaded(position: position),
      );
    } catch (e) {
      emit(
        MapLoaded(position: null),
      );
    }
  }

  void _onMapSaveCommentEvent(MapSaveCommentEvent event, emit) async {
    final userId = event.mapCommentUserId;
    print('here');
    try {
      //TODO: Create Repository for next logic
      const uuid = Uuid();
      final mapCommentId = uuid.v1(); /// Unique id based on time


      await _databaseService.saveCommentIdToUser(
          userId: userId, commentUid: mapCommentId);
      final mapComment = MapComment(
          id: mapCommentId,
          comment: event.mapCommentContent,
          latitude: event.mapCommentLatitude,
          longitude: event.mapCommentLongitude,
          userId: userId);
      await _databaseService.saveCommentToCollection(mapComment);

      print('ready');
    } catch (e) {}
  }
}
