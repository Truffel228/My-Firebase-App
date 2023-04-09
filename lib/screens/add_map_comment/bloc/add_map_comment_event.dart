part of 'add_map_comment_bloc.dart';

@immutable
abstract class AddMapCommentEvent extends Equatable {
  const AddMapCommentEvent();
}

// class AddMapCommentInit extends AddMapCommentEvent {
//   const AddMapCommentInit();

//   @override
//   List<Object?> get props => [];
// }

class AddMapCommentFileFromGallery extends AddMapCommentEvent {
  const AddMapCommentFileFromGallery(this.fileType);

  final FileType fileType;

  @override
  List<Object?> get props => [fileType];
}

class AddMapCommentFileFromCamera extends AddMapCommentEvent {
  const AddMapCommentFileFromCamera(this.fileType);

  final FileType fileType;

  @override
  List<Object?> get props => [fileType];
}

class AddMapCommentAttachmentDelete extends AddMapCommentEvent {
  const AddMapCommentAttachmentDelete(this.path);
  final String path;
  @override
  List<Object?> get props => [path];
}

class AddMapCommentSaveEvent extends AddMapCommentEvent {
  const AddMapCommentSaveEvent({
    required this.text,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.category,
  });

  final String text;
  final String userId;
  final double latitude;
  final double longitude;
  final Category category;

  @override
  List<Object?> get props => [text, latitude, longitude, category, userId];
}
