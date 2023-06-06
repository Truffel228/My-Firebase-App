import 'package:fire_base_app/models/file_data/file_data.dart';
import 'package:fire_base_app/shared/enums/enums.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'map_comment.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class MapComment {
  const MapComment({
    required this.userId,
    required this.comment,
    required this.latitude,
    required this.longitude,
    required this.id,
    this.createdTs,
    this.category = Category.other,
    this.files = const [],
  });

  final String comment;
  final double latitude;
  final double longitude;
  final String userId;
  final String id;
  final Category category;
  final int? createdTs;
  final List<FileData> files;

  String? get creationTime {
    if (createdTs == null) {
      return null;
    }
    return DateFormat('yyyy MMMM dd HH:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(createdTs!));
  }

  DateTime get creationDateTime =>
      DateTime.fromMillisecondsSinceEpoch(createdTs ?? 0);

  factory MapComment.fromJson(Map<String, dynamic> json) =>
      _$MapCommentFromJson(json);
  Map<String, dynamic> toJson() => _$MapCommentToJson(this);
}
