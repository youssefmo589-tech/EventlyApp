import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireStorageService {
  static Reference getref() {
    return FirebaseStorage.instance.ref();
  }

  static Reference getuserimageref(String uid) {
    final ref = getref();
    return ref.child("users").child('$uid.jpg');
  }

  static Future<String> uploadimage(String uid, File image) async {
    final ref = getuserimageref(uid);
    print(ref.fullPath);
    await ref.putFile(image);
    final imageurl = await ref.getDownloadURL();
    return imageurl;
  }
}
