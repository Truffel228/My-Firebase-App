// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModelApi _$UserModelApiFromJson(Map<String, dynamic> json) => UserModelApi(
      name: json['name'] as String,
      age: json['age'] as int,
      profileImage: json['profile_image'] as String?,
      mapCommentIds: (json['mapCommentIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserModelApiToJson(UserModelApi instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'mapCommentIds': instance.mapCommentIds,
      'profile_image': instance.profileImage,
    };
