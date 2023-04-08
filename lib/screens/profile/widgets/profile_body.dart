import 'package:cached_network_image/cached_network_image.dart';
import 'package:fire_base_app/models/app_user/app_user.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_model/user_model/user_model.dart';
import 'package:fire_base_app/screens/profile/widgets/profile_avatar.dart';
import 'package:fire_base_app/screens/profile/widgets/profile_image_bottom_sheet.dart';
import 'package:fire_base_app/shared/style.dart';
import 'package:fire_base_app/shared/widgets/map_comment_list_item.dart';
import 'package:fire_base_app/shared/widgets/app_button.dart';
import 'package:fire_base_app/shared/widgets/app_text_field.dart';
import 'package:fire_base_app/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody({
    Key? key,
    required this.userData,
    required this.isSaving,
    required this.onSave,
    required this.nameController,
    required this.ageController,
    required this.onCommentDelete,
    required this.onPickGalleryTap,
    required this.onTakePhotoTap,
    required this.onDeletePhotoTap,
  }) : super(key: key);
  final UserModel userData;
  final bool isSaving;
  final Function(List<MapComment>) onSave;
  final TextEditingController nameController;
  final TextEditingController ageController;
  final Function(String) onCommentDelete;
  final VoidCallback onPickGalleryTap;
  final VoidCallback onTakePhotoTap;
  final VoidCallback onDeletePhotoTap;

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  late final String userId;

  @override
  void initState() {
    super.initState();
    userId = context.read<AppUser?>()!.uid;
    print('Profile Body init');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          InkWell(
            onTap: _onAvatarTap,
            child: ProfileAvatar(
              avatarUrl: widget.userData.profileImageUrl,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: AppTextField(
                  controller: widget.nameController,
                  hintText: 'Name',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: AppTextField(
                  controller: widget.ageController,
                  hintText: 'Age',
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 20),
          widget.isSaving
              ? const LoadingWidget()
              : AppButton(
                  onTap: _onSave,
                  title: 'Save',
                ),
          const SizedBox(height: 20),
          widget.userData.mapComments.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: widget.userData.mapComments.length,
                    itemBuilder: (context, index) => Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) => widget.onCommentDelete(
                                widget.userData.mapComments[index].id),
                            icon: FontAwesomeIcons.trash,
                            backgroundColor: AppColors.darkRedColor,
                          ),
                        ],
                      ),
                      child: MapCommentListItem(
                        enabled: true,
                        onItemDelete: () => widget.onCommentDelete(
                            widget.userData.mapComments[index].id),
                        index: index,
                        mapComment: widget.userData.mapComments[index],
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Center(
                    child: Text(
                      'Your list of comments is empty',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  void _onSave() {
    widget.onSave(widget.userData.mapComments);
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _onAvatarTap() => showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.whiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) => PickFileBottomSheet(
          onGalleryTap: widget.onPickGalleryTap,
          onCameraTap: widget.onTakePhotoTap,
          onDeleteTap: widget.onDeletePhotoTap,
        ),
      );
}
