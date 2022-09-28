import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fire_base_app/models/user_data/user_data/user_data.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';

part 'map_comment_screen_event.dart';
part 'map_comment_screen_state.dart';

class MapCommentScreenBloc
    extends Bloc<MapCommentScreenEvent, MapCommentScreenState> {
  final DatabaseServiceInterface _databaseService;

  MapCommentScreenBloc({required DatabaseServiceInterface databaseService})
      : _databaseService = databaseService,
        super(MapCommentScreenLoading()) {
    on<MapCommentScreenLoadEvent>(_onMapCommentScreenLoadEvent);
  }
  void _onMapCommentScreenLoadEvent(
      MapCommentScreenLoadEvent event, emit) async {
    emit(MapCommentScreenLoading());
    try {
      final userData = await _databaseService.getUserData(event.userId);
      emit(MapCommentScreenLoaded(userData: userData));
    } catch (e) {}
  }
}
