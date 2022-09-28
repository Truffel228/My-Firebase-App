import 'package:fire_base_app/models/user_data/user_data/user_data.dart';
import 'package:fire_base_app/shared/widgets/map_comment_list_item.dart';
import 'package:fire_base_app/shared/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserData userData =
        ModalRoute.of(context)?.settings.arguments as UserData;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                  enabled: false,
                  initialValue: userData.name,
                  hintText: 'Name',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: AppTextField(
                  enabled: false,
                  initialValue: userData.age.toString(),
                  hintText: 'Age',
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 20),
          userData.mapComments.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                    itemCount: userData.mapComments.length,
                    itemBuilder: (context, index) => MapCommentListItem(
                      enabled: false,
                      index: index,
                      mapComment: userData.mapComments[index],
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
}
