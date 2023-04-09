import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'map_comment.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MapComment {
  const MapComment({
    required this.userId,
    required this.comment,
    required this.latitude,
    required this.longitude,
    required this.id,
    this.createdTs,
    this.category = Category.other,
    this.filesUrl = const [],
  });

  final String comment;
  final double latitude;
  final double longitude;
  final String userId;
  final String id;
  final Category category;
  final int? createdTs;
  final List<String> filesUrl;

  String? get creationTime {
    if (createdTs == null) {
      return null;
    }
    return DateFormat('yyyy MMMM dd HH:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(createdTs!));
  }

  factory MapComment.fromJson(Map<String, dynamic> json) =>
      _$MapCommentFromJson(json);
  Map<String, dynamic> toJson() => _$MapCommentToJson(this);
}

enum Category {
  @JsonValue('criminal')
  criminal,
  @JsonValue('accident')
  accident,
  @JsonValue('entertainment')
  entertainment,
  @JsonValue('transport')
  transport,
  @JsonValue('help')
  help,
  @JsonValue('other')
  other,
}

extension ExtCategory on Category {
  String getTitle(BuildContext context) {
    switch (this) {
      case Category.criminal:
        return 'criminal';

      case Category.accident:
        return 'accident';

      case Category.entertainment:
        return 'entertainment';

      case Category.transport:
        return 'transport';

      case Category.help:
        return 'help';

      case Category.other:
        return 'other';
    }
  }
}
