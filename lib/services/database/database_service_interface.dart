import 'package:fire_base_app/models/user_data/user_data.dart';

abstract class DatabaseServiceInterface {
  Future<void> updateUserData({required String uid, required UserData userData});
  Future<void> setInitialUserData(String uid);
  Future<UserData> getUserData(String uid);
}