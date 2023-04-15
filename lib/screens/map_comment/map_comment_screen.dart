import 'package:fire_base_app/models/user_model/user_model/user_model.dart';
import 'package:fire_base_app/screens/map_comment/bloc/map_comment_bloc.dart';
import 'package:fire_base_app/screens/map_comment/widgets/widgets.dart';
import 'package:fire_base_app/shared/enums/enums.dart';
import 'package:fire_base_app/shared/router.dart';
import 'package:fire_base_app/shared/widgets/app_text_field.dart';
import 'package:fire_base_app/shared/widgets/loading_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapCommentScreen extends StatefulWidget {
  const MapCommentScreen({
    Key? key,
    required this.mapCommentId,
    required this.userId,
  }) : super(key: key);

  final String mapCommentId;
  final String userId;

  @override
  State<MapCommentScreen> createState() => _MapCommentScreenState();
}

class _MapCommentScreenState extends State<MapCommentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MapCommentBloc>().add(MapCommentLoad(
          mapCommentId: widget.mapCommentId,
          userId: widget.userId,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<MapCommentBloc, MapCommentState>(
      builder: (context, state) {
        if (state is MapCommentLoaded) {
          final imageFiles = state.mapComment.files
              .where((element) => element.fileType == FileType.image)
              .toList();

          final mapComment = state.mapComment;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: CategoryTimeRow(
                    category: mapComment.category.getTitle(context),
                    time: mapComment.creationTime,
                  ),
                ),
                const SizedBox(height: 24),
                //TODO: Separate widget
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Comment by user: ',
                                style: theme.textTheme.bodyMedium,
                              ),
                              TextSpan(
                                text: state.userData.name,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.primaryColor,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => _openUserProfileViewScreen(
                                      state.userData),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      AppTextField(
                        minLines: 2,
                        maxLines: 10,
                        enabled: false,
                        initialValue: mapComment.comment,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                state.mediaAttachmentLoading
                    ? SizedBox(
                        height: 176,
                        child: UnconstrainedBox(
                          child: CircularProgressIndicator(
                            color: theme.primaryColor,
                          ),
                        ),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (state.images.isNotEmpty)
                            MedialAttachmentImages(images: state.images),
                          const SizedBox(height: 8),
                          if (state.videos.isNotEmpty)
                            MedialAttachmentVideos(videos: state.videos),
                        ],
                      ),
              ],
            ),
          );
        }
        if (state is MapCommentLoading) {
          //TODO: Add shimmer
          return const Center(child: LoadingWidget());
        }
        return const Text('error');
      },
    );
  }

  void _openUserProfileViewScreen(UserModel userData) =>
      Navigator.pushNamed(context, Routes.userProfileView, arguments: userData);
}
