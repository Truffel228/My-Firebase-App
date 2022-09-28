import 'package:fire_base_app/models/app_user/app_user.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_data/user_data/user_data.dart';
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
  }) : super(key: key);
  final UserData userData;
  final bool isSaving;
  final Function(List<MapComment>) onSave;
  final TextEditingController nameController;
  final TextEditingController ageController;
  final Function(List<MapComment>, String) onCommentDelete;

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  late final List<MapComment> mapComments;
  late final String userId;

  @override
  void initState() {
    super.initState();
    mapComments = widget.userData.mapComments;
    userId = context.read<AppUser?>()!.uid;
    print('Profile Body init');
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          CircleAvatar(
            radius: MediaQuery.of(context).size.width * 0.2,
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
                  onPressed: _onSave,
                  child: Text('Save'),
                ),
          const SizedBox(height: 20),
          mapComments.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: mapComments.length,
                    itemBuilder: (context, index) => Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) =>
                                _onCommentDelete(index, mapComments[index].id),
                            icon: FontAwesomeIcons.trash,
                            backgroundColor: styleDarkRedColor,
                          ),
                        ],
                      ),
                      child: MapCommentListItem(
                        enabled: true,
                        onItemDelete: () =>
                            _onCommentDelete(index, mapComments[index].id),
                        index: index,
                        mapComment: mapComments[index],
                      ),
                    ),
                  ),
                )
              : const Expanded(
                  child: Center(
                    child: Text('Your list of comments is empty'),
                  ),
                ),
        ],
      ),
    );
  }

  void _onSave() {
    widget.onSave(mapComments);
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _onCommentDelete(int index, String commentId) {
    setState(() {
      mapComments.removeAt(index);
    });

    /// После того как удалили коментарий из списка кидаем ивент на удаление,
    /// в нём на сервер будет сохранятся новый список коментариев уже без удалённого
    /// коментария
    widget.onCommentDelete(mapComments, commentId);
  }
}
