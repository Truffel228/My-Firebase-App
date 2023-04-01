import 'package:json_annotation/json_annotation.dart';

part 'user_data_api.g.dart';

@JsonSerializable()
class UserDataApi {
  UserDataApi({
    required this.name,
    required this.age,
    this.mapCommentIds = const [],
  });

  final String name;
  final int age;
  final List<String> mapCommentIds;

  factory UserDataApi.fromJson(Map<String, dynamic> json) =>
      _$UserDataApiFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataApiToJson(this);
}
