import 'package:json_annotation/json_annotation.dart';

part 'map_comment.g.dart';

@JsonSerializable()
class MapComment {
  MapComment({required this.comment,required this.latitude,required this.longitude});
  final String comment;
  final double latitude;
  final double longitude;

  factory MapComment.fromJson(Map<String, dynamic> json) => _$MapCommentFromJson(json);
  Map<String,dynamic> toJson() => _$MapCommentToJson(this);
}
