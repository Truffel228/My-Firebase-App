// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'map_bloc.dart';

@immutable
abstract class MapState extends Equatable {
  const MapState();
}

class MapLoading extends MapState {
  @override
  List<Object?> get props => [];
}

class MapUpdateUserProfile extends MapState {
  @override
  List<Object?> get props => [];
}

class MapLoaded extends MapState {
  final Position? userPosition;
  final Position? cameraPosition;
  final List<MapComment> mapComments;
  final bool isCommentSaving;

  const MapLoaded({
    required this.cameraPosition,
    required this.userPosition,
    required this.mapComments,
    this.isCommentSaving = false,
  });

  @override
  List<Object?> get props => [
        userPosition,
        mapComments,
        cameraPosition,
        isCommentSaving,
      ];

  MapLoaded copyWith({
    Position? userPosition,
    Position? cameraPosition,
    List<MapComment>? mapComments,
    bool? isCommentSaving,
  }) {
    return MapLoaded(
      userPosition: userPosition ?? this.userPosition,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      mapComments: mapComments ?? this.mapComments,
      isCommentSaving: isCommentSaving ?? this.isCommentSaving,
    );
  }
}

class MapGeoServiceDisabled extends MapState {
  @override
  List<Object?> get props => [];
}

class MapNoGeoPermission extends MapState {
  @override
  List<Object?> get props => [];
}
