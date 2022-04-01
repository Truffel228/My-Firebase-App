import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/app_button.dart';
import 'package:fire_base_app/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class CommentForm extends StatelessWidget {
  const CommentForm(
      {Key? key,
      required this.isCommentOpen,
      required this.onApplyTap,
      required this.onCancelTap,
      required this.isCommentShowInner,
      required this.controller,
      required this.animationDuration})
      : super(key: key);
  final bool isCommentOpen;
  final VoidCallback onApplyTap;
  final VoidCallback onCancelTap;
  final bool isCommentShowInner;
  final TextEditingController controller;
  final Duration animationDuration;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
        child: AnimatedContainer(
          color: Colors.white.withOpacity(0.8),
          width: MediaQuery.of(context).size.width,
          height: isCommentOpen ? MediaQuery.of(context).size.height * 0.4 : 0,
          duration: animationDuration,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Opacity(
              opacity: isCommentShowInner ? 1 : 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppTextField(
                    controller: controller,
                    minLines: 2,
                    maxLines: 5,
                  ),
                  const SizedBox.shrink(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppButton(
                        color: styleDarkRedColor,
                        onPressed: onCancelTap,
                        child: Text('Cancel'),
                      ),
                      AppButton(
                        onPressed: onApplyTap,
                        color: styleGreenColor,
                        child: Text('Apply'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
