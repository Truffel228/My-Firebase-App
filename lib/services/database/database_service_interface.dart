import 'dart:io';

import 'package:fire_base_app/core/entities/attachment.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_model/user_model/user_model.dart';
import 'package:fire_base_app/models/user_model/user_model_api/user_model_api.dart';
import 'package:fire_base_app/screens/add_map_comment/bloc/add_map_comment_bloc.dart';
import 'package:image_picker/image_picker.dart';

abstract class DatabaseServiceInterface {
  Future<void> updateUserData(
      {required String userId, required UserModel userData});
  Future<void> setUserName(String userId, String name);
  Future<void> setInitialUserData(String userId);
  Future<UserModel> getUserData(String userId);
  Future<UserModel> userDataFromApiToModel(UserModelApi userDataApi);
  Future<void> saveMapComment({
    required MapCommentData mapCommentData,
    required String userId,
    required List<Attachment> attachments,
  });
  Future<List<MapComment>> getAllMapComments();
  Future<void> deleteMapComment(String userId, String commentId);
  Future<void> setUserPhoto(String uid, XFile file);
  Future<bool> deleteUserPhoto(String uid);
}
