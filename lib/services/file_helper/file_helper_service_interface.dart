import 'dart:io';

abstract class FileHelperServiceInterface {
  Future<File> getFileFromUrl(String url);
  Future<File> compressImage(File file);
  Future<File> compressVideo(File file);
}
