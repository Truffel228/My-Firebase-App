part of 'map_comment_bloc.dart';

abstract class MapCommentState extends Equatable {
  const MapCommentState();
}

class MapCommentLoading extends MapCommentState {
  @override
  List<Object> get props => [];
}

class MapCommentLoaded extends MapCommentState {
  const MapCommentLoaded({
    required this.mapComment,
    required this.userData,
    required this.images,
    required this.videos,
    required this.mediaAttachmentLoading,
  });

  final MapComment mapComment;
  final UserModel userData;
  final List<MediaAttachment> images;
  final List<MediaAttachment> videos;
  final bool mediaAttachmentLoading;

  @override
  List<Object?> get props =>
      [mapComment, userData, images, videos, mediaAttachmentLoading];
}
