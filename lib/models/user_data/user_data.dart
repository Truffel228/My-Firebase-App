import 'package:fire_base_app/models/map_comment/map_comment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_data.g.dart';

@JsonSerializable()
class UserData {
  UserData({required this.name, required this.age, required this.mapComments});

  final String name;
  final int age;
  final List<MapComment> mapComments;

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
  Map<String,dynamic> toJson() => _$UserDataToJson(this);
}
