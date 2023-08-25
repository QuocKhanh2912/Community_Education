
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService{
  static Future<String> upLoadImageToStorage ({required File file}) async {
    String imageUrl = '';
    String uniqueFileName=DateTime.now().microsecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage =referenceRoot.child('images');
    Reference referenceImageToUpload=referenceDirImage.child(uniqueFileName);
     await referenceImageToUpload.putFile(File(file.path));
     imageUrl = await referenceImageToUpload.getDownloadURL();
     return imageUrl;

  }
  static Future<void> deleteImageOnStorage ({required String imageName}) async {
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage =referenceRoot.child('images/$imageName');
   await referenceDirImage.delete();
  }
}