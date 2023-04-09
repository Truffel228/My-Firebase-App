// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_map_comment_bloc.dart';

class AddMapCommentState extends Equatable {
  const AddMapCommentState({
    this.attachments = const [],
    this.isLoading = false,
  });

  final List<Attachment> attachments;
  final bool isLoading;

  @override
  List<Object?> get props => [attachments, isLoading];

  AddMapCommentState copyWith({
    List<Attachment>? attachments,
    bool? isLoading,
  }) {
    return AddMapCommentState(
      attachments: attachments ?? this.attachments,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class Attachment {
  const Attachment(
    this.file,
    this.fileType, {
    this.videoPreview,
    this.videoDurationSec,
  });
  final File file;
  final FileType fileType;
  final File? videoPreview;
  final int? videoDurationSec;
}
