import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_data/user_data/user_data.dart';
import 'package:fire_base_app/models/user_data/user_data_api/user_data_api.dart';

abstract class DatabaseServiceInterface {
  Future<void> updateUserData(
      {required String userId, required UserData userData});
  Future<void> setUserName(String userId, String name);
  Future<void> setInitialUserData(String userId);
  Future<UserData> getUserData(String userId);
  Future<UserData> userDataFromApiToModel(UserDataApi userDataApi);
  Future<void> saveCommentToCollection(MapComment comment);
  Future<void> saveCommentIdToUser(
      {required String commentId, required String userId});
  Future<List<MapComment>> getAllMapComments();
  Future<void> deleteMapComment(String commentId);
}
