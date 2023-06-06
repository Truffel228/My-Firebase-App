import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';
import 'package:fire_base_app/services/geolocation/geolocation_service.dart';
import 'package:fire_base_app/services/geolocation/geolocation_service_interface.dart';
import 'package:fire_base_app/shared/entities/entities.dart';
import 'package:fire_base_app/shared/enums/enums.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  late final StreamSubscription _positionSubscription;
  late final StreamSubscription _geoserviceStatusSubscription;
  // LatLng? _userPosition;
  // LatLng? _cameraPosition;
  // List<MapComment> _mapComments = <MapComment>[];
  final GeolocationServiceInterface _geoService;
  final DatabaseServiceInterface _databaseService;
  MapBloc(
      {required GeolocationServiceInterface geoService,
      required DatabaseServiceInterface databaseService})
      : _geoService = geoService,
        _databaseService = databaseService,
        super(
          MapLoading(
            filter: FilterEntity(
              category: Category.all,
              dateTimeRange: DateTimeRange(
                start: DateTime.now(),
                end: DateTime.now(),
              ),
            ),
          ),
        ) {
    /// Загрузка данных для карты
    on<MapInitEvent>(_onMapInitEvent);

    /// Сохранение коментария на карте с экрана карты
    // on<MapSaveCommentEvent>(_onMapSaveCommentEvent);

    /// Позиция пользователя на карте меняется
    on<MapUserPositionChangedEvent>(_onMapUserPositionChangedEvent);

    on<MapCameraPositionChangedEvent>(_onMapCameraPositionChangedEvent);

    on<MapUpdate>(_onMapUpdate);

    on<MapSetFilter>(_onMapSetFilter);

    /// Подписываемся на стрим изменения позиции юзера и прокидываем евент
    _positionSubscription = _geoService.onPositionChanged().listen((position) {
      if (position == null) {
        return;
      }

      add(MapUserPositionChangedEvent(userPosition: position));
    });

    _geoserviceStatusSubscription =
        _geoService.onGeoserviceStatusChanged().listen((status) {
      add(MapInitEvent());
    });
  }
  void _onMapInitEvent(MapInitEvent event, emit) async {
    final now = DateTime.now();
    final prevState = state;

    if (prevState is MapLoaded) {
      emit(MapLoading(filter: prevState.filter));
    } else if (prevState is! MapLoading) {
      emit(
        MapLoading(
          filter: FilterEntity(
            category: Category.all,
            dateTimeRange: DateTimeRange(
              start: DateTime.now(),
              end: DateTime.now(),
            ),
          ),
        ),
      );
    }

    try {
      Position? currentPosition;

      try {
        currentPosition = await _geoService.getPosition();
      } catch (e) {
        if (e is GeoServiceDisabledException) {
          emit(MapGeoServiceDisabled());
          currentPosition = null;
        }

        if (e is NoLocationPermissionException) {
          emit(MapNoGeoPermission());
          currentPosition = null;
        }
      }

      /// Проверять, если [currentPosition] равна null эмитить MapErrorState
      // _userPosition = currentPosition;
      // _cameraPosition = currentPosition;
      final mapComments =
          await _getFilteredMapComments((state as MapLoading).filter);

      emit(
        MapLoaded(
          cameraPosition: prevState is MapLoaded
              ? prevState.cameraPosition
              : currentPosition,
          userPosition: currentPosition,
          mapComments: mapComments,
          filter: FilterEntity(
            category: Category.all,
            dateTimeRange: DateTimeRange(start: now, end: now),
          ),
        ),
      );
    } catch (e) {
      emit(
        MapLoaded(
          cameraPosition: null,
          userPosition: null,
          mapComments: const [],
          filter: FilterEntity(
            category: Category.all,
            dateTimeRange: DateTimeRange(start: now, end: now),
          ),
        ),
      );
    }
  }

  // void _onMapSaveCommentEvent(MapSaveCommentEvent event, emit) async {
  //   final currentState = state;
  //   if (currentState is! MapLoaded) {
  //     return;
  //   }

  //   emit(
  //     currentState.copyWith(isCommentSaving: true),
  //     // Mapl(
  //     //   mapComments: _mapComments,
  //     //   cameraPosition:
  //     //       LatLng(event.mapCommentLatitude, event.mapCommentLongitude),
  //     //   userPosition: _userPosition,
  //     // ),
  //   );
  //   final userId = event.mapCommentUserId;
  //   try {
  //     //TODO: Create Repository for next logic
  //     const uuid = Uuid();

  //     final firstPartId = event.mapCommentUserId.substring(0, 5);
  //     final secondPartId = Random().nextInt(1000).toString().padLeft(3, '0');
  //     final thirdPartId = DateTime.now().toIso8601String();
  //     final mapCommentId = '$firstPartId$secondPartId$thirdPartId';

  //     await _databaseService.saveCommentIdToUser(
  //         userId: userId, commentId: mapCommentId);

  //     final createTimeTs = DateTime.now().millisecondsSinceEpoch;
  //     final mapComment = MapComment(
  //       id: mapCommentId,
  //       comment: event.mapCommentContent,
  //       latitude: event.mapCommentLatitude,
  //       longitude: event.mapCommentLongitude,
  //       userId: userId,
  //       category: event.category,
  //       createdTs: createTimeTs,
  //     );

  //     //TODO: Сделать метод для сохранения коментария в бд
  //     await _databaseService.saveCommentToCollection(mapComment);

  //     /// update state with new comment
  //     final mapComments = await _databaseService.getAllMapComments();
  //     emit(MapUpdateUserProfile());
  //     emit(
  //       MapLoaded(
  //         mapComments: mapComments,
  //         userPosition: currentState.userPosition,
  //         cameraPosition: currentState.cameraPosition,
  //       ),
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void _onMapUserPositionChangedEvent(MapUserPositionChangedEvent event, emit) {
    print('Position changed');
    final currentState = state;
    if (currentState is! MapLoaded) {
      return;
    }
    emit(
      currentState.copyWith(userPosition: event.userPosition),
    );
  }

  void _onMapCameraPositionChangedEvent(
      MapCameraPositionChangedEvent event, emit) {
    final currentState = state;
    if (currentState is! MapLoaded) {
      return;
    }
    emit(
      currentState.copyWith(cameraPosition: event.cameraPosition),
    );
  }

  @override
  Future<void> close() {
    _positionSubscription.cancel();
    _geoserviceStatusSubscription.cancel();
    return super.close();
  }

  FutureOr<void> _onMapUpdate(
    MapUpdate event,
    Emitter<MapState> emit,
  ) async {
    final currentState = state;
    if (currentState is! MapLoaded) {
      return;
    }

    final mapComments = await _getFilteredMapComments(currentState.filter);

    emit(currentState.copyWith(mapComments: mapComments));
  }

  FutureOr<void> _onMapSetFilter(
    MapSetFilter event,
    Emitter<MapState> emit,
  ) async {
    final currentState = state;
    if (currentState is! MapLoaded) {
      return;
    }
    emit(currentState.copyWith(filter: event.filter));
    add(MapUpdate());
  }

  Future<List<MapComment>> _getFilteredMapComments(FilterEntity filter) async {
    final allMapComments = await _databaseService.getAllMapComments();

    final DateTime startDate = DateTime(
      filter.dateTimeRange.start.year,
      filter.dateTimeRange.start.month,
      filter.dateTimeRange.start.day,
      0,
      0,
      0,
    );
    final DateTime endDate = DateTime(
      filter.dateTimeRange.end.year,
      filter.dateTimeRange.end.month,
      filter.dateTimeRange.end.day,
      23,
      59,
      59,
    );

    final List<MapComment> filteredMapComments = [];
    for (var mapComment in allMapComments) {
      final creationDateTime = mapComment.creationDateTime;
      if (creationDateTime.isAfter(startDate) &&
          creationDateTime.isBefore(endDate)) {
        if (filter.category == Category.all) {
          filteredMapComments.add(mapComment);
        } else {
          if (mapComment.category == filter.category) {
            filteredMapComments.add(mapComment);
          }
        }
      }
    }

    return filteredMapComments;
  }
}
