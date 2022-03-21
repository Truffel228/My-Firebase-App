// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapComment _$MapCommentFromJson(Map<String, dynamic> json) => MapComment(
      comment: json['comment'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );

Map<String, dynamic> _$MapCommentToJson(MapComment instance) =>
    <String, dynamic>{
      'comment': instance.comment,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
