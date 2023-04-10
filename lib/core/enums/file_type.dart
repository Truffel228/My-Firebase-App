import 'package:json_annotation/json_annotation.dart';

enum FileType {
  @JsonValue('image')
  image,
  @JsonValue('video')
  video,
}