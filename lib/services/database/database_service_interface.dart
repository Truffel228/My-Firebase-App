import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_model/user_model/user_model.dart';
import 'package:fire_base_app/models/user_model/user_model_api/user_model_api.dart';
import 'package:image_picker/image_picker.dart';

abstract class DatabaseServiceInterface {
  Future<void> updateUserData(
      {required String userId, required UserModel userData});
  Future<void> setUserName(String userId, String name);
  Future<void> setInitialUserData(String userId);
  Future<UserModel> getUserData(String userId);
  Future<UserModel> userDataFromApiToModel(UserModelApi userDataApi);
  Future<void> saveCommentToCollection(MapComment comment);
  Future<void> saveCommentIdToUser(
      {required String commentId, required String userId});
  Future<List<MapComment>> getAllMapComments();
  Future<void> deleteMapComment(String commentId);
  Future<void> setUserPhoto(String uid, XFile file);
  Future<void> deleteUserPhoto(String uid);
}
