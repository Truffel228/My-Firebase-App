import 'package:fire_base_app/shared/router.dart';
import 'package:fire_base_app/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommentButton extends StatefulWidget {
  const CommentButton({Key? key, this.onTap}) : super(key: key);
  final VoidCallback? onTap;

  @override
  _CommentButtonState createState() => _CommentButtonState();
}

class _CommentButtonState extends State<CommentButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: widget
          .onTap, //() => Navigator.pushNamed(context, Routes.commentFormScreen),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        child: Container(
          width: 170,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.comment,
                color: theme.primaryColor,
              ),
              const SizedBox(width: 5),
              Text(
                'Leave a comment',
                style: theme.textTheme.bodyText1!
                    .copyWith(color: theme.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCommentModalSheet() {
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) {
        return InkWell(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: [
                SizedBox(height: 20),
                Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: AppTextField(
                      minLines: 2,
                      maxLines: 5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
