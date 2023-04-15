part of 'map_comment_bloc.dart';

abstract class MapCommentEvent extends Equatable {
  const MapCommentEvent();
}

class MapCommentLoad extends MapCommentEvent {
  const MapCommentLoad({
    required this.userId,
    required this.mapCommentId,
  });

  final String userId;
  final String mapCommentId;

  @override
  List<Object?> get props => [userId];
}
