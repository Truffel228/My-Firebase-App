import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_data/user_data.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';

class DatabaseService extends DatabaseServiceInterface {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  @override
  Future<void> updateUserData(
      {required String uid, required UserData userData}) async {
    return await usersCollection.doc(uid).set(userData.toJson());
  }

  @override
  Future<UserData> getUserData(String uid) async {
    final user = await usersCollection.doc(uid).get();
    final u = user.data() as Map<String, dynamic>;
    final list = u['mapComments'] as List<dynamic>;
    final mapComments = list.map((e) => MapComment.fromJson(e)).toList();
    return UserData(name: u['name'], age: u['age'], mapComments: mapComments);
  }

  @override
  Future<void> setInitialUserData(String uid) async {
    final initialUserData =
        UserData(name: 'Username', age: 18, mapComments: []);
    updateUserData(uid: uid, userData: initialUserData);
  }
}
