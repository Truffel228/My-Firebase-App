import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerService {
  final _imagePicker = ImagePicker();
  Future<XFile?> pickGalleryImage() async {
    final isApple = defaultTargetPlatform == TargetPlatform.iOS;

    final status = await Permission.storage.request();

    if (status.isGranted) {
      final XFile? xFile =
          await _imagePicker.pickImage(source: ImageSource.gallery);

      return xFile;
    }

    if (isApple || status.isPermanentlyDenied) {
      throw NoGalleryAccessException();
    }
    return null;
  }

  Future<XFile?> takePhoto() async {
    final isApple = defaultTargetPlatform == TargetPlatform.iOS;

    final status = await Permission.camera.request();

    if (status.isGranted) {
      final XFile? xFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
      );

      return xFile;
    }

    if (isApple || status.isPermanentlyDenied) {
      throw NoCameraAccessException();
    }

    return null;
  }

  Future<XFile?> pickGalleryVideo() async {
    final isApple = defaultTargetPlatform == TargetPlatform.iOS;

    final status = await Permission.storage.request();

    if (status.isGranted) {
      final XFile? xFile =
          await _imagePicker.pickVideo(source: ImageSource.gallery);

      return xFile;
    }

    if (isApple || status.isPermanentlyDenied) {
      throw NoGalleryAccessException();
    }
    return null;
  }

  Future<XFile?> recordVideo() async {
    final isApple = defaultTargetPlatform == TargetPlatform.iOS;

    final status = await Permission.camera.request();

    if (status.isGranted) {
      final XFile? xFile =
          await _imagePicker.pickVideo(source: ImageSource.camera);

      return xFile;
    }

    if (isApple || status.isPermanentlyDenied) {
      throw NoCameraAccessException();
    }
    return null;
  }
}

class NoGalleryAccessException implements Exception {}

class NoCameraAccessException implements Exception {}
