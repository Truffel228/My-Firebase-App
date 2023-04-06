import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/app_button.dart';
import 'package:fire_base_app/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class CommentForm extends StatefulWidget {
  const CommentForm({
    Key? key,
    required this.onApplyTap,
    required this.onCancelTap,
    required this.controller,
  }) : super(key: key);
  final void Function(Category) onApplyTap;
  final VoidCallback onCancelTap;
  final TextEditingController controller;

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  Category? _category;
  var _categoryError = false;

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.controller.clear();
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          decoration: const BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _categoryError ? 1 : 0,
                child: const Text(
                  'Category is needed',
                  style: TextStyle(color: AppColors.redColor),
                ),
              ),
              Center(
                child: DropdownButton<Category>(
                  alignment: Alignment.center,
                  hint: Text('Category'),
                  value: _category,
                  onChanged: (value) => setState(() {
                    _category = value;
                    _categoryError = false;
                  }),
                  items: Category.values
                      .map(
                        (e) => DropdownMenuItem<Category>(
                          value: e,
                          child: Text(e.getTitle(context)),
                        ),
                      )
                      .toList(),
                ),
              ),
              Form(
                key: _key,
                child: AppTextField(
                  controller: widget.controller,
                  validator: (text) => text!.isEmpty
                      ? 'Text of your comment cannot be empty'
                      : null,
                  minLines: 2,
                  maxLines: 5,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppButton(
                    color: AppColors.darkRedColor,
                    onTap: _onCancelTap,
                    title: 'Cancel',
                  ),
                  AppButton(
                    onTap: _onApplyTap,
                    color: AppColors.greenColor,
                    title: 'Apply',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    //   return InkWell(
    //     onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
    //     child: ClipRRect(
    //       borderRadius: const BorderRadius.vertical(bottom: Radius.circular(25)),
    //       child: AnimatedContainer(
    //         color: Colors.white.withOpacity(0.8),
    //         width: MediaQuery.of(context).size.width,
    //         height: widget.isCommentOpen
    //             ? MediaQuery.of(context).size.height * 0.4
    //             : 0,
    //         duration: widget.animationDuration,
    //         child: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 10.0),
    //           child: Opacity(
    //             opacity: widget.isCommentShowInner ? 1 : 0,
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //               children: [
    //                 Form(
    //                   key: _key,
    //                   child: AppTextField(
    //                     validator: (text) => text!.isEmpty
    //                         ? 'Text of your comment cannot be empty'
    //                         : null,
    //                     controller: widget.controller,
    //                     minLines: 2,
    //                     maxLines: 5,
    //                   ),
    //                 ),
    //                 const SizedBox.shrink(),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                   children: [
    //                     AppButton(
    //                       color: darkRedColor,
    //                       onPressed: widget.onCancelTap,
    //                       child: Text('Cancel'),
    //                     ),
    //                     AppButton(
    //                       onPressed: () {
    //                         if (_key.currentState!.validate()) {
    //                           widget.onApplyTap();
    //                         }
    //                       },
    //                       color: greenColor,
    //                       child: Text('Apply'),
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }
  }

  void _onApplyTap() {
    if (_key.currentState!.validate()) {
      if (_category != null) {
        widget.onApplyTap.call(_category!);
      } else {
        setState(() {
          _categoryError = true;
        });
      }
    }
  }

  void _onCancelTap() {
    Navigator.of(context).pop();
    widget.controller.clear();
  }
}
