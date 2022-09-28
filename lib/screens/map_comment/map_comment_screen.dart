import 'package:fire_base_app/models/user_data/user_data/user_data.dart';
import 'package:fire_base_app/screens/map_comment/bloc/map_comment_screen_bloc.dart';
import 'package:fire_base_app/shared/router.dart';
import 'package:fire_base_app/shared/widgets/app_text_field.dart';
import 'package:fire_base_app/shared/widgets/loading_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MapCommentScreen extends StatefulWidget {
  const MapCommentScreen(
      {Key? key, required this.comment, required this.userId})
      : super(key: key);
  final String comment;
  final String userId;

  @override
  State<MapCommentScreen> createState() => _MapCommentScreenState();
}

class _MapCommentScreenState extends State<MapCommentScreen> {

  @override
  void initState() {
    super.initState();
    context
        .read<MapCommentScreenBloc>()
        .add(MapCommentScreenLoadEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<MapCommentScreenBloc, MapCommentScreenState>(
      builder: (context, state) {
        if (state is MapCommentScreenLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Comment from user: ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: state.userData.name,
                          style: TextStyle(color: theme.primaryColor),
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
                  initialValue: widget.comment,
                ),
              ],
            ),
          );
        }
        if (state is MapCommentScreenLoading) {
          return Center(child: LoadingWidget());
        }
        return Text('error');
      },
    );
  }

  void _openUserProfileViewScreen(UserData userData) =>
      Navigator.pushNamed(context, Routes.userProfileView, arguments: userData);
}
