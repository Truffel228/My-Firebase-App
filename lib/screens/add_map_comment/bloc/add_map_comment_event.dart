part of 'add_map_comment_bloc.dart';

@immutable
abstract class AddMapCommentEvent extends Equatable {
  const AddMapCommentEvent();
}

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
