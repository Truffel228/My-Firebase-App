import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:fire_base_app/models/user_data/user_data_api/user_data_api.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserData {
  UserData({required this.name, required this.age, required this.mapComments});

  final String name;
  final int age;
  final List<MapComment> mapComments;

  UserDataApi toApi() => UserDataApi(
      name: name,
      age: age,
      mapCommentIds: mapComments.map((mapComment) => mapComment.id).toList());

  //TODO: Пытался сделать перевод из API в модель Entity, но сделал это в DatabaseService потому что такой метод должен быть асинхронным
  // factory UserData.fromApi(UserDataApi userDataApi){
  //   final listMapComments
  //   return UserData(name: userDataApi.name, age: userDataApi.age, mapComments: );
  // };
}
