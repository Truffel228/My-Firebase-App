
import 'package:fire_base_app/shared/enums/enums.dart';
import 'package:json_annotation/json_annotation.dart';

part 'file_data.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FileData {
  const FileData({
    required this.fileType,
    required this.fileUrl,
  });

  final FileType fileType;
  final String fileUrl;

  factory FileData.fromJson(Map<String, dynamic> json) =>
      _$FileDataFromJson(json);

  Map<String, dynamic> toJson() => _$FileDataToJson(this);
}
