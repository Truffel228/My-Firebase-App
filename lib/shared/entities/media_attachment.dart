import 'dart:io';
import 'package:fire_base_app/shared/enums/enums.dart';

class MediaAttachment {
  const MediaAttachment(
    this.fileUrl,
    this.fileType, {
    this.videoPreview,
    this.videoDurationSec,
  });
  final String fileUrl;
  final FileType fileType;
  final File? videoPreview;
  final int? videoDurationSec;
}
