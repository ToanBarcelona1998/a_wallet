import 'package:image_picker/image_picker.dart';
import 'system_permission_helper.dart';

sealed class ImagePickerHelper {
  static Future<String?> pickSingleImage([
    ImageSource imageSource = ImageSource.gallery,
  ]) async {
    try{
      final ImagePicker picker = ImagePicker();

      final XFile? xFile = await picker.pickImage(
        source: imageSource,
      );

      if (xFile == null) return null;

      return xFile.path;
    }catch(e){
      SystemPermissionHelper.goToSettings();
      return null;
    }
  }

  static Future<List<String>> pickMultiImage() async {
    try{
      final ImagePicker picker = ImagePicker();

      final List<XFile> xFile = await picker.pickMultiImage();

      return xFile
          .map(
            (e) => e.path,
      )
          .toList();
    }catch(e){
      SystemPermissionHelper.goToSettings();
      return [];
    }
  }
}
