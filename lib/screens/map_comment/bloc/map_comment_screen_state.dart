part of 'map_comment_screen_bloc.dart';

abstract class MapCommentScreenState extends Equatable {
  const MapCommentScreenState();
}

class MapCommentScreenLoading extends MapCommentScreenState {
  @override
  List<Object> get props => [];
}

class MapCommentScreenLoaded extends MapCommentScreenState {
  MapCommentScreenLoaded({required this.userData});
  final UserData userData;
  @override
  List<Object?> get props => [userData];
}
