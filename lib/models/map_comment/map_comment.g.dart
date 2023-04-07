// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapComment _$MapCommentFromJson(Map<String, dynamic> json) => MapComment(
      userId: json['user_id'] as String,
      comment: json['comment'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      id: json['id'] as String,
      createdTs: json['created_ts'] as int?,
      category: $enumDecodeNullable(_$CategoryEnumMap, json['category']) ??
          Category.other,
    );

Map<String, dynamic> _$MapCommentToJson(MapComment instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'user_id': instance.userId,
      'id': instance.id,
      'category': _$CategoryEnumMap[instance.category]!,
      'created_ts': instance.createdTs,
    };

const _$CategoryEnumMap = {
  Category.criminal: 'criminal',
  Category.accident: 'accident',
  Category.entertainment: 'entertainment',
  Category.transport: 'transport',
  Category.help: 'help',
  Category.other: 'other',
};
