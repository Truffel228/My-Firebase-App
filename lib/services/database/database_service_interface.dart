import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_data/user_data/user_data.dart';
import 'package:fire_base_app/models/user_data/user_data_api/user_data_api.dart';

abstract class DatabaseServiceInterface {
  Future<void> updateUserData(
      {required String uid, required UserData userData});
  Future<void> setUserName(String uid, String name);
  Future<void> setInitialUserData(String uid);
  Future<UserData> getUserData(String uid);
  Future<UserData> userDataFromApiToModel(UserDataApi userDataApi);
  Future<UserDataApi> getUserDataApi(String uid);
  Future<void> saveCommentToCollection(MapComment comment);
  Future<void> saveCommentIdToUser(
      {required String commentUid, required String userId});
}
