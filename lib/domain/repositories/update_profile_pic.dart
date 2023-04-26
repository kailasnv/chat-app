import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../infrastructure/private_keys.dart';

class EditUserProfile {
  static Future updateProfilePhoto() async {
    UploadTask uploadTask;
    String downloadUrl;
    ImagePicker picker = ImagePicker();
    final FirebaseStorage _storage =
        FirebaseStorage.instanceFor(bucket: bucketLink);
    User? currentUser = FirebaseAuth.instance.currentUser;

    // pick image from gallery
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      // if a image is selected by user then, convert it to a File
      final imageFile = File(image.path);

      if (currentUser != null) {
        // this is the path of firebase storage folder
        String filePath = "images/${currentUser.uid}";
        // upload to storage
        uploadTask = _storage.ref().child(filePath).putFile(imageFile);
        // get download url
        var imageUrl = await uploadTask.snapshot.ref.getDownloadURL();
        downloadUrl = imageUrl.toString();

        //Now uploading  the downlaod url which is actually the image Url,
        // to firestore collections image feild
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .update({
          'image': downloadUrl,
        });
      }
    }
  }
}
