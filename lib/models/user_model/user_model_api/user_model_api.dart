import 'package:json_annotation/json_annotation.dart';

part 'user_model_api.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserModelApi {
  UserModelApi({
    required this.name,
    required this.age,
    this.profileImage,
    this.mapCommentIds = const [],
  });

  final String name;
  final int age;
  final List<String> mapCommentIds;
  final String? profileImage;

  factory UserModelApi.fromJson(Map<String, dynamic> json) =>
      _$UserModelApiFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelApiToJson(this);
}
