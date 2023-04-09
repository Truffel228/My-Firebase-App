import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/screens/add_map_comment/bloc/add_map_comment_bloc.dart';
import 'package:fire_base_app/screens/add_map_comment/widgets/widgets.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';
import 'package:fire_base_app/services/image_picker_service.dart';
import 'package:fire_base_app/shared/locator.dart';
import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/app_button.dart';
import 'package:fire_base_app/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMapCommentForm extends StatefulWidget {
  const AddMapCommentForm({
    Key? key,
    required this.onApplyTap,
    required this.onCancelTap,
    required this.controller,
  }) : super(key: key);
  final void Function(Category) onApplyTap;
  final VoidCallback onCancelTap;
  final TextEditingController controller;

  @override
  State<AddMapCommentForm> createState() => _AddMapCommentFormState();
}

class _AddMapCommentFormState extends State<AddMapCommentForm> {
  Category? _category;
  var _categoryError = false;

  final _key = GlobalKey<FormState>();
  late final AddMapCommentBloc _bloc;

  @override
  void initState() {
    _bloc = AddMapCommentBloc(
      databaseService: locator<DatabaseServiceInterface>(),
      imagePickerService: locator<ImagePickerService>(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: WillPopScope(
        onWillPop: () async {
          widget.controller.clear();
          return true;
        },
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: BlocBuilder<AddMapCommentBloc, AddMapCommentState>(
            builder: (context, state) {
              return Container(
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                padding: const EdgeInsets.only(bottom: 24, top: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedOpacity(
                            duration: const Duration(milliseconds: 200),
                            opacity: _categoryError ? 1 : 0,
                            child:  Text(
                              'Category is needed',
                              style: TextStyle(color: AppColors.redColor),
                            ),
                          ),
                          DropdownButton<Category>(
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
                        ],
                      ),
                    ),
                    Attachments(
                      attachments: state.attachments,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
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
              );
            },
          ),
        ),
      ),
    );
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

enum FileType {
  image,
  video,
}
