import 'dart:io';
import 'package:fire_base_app/shared/enums/enums.dart';

class Attachment {
  const Attachment(
    this.file,
    this.fileType, {
    this.videoPreview,
    this.videoDurationSec,
  });
  final File file;
  final FileType fileType;
  final File? videoPreview;
  final int? videoDurationSec;
}