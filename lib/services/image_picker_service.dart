import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  static Future<XFile?> pickGalleryImage() async {
    final imagePicker = ImagePicker();
    final XFile? xFile =
        await imagePicker.pickImage(source: ImageSource.gallery);

    return xFile;
  }

  static Future<XFile?> takePhoto() async {
    final imagePicker = ImagePicker();
    final XFile? xFile = await imagePicker.pickImage(
      source: ImageSource.camera,
    );

    return xFile;
  }
}
