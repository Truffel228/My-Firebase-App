import 'dart:io';

abstract class FileHelperServiceInterface {
  Future<File> getFileFromUrl(String url);
}
