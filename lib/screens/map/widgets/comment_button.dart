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
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: const BoxDecoration(color: Colors.white),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.comment,
                color: theme.primaryColor,
              ),
              const SizedBox(width: 6),
              Text(
                'Leave a comment',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
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
      shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
      context: context,
      builder: (context) {
        return InkWell(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              children: const [
                SizedBox(height: 20),
                Form(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
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
