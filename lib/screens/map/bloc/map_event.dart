part of 'map_bloc.dart';

@immutable
abstract class MapEvent extends Equatable {
  const MapEvent();
}

class MapLoadEvent extends MapEvent {
  @override
  List<Object?> get props => [];
}

class MapSaveCommentEvent extends MapEvent {
  const MapSaveCommentEvent({
    required this.mapCommentContent,
    required this.mapCommentLatitude,
    required this.mapCommentLongitude,
    required this.mapCommentUserId,
    required this.category,
  });
  final String mapCommentContent;
  //TODO: Убрать lat long
  final double mapCommentLatitude;
  final double mapCommentLongitude;
  final String mapCommentUserId;
  final Category category;

  @override
  List<Object?> get props => [
        mapCommentContent,
        mapCommentLatitude,
        mapCommentLongitude,
        mapCommentUserId
      ];
}

class MapUpdate extends MapEvent {
  @override
  List<Object?> get props => [];
}

class MapUserPositionChangedEvent extends MapEvent {
  MapUserPositionChangedEvent({required this.userPosition});
  final LatLng userPosition;
  @override
  List<Object?> get props => [];
}

class MapCameraPositionChangedEvent extends MapEvent {
  MapCameraPositionChangedEvent({required this.cameraPosition});
  final LatLng cameraPosition;

  @override
  List<Object?> get props => [cameraPosition];
}
