part of 'map_bloc.dart';

@immutable
abstract class MapState extends Equatable {
  const MapState();
}

class MapLoading extends MapState {
  @override
  List<Object?> get props => [];
}

class MapLoaded extends MapState {
  final LatLng? userPosition;
  final LatLng? cameraPosition;
  final List<MapComment> mapComments;
  MapLoaded(
      {required this.cameraPosition,
      required this.userPosition,
      required this.mapComments});

  @override
  List<Object?> get props => [userPosition, mapComments, cameraPosition];
}

class MapCommentSaving extends MapLoaded {

  MapCommentSaving(
      {required LatLng? cameraPosition,
      required LatLng? userPosition,
      required List<MapComment> mapComments})
      : super(
            cameraPosition: cameraPosition,
            userPosition: userPosition,
            mapComments: mapComments);

  @override
  List<Object?> get props => [mapComments, userPosition, cameraPosition];
}
