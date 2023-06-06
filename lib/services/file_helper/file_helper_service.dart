import 'dart:io';

import 'package:fire_base_app/services/file_helper/file_helper_service_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';

class FileHelperService implements FileHelperServiceInterface {
  @override
  Future<File> getFileFromUrl(String url) async {
    final uri = Uri.parse(url);
    final http.Response responseData = await http.get(uri);

    final uint8list = responseData.bodyBytes;
    var buffer = uint8list.buffer;
    ByteData byteData = ByteData.view(buffer);
    var tempDir = await getTemporaryDirectory();

    final fileName = '${DateTime.now().millisecondsSinceEpoch}img';

    File file = await File('${tempDir.path}/$fileName').writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  @override
  Future<File> compressImage(File file) async {
    var tempDir = await getTemporaryDirectory();
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      '${tempDir.path}/$fileName',
      quality: 88,
    );

    if (result == null) {
      throw Exception('Error compressing image');
    }
    var resultFile = File(result.path);

    print('compressed ${resultFile.lengthSync()}');
    print('regular ${file.lengthSync()}');

    return resultFile;
  }

  @override
  Future<File> compressVideo(File file) async {
    MediaInfo? mediaInfo = await VideoCompress.compressVideo(
      file.path,
      quality: VideoQuality.DefaultQuality,
      deleteOrigin: false,
    );
    if (mediaInfo?.path == null) {
      throw Exception('Error compressing video');
    }
    final compressedFile = File(mediaInfo!.path!);

    print('compressed ${compressedFile.lengthSync()}');
    print('regular ${file.lengthSync()}');
    return compressedFile;
  }
}
