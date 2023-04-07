import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_model/user_model/user_model.dart';
import 'package:fire_base_app/screens/map_comment/bloc/map_comment_screen_bloc.dart';
import 'package:fire_base_app/screens/map_comment/widgets/widgets.dart';
import 'package:fire_base_app/shared/router.dart';
import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/app_text_field.dart';
import 'package:fire_base_app/shared/widgets/loading_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapCommentScreen extends StatefulWidget {
  const MapCommentScreen({
    Key? key,
    required this.mapComment,
  }) : super(key: key);

  final MapComment mapComment;

  @override
  State<MapCommentScreen> createState() => _MapCommentScreenState();
}

class _MapCommentScreenState extends State<MapCommentScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<MapCommentScreenBloc>()
        .add(MapCommentScreenLoadEvent(userId: widget.mapComment.userId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<MapCommentScreenBloc, MapCommentScreenState>(
      builder: (context, state) {
        if (state is MapCommentScreenLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CategoryTimeRow(
                  category: widget.mapComment.category.getTitle(context),
                  time: widget.mapComment.creationTime,
                ),
                const SizedBox(height: 24),
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
                            ..onTap = () =>
                                _openUserProfileViewScreen(state.userData),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                AppTextField(
                  minLines: 2,
                  maxLines: 10,
                  enabled: false,
                  initialValue: widget.mapComment.comment,
                ),
              ],
            ),
          );
        }
        if (state is MapCommentScreenLoading) {
          //TODO: Add shimmer
          return Center(child: LoadingWidget());
        }
        return Text('error');
      },
    );
  }

  void _openUserProfileViewScreen(UserModel userData) =>
      Navigator.pushNamed(context, Routes.userProfileView, arguments: userData);
}
