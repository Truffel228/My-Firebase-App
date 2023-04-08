import 'dart:collection';

import 'package:fire_base_app/models/app_user/app_user.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_model/user_model/user_model.dart';
import 'package:fire_base_app/screens/map/bloc/map_bloc.dart';
import 'package:fire_base_app/screens/profile/bloc/profile/profile_bloc.dart';
import 'package:fire_base_app/screens/profile/bloc/profile_image/profile_image_bloc.dart';
import 'package:fire_base_app/services/database/database_service.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';
import 'package:fire_base_app/services/image_picker_service.dart';
import 'package:fire_base_app/shared/locator.dart';
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
  late final ProfileImageBloc _profileImageBloc;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    uid = Provider.of<AppUser?>(context, listen: false)!.uid;
    _bloc = context.read<ProfileBloc>()..add(ProfileFetchEvent(uid));
    _profileImageBloc = ProfileImageBloc(
      databaseService: locator<DatabaseServiceInterface>(),
      imagePickerService: locator<ImagePickerService>(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileImageBloc, ProfileImageState>(
      bloc: _profileImageBloc,
      listener: (context, state) {
        if (state is ProfileImageNoCameraAccess) {}
        if (state is ProfileImageNoGalleryAccess) {}
        //TODO: success loas
        // no access
        // success delete
        if (state is ProfileImageLoadSuccess) {
          _bloc.add(ProfileFetchEvent(uid));
        }
        if (state is ProfileImageDeleteSuccess) {
          _bloc.add(ProfileFetchEvent(uid));
        }
      },
      child: BlocConsumer<ProfileBloc, ProfileState>(
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
          if (state is ProfileCommentDeleteSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Comment has been deleted'),
              ),
            );
            context.read<MapBloc>().add(MapUpdate());
          }
        },
        builder: (context, state) {
          if (state is ProfileLoaded) {
            _nameController.text = state.userData.name;
            _ageController.text = state.userData.age.toString();
            return ProfileBody(
              onPickGalleryTap: _onPickGalleryTap,
              onTakePhotoTap: _onTakePhotoTap,
              onDeletePhotoTap: _onDeletePhotoTap,
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
              onPickGalleryTap: _onPickGalleryTap,
              onTakePhotoTap: _onTakePhotoTap,
              onDeletePhotoTap: _onDeletePhotoTap,
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
              onPickGalleryTap: _onPickGalleryTap,
              onTakePhotoTap: _onTakePhotoTap,
              onDeletePhotoTap: _onDeletePhotoTap,
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
      ),
    );
  }

  void _onSave(List<MapComment> mapComments) {
    _bloc.add(
      ProfileSaveEvent(
        userId: uid,
        userData: UserModel(
          mapComments: mapComments,
          name: _nameController.text,
          age: int.parse(_ageController.text),
        ),
      ),
    );
  }

  void _onCommentDelete(String commentId) {
    _bloc.add(
      ProfileDeleteCommentEvent(
        userId: uid,
        deletedCommentId: commentId,
      ),
    );
  }

  void _onPickGalleryTap() =>
      _profileImageBloc.add(ProfileImagePickGallery(uid));

  void _onTakePhotoTap() => _profileImageBloc.add(ProfileImageTakePhoto(uid));

  void _onDeletePhotoTap() =>
      _profileImageBloc.add(ProfileImageDeletePhoto(uid));
}
