import 'dart:io';
import 'package:fire_base_app/shared/enums/enums.dart';

class MediaAttachment {
  const MediaAttachment(
    this.fileUrl,
    this.fileType, {
    this.file,
    this.videoPreview,
    this.videoDurationSec,
  });
  final String fileUrl;
  final FileType fileType;
  final File? file;
  final File? videoPreview;
  final int? videoDurationSec;
}
