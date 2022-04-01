import 'package:fire_base_app/models/user_data/user_data/user_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'map_comment.g.dart';

@JsonSerializable()
class MapComment {
  MapComment({
    required this.userId,
    required this.comment,
    required this.latitude,
    required this.longitude,
    required this.id,
  });
  final String comment;
  final double latitude;
  final double longitude;
  final String userId;
  final String id;

  factory MapComment.fromJson(Map<String, dynamic> json) =>
      _$MapCommentFromJson(json);
  Map<String, dynamic> toJson() => _$MapCommentToJson(this);
}
