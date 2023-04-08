part of 'add_map_comment_bloc.dart';

class AddMapCommentState extends Equatable {
  const AddMapCommentState({
    this.files = const [],
    this.isLoading = false,
  });

  final List<File> files;
  final bool isLoading;

  @override
  List<Object?> get props => [files, isLoading];
}
