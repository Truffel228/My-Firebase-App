part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class MapLoadEvent extends MapEvent {}

class MapSaveCommentEvent extends MapEvent {
  MapSaveCommentEvent({
    required this.mapCommentContent,
    required this.mapCommentLatitude,
    required this.mapCommentLongitude,
    required this.mapCommentUserId,
  });
  final String mapCommentContent;
  final double mapCommentLatitude;
  final double mapCommentLongitude;
  final String mapCommentUserId;
}
