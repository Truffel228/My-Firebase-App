import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';
import 'package:fire_base_app/services/geolocation/geolocation_service_interface.dart';
import 'package:meta/meta.dart';
import 'package:latlong2/latlong.dart';
import 'package:uuid/uuid.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  late final StreamSubscription _positionSubscription;
  LatLng? _userPosition;
  LatLng? _cameraPosition;
  List<MapComment> _mapComments = <MapComment>[];
  final GeolocationServiceInterface _geoService;
  final DatabaseServiceInterface _databaseService;
  MapBloc(
      {required GeolocationServiceInterface geoService,
      required DatabaseServiceInterface databaseService})
      : _geoService = geoService,
        _databaseService = databaseService,
        super(MapLoading()) {
    /// Загрузка данных для карты
    on<MapLoadEvent>(_onMapLoadEvent);

    /// Сохранение коментария на карте с экрана карты
    on<MapSaveCommentEvent>(_onMapSaveCommentEvent);

    /// Позиция пользователя на карте меняется
    on<MapUserPositionChangedEvent>(_onMapUserPositionChangedEvent);

    on<MapCameraPositionChangedEvent>(_onMapCameraPositionChangedEvent);

    /// Подписываемся на стрим изменения позиции юзера и прокидываем евент
    _positionSubscription = _geoService.onPositionChanged().listen((latLng) {
      // if (latLng == null) {
      //   return;
      // }
      _userPosition = latLng;
      add(MapUserPositionChangedEvent(userPosition: _userPosition!));
    });
  }
  void _onMapLoadEvent(MapLoadEvent event, emit) async {
    emit(MapLoading());
    try {
      final currentPosition = await _geoService.getPosition();

      /// Проверять, если [currentPosition] равна null эмитить MapErrorState
      _userPosition = currentPosition;
      _cameraPosition = currentPosition;
      _mapComments = await _databaseService.getAllMapComments();
      emit(
        MapLoaded(
            cameraPosition: _cameraPosition,
            userPosition: _userPosition,
            mapComments: _mapComments),
      );
    } catch (e) {
      emit(
        MapLoaded(
            cameraPosition: null, userPosition: null, mapComments: const []),
      );
    }
  }

  void _onMapSaveCommentEvent(MapSaveCommentEvent event, emit) async {
    emit(
      MapCommentSaving(
        mapComments: _mapComments,
        cameraPosition:
            LatLng(event.mapCommentLatitude, event.mapCommentLongitude),
        userPosition: _userPosition,
      ),
    );
    final userId = event.mapCommentUserId;
    try {
      //TODO: Create Repository for next logic
      const uuid = Uuid();

      /// Unique id based on time
      final mapCommentId = uuid.v1();

      await _databaseService.saveCommentIdToUser(
          userId: userId, commentId: mapCommentId);
      final mapComment = MapComment(
          id: mapCommentId,
          comment: event.mapCommentContent,
          latitude: event.mapCommentLatitude,
          longitude: event.mapCommentLongitude,
          userId: userId);
      await _databaseService.saveCommentToCollection(mapComment);

      /// update state with new comment
      _mapComments = await _databaseService.getAllMapComments();
      emit(
        MapLoaded(
          mapComments: _mapComments,
          userPosition: _userPosition,
          cameraPosition:
              LatLng(event.mapCommentLatitude, event.mapCommentLongitude),
        ),
      );
    } catch (e) {}
  }

  void _onMapUserPositionChangedEvent(MapUserPositionChangedEvent event, emit) {
    print('Position changed');
    // final state = this.state as MapLoaded;
    // final List<MapComment> mapComments = state.mapComments;
    emit(
      MapLoaded(
          userPosition: event.userPosition,
          cameraPosition: _cameraPosition,
          mapComments: _mapComments),
    );
  }

  void _onMapCameraPositionChangedEvent(MapCameraPositionChangedEvent event, emitter){
    _cameraPosition = event.cameraPosition;
  }

  @override
  Future<void> close() {
    _positionSubscription.cancel();
    return super.close();
  }
}
