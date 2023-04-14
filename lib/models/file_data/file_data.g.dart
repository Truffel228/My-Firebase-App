// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileData _$FileDataFromJson(Map<String, dynamic> json) => FileData(
      fileType: $enumDecode(_$FileTypeEnumMap, json['file_type']),
      fileUrl: json['file_url'] as String,
    );

Map<String, dynamic> _$FileDataToJson(FileData instance) => <String, dynamic>{
      'file_type': _$FileTypeEnumMap[instance.fileType]!,
      'file_url': instance.fileUrl,
    };

const _$FileTypeEnumMap = {
  FileType.image: 'image',
  FileType.video: 'video',
};
