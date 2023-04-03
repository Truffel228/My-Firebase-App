import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/app_button.dart';
import 'package:fire_base_app/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class CommentForm extends StatefulWidget {
  const CommentForm({
    Key? key,
    required this.isCommentOpen,
    required this.onApplyTap,
    required this.onCancelTap,
    required this.isCommentShowInner,
    required this.controller,
    required this.animationDuration,
  }) : super(key: key);
  final bool isCommentOpen;
  final VoidCallback onApplyTap;
  final VoidCallback onCancelTap;
  final bool isCommentShowInner;
  final TextEditingController controller;
  final Duration animationDuration;

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
        child: AnimatedContainer(
          color: Colors.white.withOpacity(0.8),
          width: MediaQuery.of(context).size.width,
          height: widget.isCommentOpen
              ? MediaQuery.of(context).size.height * 0.4
              : 0,
          duration: widget.animationDuration,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Opacity(
              opacity: widget.isCommentShowInner ? 1 : 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Form(
                    key: _key,
                    child: AppTextField(
                      validator: (text) => text!.isEmpty
                          ? 'Text of your comment cannot be empty'
                          : null,
                      controller: widget.controller,
                      minLines: 2,
                      maxLines: 5,
                    ),
                  ),
                  const SizedBox.shrink(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppButton(
                        color: darkRedColor,
                        onPressed: widget.onCancelTap,
                        child: Text('Cancel'),
                      ),
                      AppButton(
                        onPressed: () {
                          if (_key.currentState!.validate()) {
                            widget.onApplyTap();
                          }
                        },
                        color: greenColor,
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
