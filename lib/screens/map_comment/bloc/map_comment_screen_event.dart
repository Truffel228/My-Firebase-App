part of 'map_comment_screen_bloc.dart';

abstract class MapCommentScreenEvent extends Equatable {
  const MapCommentScreenEvent();
}

class MapCommentScreenLoadEvent extends MapCommentScreenEvent {
  MapCommentScreenLoadEvent({required this.userId});
  final String userId;
  @override
  List<Object?> get props => [userId];
}
