// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_api.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDataApi _$UserDataApiFromJson(Map<String, dynamic> json) => UserDataApi(
      name: json['name'] as String,
      age: json['age'] as int,
      mapCommentIds: (json['mapCommentIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserDataApiToJson(UserDataApi instance) =>
    <String, dynamic>{
      'name': instance.name,
      'age': instance.age,
      'mapCommentIds': instance.mapCommentIds,
    };
