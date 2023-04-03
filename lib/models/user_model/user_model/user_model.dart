import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_model/user_model_api/user_model_api.dart';

class UserModel {
  UserModel({
    required this.name,
    required this.age,
    required this.mapComments,
    this.profileImageUrl,
  });

  final String name;
  final int age;
  final List<MapComment> mapComments;
  final String? profileImageUrl;

  UserModelApi toApi() => UserModelApi(
        name: name,
        age: age,
        mapCommentIds: mapComments.map((mapComment) => mapComment.id).toList(),
      );

  //TODO: Пытался сделать перевод из API в модель Entity, но сделал это в DatabaseService потому что такой метод должен быть асинхронным
  // factory UserData.fromApi(UserDataApi userDataApi){
  //   final listMapComments
  //   return UserData(name: userDataApi.name, age: userDataApi.age, mapComments: );
  // };
}
