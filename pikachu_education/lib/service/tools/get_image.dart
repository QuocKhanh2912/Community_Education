import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class GetImageService {
  static Future<File> getImage({required ImageSource source}) async {
    final image = await ImagePicker().pickImage(source: source);
    final imageTemporary = File(image!.path);
    return imageTemporary;
  }

  Future<File> saveImage({required String imagePath}) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }
}
