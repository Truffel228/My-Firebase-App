// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapComment _$MapCommentFromJson(Map<String, dynamic> json) => MapComment(
      userId: json['userId'] as String,
      comment: json['comment'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      id: json['id'] as String,
      category: $enumDecodeNullable(_$CategoryEnumMap, json['category']) ??
          Category.other,
    );

Map<String, dynamic> _$MapCommentToJson(MapComment instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'userId': instance.userId,
      'id': instance.id,
      'category': _$CategoryEnumMap[instance.category]!,
    };

const _$CategoryEnumMap = {
  Category.criminal: 'criminal',
  Category.accident: 'accident',
  Category.entertainment: 'entertainment',
  Category.transport: 'transport',
  Category.help: 'help',
  Category.other: 'other',
};
