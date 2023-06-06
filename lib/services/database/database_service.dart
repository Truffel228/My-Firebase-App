import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_base_app/models/file_data/file_data.dart';
import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_model/user_model/user_model.dart';
import 'package:fire_base_app/models/user_model/user_model_api/user_model_api.dart';
import 'package:fire_base_app/screens/add_map_comment/bloc/add_map_comment_bloc.dart';
import 'package:fire_base_app/services/database/database_service_interface.dart';
import 'package:fire_base_app/services/file_helper/file_helper_service_interface.dart';
import 'package:fire_base_app/services/id_generator_service.dart';
import 'package:fire_base_app/shared/entities/entities.dart';
import 'package:fire_base_app/shared/enums/file_type.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class DatabaseService extends DatabaseServiceInterface {
  /// Collections references
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference mapCommentsCollection =
      FirebaseFirestore.instance.collection('mapComments');
  final storage = FirebaseStorage.instance;

  final FileHelperServiceInterface _fileHelperService;

  DatabaseService({
    required FileHelperServiceInterface fileHelperService,
  }) : _fileHelperService = fileHelperService;

  @override
  Future<void> updateUserData(
      {required String userId, required UserModel userData}) async {
    final userDataApi = userData.toApi();
    return await usersCollection.doc(userId).set(userDataApi.toJson());
  }

  @override
  Future<UserModel> getUserData(String uid) async {
    final userDataApi = await _getUserDataApi(uid);
    final userData = await userDataFromApiToModel(userDataApi);
    return userData;
  }

  Future<UserModelApi> _getUserDataApi(String uid) async {
    final user = await usersCollection.doc(uid).get();
    final userApiMap = user.data() as Map<String, dynamic>;
    //TODO: Убрать
    final userDataApi = UserModelApi.fromJson(userApiMap);
    return userDataApi;
  }

  @override
  Future<void> setInitialUserData(String uid) async {
    final initialUserData = UserModel(
      name: 'Username',
      age: 18,
      mapComments: [],
    );
    //TODO: Доделать
    updateUserData(userId: uid, userData: initialUserData);
  }

  Future<List<String>> _getUserCommentIds(String userId) async {
    final UserModelApi userDataApi = await _getUserDataApi(userId);
    return List.from(userDataApi.mapCommentIds);
  }

  @override
  Future<UserModel> userDataFromApiToModel(UserModelApi userDataApi) async {
    final mapCommentIds = userDataApi.mapCommentIds;
    final List<MapComment> mapComments = [];
    for (final commentId in mapCommentIds) {
      final mapCommentData = await mapCommentsCollection.doc(commentId).get();
      final mapCommentDataData = mapCommentData.data();

      /// If map comment with id doesn't exists then skip adding this map comment to list
      if (mapCommentDataData == null) {
        continue;
      }
      final mapComment = mapCommentDataData as Map<String, dynamic>;
      mapComments.add(MapComment.fromJson(mapComment));
    }

    return UserModel(
      name: userDataApi.name,
      age: userDataApi.age,
      mapComments: mapComments,
      profileImageUrl: userDataApi.profileImage,
    );
  }

  @override
  Future<void> setUserName(String uid, String name) async {
    return await usersCollection.doc(uid).update({'name': name});
  }

  @override
  Future<List<MapComment>> getAllMapComments() async {
    try {
      /// TODO: проверить что вернёт метод если коллекция пуста
      final result = await mapCommentsCollection.get();
      final listMap =
          result.docs.map((doc) => doc.data() as Map<String, dynamic>);
      final listMapComment =
          listMap.map((map) => MapComment.fromJson(map)).toList();
      return listMapComment;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  @override
  Future<MapComment> getMapComment(String id) async {
    final snapshot = await mapCommentsCollection.doc(id).get();
    final mapCommentData = snapshot.data();
    final mapComment =
        MapComment.fromJson(mapCommentData as Map<String, dynamic>);

    return mapComment;
  }

  @override
  Future<void> deleteMapComment(String userId, String commentId) async {
    try {
      final comment = await mapCommentsCollection.doc(commentId).get();
      final files = (comment.get('files') as List<dynamic>)
          .map((e) => FileData.fromJson(e))
          .toList();
      for (var file in files) {
        final ref = storage.refFromURL(file.fileUrl);
        await storage.ref('files/${ref.name}').delete();
      }

      await mapCommentsCollection.doc(commentId).delete();
      final userDoc = await usersCollection.doc(userId).get();
      var mapCommentIdList = userDoc.get('map_comment_ids') as List<dynamic>;
      mapCommentIdList = mapCommentIdList.map((e) => e.toString()).toList();
      mapCommentIdList.remove(commentId);
      await usersCollection
          .doc(userId)
          .update({'map_comment_ids': mapCommentIdList});
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> setUserPhoto(String uid, XFile file) async {
    try {
      final fileExt = file.name.split('.').last;
      final fileName = 'profile_image_$uid.$fileExt';
      final fileToUpload = File(file.path);

      await storage.ref('profile_image/$fileName').putFile(fileToUpload);

      final userPhotoUrl =
          await storage.ref('profile_image/$fileName').getDownloadURL();

      await usersCollection.doc(uid).update(
        {'profile_image': userPhotoUrl},
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<bool> deleteUserPhoto(String uid) async {
    final userDoc = await usersCollection.doc(uid).get();
    final userData = userDoc.data();
    final userModelApi =
        UserModelApi.fromJson(userData as Map<String, dynamic>);
    if (userModelApi.profileImage?.isEmpty ?? true) {
      return false;
    }
    await storage.ref('profile_image/${userModelApi.profileImage}').delete();
    await usersCollection.doc(uid).update({'profile_image': null});
    return true;
  }

  @override
  Future<void> saveMapComment({
    required MapCommentData mapCommentData,
    required String userId,
    required List<Attachment> attachments,
  }) async {
    final mapCommentId = IdGeneratorService.generateMapCommentId(userId);

    /// Add map comment id to user
    final mapCommentIds = await _getUserCommentIds(userId);
    mapCommentIds.add(mapCommentId);

    await usersCollection
        .doc(userId)
        .update({'map_comment_ids': mapCommentIds});

    final List<FileData> files = <FileData>[];

    for (var i = 0; i < attachments.length; i++) {
      final attachment = attachments[i];
      final ext = attachment.file.path.split('.').last;

      final File? compressedFile;

      switch (attachment.fileType) {
        case FileType.image:
          compressedFile =
              await _fileHelperService.compressImage(attachment.file);
          break;
        case FileType.video:
          compressedFile =
              await _fileHelperService.compressVideo(attachment.file);
          break;
      }

      final fileName = IdGeneratorService.generateFileName(userId, i, ext);

      await storage.ref('files/$fileName').putFile(compressedFile);
      final fileUrl = await storage.ref('files/$fileName').getDownloadURL();

      final file = FileData(
        fileType: attachment.fileType,
        fileUrl: fileUrl,
      );

      files.add(file);
    }

    final createTimeTs = DateTime.now().millisecondsSinceEpoch;

    final mapComment = MapComment(
      id: mapCommentId,
      userId: userId,
      comment: mapCommentData.text,
      latitude: mapCommentData.latitude,
      longitude: mapCommentData.longitude,
      category: mapCommentData.category,
      createdTs: createTimeTs,
      files: files,
    );

    await mapCommentsCollection.doc(mapCommentId).set(mapComment.toJson());
  }
}
