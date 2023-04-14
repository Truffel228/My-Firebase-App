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

  AddMapCommentAddFileSuccess addFileSuccess() => AddMapCommentAddFileSuccess(
        attachments: attachments,
        isLoading: isLoading,
      );

  AddMapCommentSuccess success() => const AddMapCommentSuccess(
        attachments: [],
        isLoading: false,
      );

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

class AddMapCommentAddFileSuccess extends AddMapCommentState {
  const AddMapCommentAddFileSuccess({
    List<Attachment> attachments = const [],
    bool isLoading = false,
  }) : super(attachments: attachments, isLoading: isLoading);
}

class AddMapCommentSuccess extends AddMapCommentState {
  const AddMapCommentSuccess({
    List<Attachment> attachments = const [],
    bool isLoading = false,
  }) : super(attachments: attachments, isLoading: isLoading);
}
