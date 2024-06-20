import 'package:image_picker/image_picker.dart';

class Utils {}

Future<XFile?> selectGalleryImage() async {
  XFile? selectedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  return selectedImage;
}

Future<XFile?> selectCameraImage() async {
  XFile? selectedImage =
      await ImagePicker().pickImage(source: ImageSource.camera);
  return selectedImage;
}
