import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';
import 'package:fire_base_app/services/image_picker_service.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

part 'profile_image_event.dart';
part 'profile_image_state.dart';

class ProfileImageBloc extends Bloc<ProfileImageEvent, ProfileImageState> {
  ProfileImageBloc({
    required DatabaseServiceInterface databaseService,
  })  : _databaseService = databaseService,
        super(const ProfileImageInitial()) {
    on<ProfileImagePickGallery>(_onProfileImagePickGallery);
    on<ProfileImageTakePhoto>(_onProfileImageTakePhoto);
    on<ProfileImageDeletePhoto>(_onProfileImageDeletePhoto);
  }

  final DatabaseServiceInterface _databaseService;

  FutureOr<void> _onProfileImagePickGallery(
    ProfileImagePickGallery event,
    Emitter<ProfileImageState> emit,
  ) async {
    final XFile? image;
    try {
      image = await ImagePickerService.pickGalleryImage();
    } on NoGalleryAccessException {
      emit(const ProfileImageNoGalleryAccess());
      return;
    }

    if (image == null) {
      return;
    }

    await _databaseService.setUserPhoto(event.uid, image);
    emit(const ProfileImageLoadSuccess());
  }

  FutureOr<void> _onProfileImageTakePhoto(
    ProfileImageTakePhoto event,
    Emitter<ProfileImageState> emit,
  ) async {
    final XFile? image;
    try {
      image = await ImagePickerService.pickGalleryImage();
    } on NoCameraAccessException {
      emit(const ProfileImageNoCameraAccess());
      return;
    }

    if (image == null) {
      return;
    }
    await _databaseService.setUserPhoto(event.uid, image);
    emit(const ProfileImageLoadSuccess());
  }

  FutureOr<void> _onProfileImageDeletePhoto(
    ProfileImageDeletePhoto event,
    Emitter<ProfileImageState> emit,
  ) async {
    await _databaseService.deleteUserPhoto(event.uid);
    emit(ProfileImageDeleteSuccess());
  }
}
