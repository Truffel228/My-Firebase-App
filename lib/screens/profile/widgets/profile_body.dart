import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_data/user_data.dart';
import 'package:fire_base_app/shared/widgets/app_button.dart';
import 'package:fire_base_app/shared/widgets/app_text_field.dart';
import 'package:fire_base_app/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class ProfileBody extends StatefulWidget {
  const ProfileBody(
      {Key? key,
      required this.userData,
      required this.isSaving,
      required this.onSave,
      required this.nameController,
      required this.ageController})
      : super(key: key);
  final UserData userData;
  final bool isSaving;
  final Function(List<MapComment>) onSave;
  final TextEditingController nameController;
  final TextEditingController ageController;

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  late final List<MapComment> mapComments;

  @override
  void initState() {
    super.initState();
    mapComments = widget.userData.mapComments;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
            minRadius: MediaQuery.of(context).size.width * 0.2,
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
                      itemBuilder: (context, index) => Container(
                            width: double.infinity,
                            height: 50,
                            color: Colors.green,
                            child: Text(
                                '${mapComments[index].latitude} ${mapComments[index].longitude} - ${mapComments[index].comment}'),
                          )),
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
}
