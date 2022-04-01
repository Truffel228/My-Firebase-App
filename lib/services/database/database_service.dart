import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_data/user_data/user_data.dart';
import 'package:fire_base_app/models/user_data/user_data_api/user_data_api.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';

class DatabaseService extends DatabaseServiceInterface {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference mapCommentsCollection =
      FirebaseFirestore.instance.collection('mapComments');

  @override
  Future<void> updateUserData(
      {required String uid, required UserData userData}) async {
    final userDataApi = userData.toApi();
    return await usersCollection.doc(uid).set(userDataApi.toJson());

  }

  @override
  Future<UserData> getUserData(String uid) async {
    final userDataApi = await getUserDataApi(uid);
    final userData = await userDataFromApiToModel(userDataApi);
    return userData;
  }

  @override
  Future<UserDataApi> getUserDataApi(String uid) async {
    final user = await usersCollection.doc(uid).get();
    final userApiMap = user.data() as Map<String, dynamic>;
    //TODO: Убрать
    final userDataApi = UserDataApi.fromJson(userApiMap);
    return userDataApi;
  }

  @override
  Future<void> setInitialUserData(String uid) async {
    final initialUserData =
        UserData(name: 'Username', age: 18, mapComments: []);
    //TODO: Доделать
    updateUserData(uid: uid, userData: initialUserData);
  }

  @override
  Future<void> saveCommentToCollection(MapComment comment) async {
    return await mapCommentsCollection.doc(comment.id).set(comment.toJson());
  }

  @override
  Future<void> saveCommentIdToUser(
      {required String commentUid, required String userId}) async {
    final mapCommentIds = await _getUserCommentIds(userId) as List<String>;
    mapCommentIds.add(commentUid);
    //TODO: Set comment ids to user
    return await usersCollection.doc(userId).update({'mapCommentIds': mapCommentIds});
  }

  Future<List<String>> _getUserCommentIds(String userId) async {
    final UserDataApi userDataApi = await getUserDataApi(userId);
    return userDataApi.mapCommentIds;
  }

  @override
  Future<UserData> userDataFromApiToModel(UserDataApi userDataApi) async {
    final mapCommentIds = userDataApi.mapCommentIds;
    final List<MapComment> mapComments = [];
    for (final commentId in mapCommentIds) {
      final mapCommentData = await mapCommentsCollection.doc(commentId).get();
      final mapComment = mapCommentData.data() as Map<String, dynamic>;
      mapComments.add(MapComment.fromJson(mapComment));
    }
    return UserData(
        name: userDataApi.name, age: userDataApi.age, mapComments: mapComments);
  }

  @override
  Future<void> setUserName(String uid, String name) async {
    return await usersCollection.doc(uid).update({'name': name});
  }
}
