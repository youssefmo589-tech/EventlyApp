import 'package:cloud_firestore/cloud_firestore.dart';

import '../../modules/users/UserModel.dart';

class Userfirestore {
  static CollectionReference<UserModel> getusercollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionname)
        .withConverter<UserModel>(
          fromFirestore: ((snapshot, options) =>
              UserModel.fromfireStore(snapshot.data()!)),

          toFirestore: (data, options) => data.tofirestore(),
        );
  }

  static Future<bool> createUser(UserModel user) async {
    try {
      final collectionref = getusercollection();

      final docRef = await collectionref.doc(user.uid).set(user);

      return Future.value(true);
    } catch (erroe) {
      return Future.value(false);
    }
  }

  static Future<UserModel?> getuser(String uid) async {
    try {
      final collectionref = getusercollection();
      final user = await collectionref.doc(uid).get();

      if (!user.exists) {
        return null;
      }
      return user.data();
    } catch (error) {
      return null;
    }
  }

  static Future<bool> updateuser(UserModel user) async {
    try {
      final collectionref = getusercollection();
      final docRef = collectionref.doc(user.uid);
      await docRef.update(user.tofirestore());
      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }
  }
}
