import 'dart:io';

import 'package:fire_base_app/services/file_helper/file_helper_service_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FileHelperService implements FileHelperServiceInterface {
  @override
  Future<File> getFileFromUrl(String url) async {
    final uri = Uri.parse(url);
    final http.Response responseData = await http.get(uri);

    final uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();

    File file = await File('${tempDir.path}/img').writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }
}
