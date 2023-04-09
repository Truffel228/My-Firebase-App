import 'dart:math';

class IdGeneratorService {
  static String generateMapCommentId(String userId) {
    final firstPartId = userId.substring(0, 5);
    final secondPartId = Random().nextInt(1000).toString().padLeft(3, '0');
    final thirdPartId = DateTime.now().toIso8601String();

    final mapCommentId = '$firstPartId$secondPartId${thirdPartId}_MC';

    return mapCommentId;
  }

  static String generateFileName(String userId, int i, String ext) {
    final firstIdPart = userId.substring(0, 5);
    final secondIdPart = Random().nextInt(1000).toString().padLeft(3, '0');
    final thirdIdPart = i;
    final fourthIdPart = DateTime.now().toIso8601String();

    final fileName = '$firstIdPart$secondIdPart$thirdIdPart$fourthIdPart.$ext';

    return fileName;
  }
}
