import 'package:fire_base_app/models/app_user/app_user.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/screens/add_map_comment/bloc/add_map_comment_bloc.dart';
import 'package:fire_base_app/screens/add_map_comment/widgets/widgets.dart';
import 'package:fire_base_app/screens/map/bloc/map_bloc.dart';
import 'package:fire_base_app/screens/profile/bloc/profile/profile_bloc.dart';
import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/app_button.dart';
import 'package:fire_base_app/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMapCommentForm extends StatefulWidget {
  const AddMapCommentForm({
    Key? key,
    required this.controller,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  // final void Function(Category) onApplyTap;
  // final VoidCallback onCancelTap;
  final TextEditingController controller;
  final double latitude;
  final double longitude;

  @override
  State<AddMapCommentForm> createState() => _AddMapCommentFormState();
}

class _AddMapCommentFormState extends State<AddMapCommentForm> {
  Category? _category;
  var _categoryError = false;

  final _key = GlobalKey<FormState>();
  late final AddMapCommentBloc _bloc;
  late final String _appUserUid;

  @override
  void initState() {
    _appUserUid = context.read<AppUser?>()!.uid;
    _bloc = context.read<AddMapCommentBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<AddMapCommentBloc, AddMapCommentState>(
        listener: (context, state) {
          if (state is AddMapCommentSuccess) {
            context.read<ProfileBloc>().add(ProfileFetchEvent(_appUserUid));
            context.read<MapBloc>().add(MapUpdate());
            Navigator.of(context).pop();
          }
        },
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
                        child: Text(
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
    );
  }

  void _onApplyTap() {
    if (_key.currentState!.validate()) {
      if (_category != null) {
        _bloc.add(
          AddMapCommentSaveEvent(
            text: widget.controller.text,
            latitude: widget.latitude,
            longitude: widget.longitude,
            category: _category!,
            userId: _appUserUid,
          ),
        );
        // widget.onApplyTap.call(_category!);
      } else {
        setState(() {
          _categoryError = true;
        });
      }
    }
  }

  void _onCancelTap() => Navigator.of(context).pop();
}

enum FileType {
  image,
  video,
}
