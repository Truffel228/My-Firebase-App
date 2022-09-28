import 'package:fire_base_app/models/app_user/app_user.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_data/user_data/user_data.dart';
import 'package:fire_base_app/screens/profile/bloc/profile_bloc.dart';
import 'package:fire_base_app/shared/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileBloc _bloc;
  late final String uid;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    uid = Provider.of<AppUser?>(context, listen: false)!.uid;
    _bloc = context.read<ProfileBloc>()..add(ProfileFetchEvent(uid));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        if (state is ProfileLoaded && state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoaded) {
          _nameController.text = state.userData.name;
          _ageController.text = state.userData.age.toString();
          print('LOADED');
          return ProfileBody(
            userData: state.userData,
            isSaving: false,
            onSave: _onSave,
            nameController: _nameController,
            ageController: _ageController,
            onCommentDelete: _onCommentDelete,
          );
        }
        if (state is ProfileError) {
          _nameController.text = state.userData.name;
          _ageController.text = state.userData.age.toString();
          return ProfileBody(
            userData: state.userData,
            isSaving: false,
            onSave: _onSave,
            nameController: _nameController,
            ageController: _ageController,
            onCommentDelete: _onCommentDelete,
          );
        }
        if (state is ProfileSaving) {
          _nameController.text = state.userData.name;
          _ageController.text = state.userData.age.toString();
          return ProfileBody(
            userData: state.userData,
            isSaving: true,
            onSave: _onSave,
            nameController: _nameController,
            ageController: _ageController,
            onCommentDelete: _onCommentDelete,
          );
        }
        if (state is ProfileLoading) {
          return const Center(
            child: LoadingWidget(),
          );
        }
        return const Center(
          child: Text('Something went wrong'),
        );
      },
    );
  }

  void _onSave(List<MapComment> mapComments) {
    _bloc.add(
      ProfileSaveEvent(
        userId: uid,
        userData: UserData(
          mapComments: mapComments,
          name: _nameController.text,
          age: int.parse(_ageController.text),
        ),
      ),
    );
  }

  void _onCommentDelete(List<MapComment> mapComments, String commentId) {
    _bloc.add(
      ProfileSaveAfterDeleteCommentEvent(
        userId: uid,
        deletedCommentId: commentId,
        userData: UserData(
          mapComments: mapComments,
          name: _nameController.text,
          age: int.parse(_ageController.text),
        ),
      ),
    );
  }
}
