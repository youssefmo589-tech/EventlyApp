import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyapp/modules/AddEvent/EventData.dart';
import 'package:eventlyapp/modules/users/UserModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

// class FireBaseCloudService
// {
//
//   static CollectionReference<EventData> _getcollectionreference()
//   {
//     // return  FirebaseFirestore.instance.collection(EventData.collectionname)
//     //     .withConverter<EventData>(fromFirestore: ((snapshot, options) => EventData.fromFirebase(snapshot.data()!)),
//     //     toFirestore: (data , options)=> data.toFirebase()) ;
//
//     return  FirebaseFirestore.instance.collection(EventData.collectionname)
//         .withConverter(
//
//         fromFirestore: ((snapshot, options) => EventData.fromFirebase(snapshot.data()!)),
//
//         toFirestore: (data , options)=> data.toFirebase()) ;
//   }
//
//  static Future<bool> createnewevent(EventData event)
//   {
//     try
//     {
//
//     final collectionref = _getcollectionreference() ;
//     final docRef = collectionref.doc()  ;
//
//     docRef.set(event) ;
//     event.eventid =  docRef.id ;
//     return Future.value(true) ;
//
//   }
//
//     catch(error)
//     {
//       return Future.value(false) ;
//     }
//
//
//
//           // "categoryId" : event.categoryId ,
//           // "title" : event.title ,
//           // "descreption" : event.descreption ,
//           // "selecteddatetime" : event.selecteddatetime ,
//           // "isfavourite" : event.isfavourite ,
//           // "eventid" : event.eventid ,
//
//
//
//
//
//
//
//   }
//
//   static void geteventdata()
//   {
//     final collectionref = _getcollectionreference() ;
//     final docRef = collectionref.doc() ;
//
//
//   }
//
//  static void deleteevent()
//  {
//    final collectionref = _getcollectionreference() ;
//    final docRef = collectionref.doc() ;
//
//
//
//
//  }
//   static Future<void> updateevent(EventData event) async
//   {
//     final collectionref = _getcollectionreference() ;
//     final docRef = collectionref.doc( event.eventid);
//
//     return docRef.update(event.toFirebase()) ;
//
//
//   }
//
//
//
// }

class FirebaseCloudService {
  static CollectionReference<EventData> getcollectionref() {
    return FirebaseFirestore.instance
        .collection(EventData.collectionname)
        .withConverter<EventData>(
          fromFirestore: ((snapshot, options) =>
              EventData.fromfirebase(snapshot.data()!)),

          toFirestore: (data, options) => data.tofirebase(),
        );
  }

  static Future<bool> createEvent(EventData event) async {
    try {
      final collectionRef = getcollectionref();
      final docRef = collectionRef.doc();
      event.eventid = docRef.id;
      await docRef.set(event);

      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }
  }

  static Future<bool> update(EventData event) async {
    try {
      final collectionRef = getcollectionref();
      final docRef = collectionRef.doc(event.eventid);
      await docRef.update(event.tofirebase());
      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }
  }

  static Future<List<EventData>> getevent() async {
    List<EventData> eventdatalist = [];
    final collectionRef = getcollectionref();

    final data = await collectionRef.where(
        "userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();

    eventdatalist = data.docs.map((e) => e.data()).toList();
    return eventdatalist;
  }

  static Future<bool> deleteevent(String eventID) async {
    try {
      final collectionRef = getcollectionref();
      await collectionRef.doc(eventID).delete();
      return Future.value(true);
    } catch (error) {
      return Future.value(false);
    }
  }

  static Stream<QuerySnapshot<EventData>> getRealtimeEventData(
    String categoryID,
  ) {
    final collectionRef = getcollectionref().where(
        "userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where(
      "categoryId",
      isEqualTo: categoryID,
    );
    return collectionRef.snapshots();
  }

  static Stream<QuerySnapshot<EventData>> getfavourites() {
    final collectionref = getcollectionref();
    return collectionref.where(
        "userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("isfavourite", isEqualTo: true).snapshots();
  }


//  static CollectionReference<UserModel> getusercollection()
//  {
//    return FirebaseFirestore.instance.collection(UserModel.collectionname).withConverter<UserModel>(
//
//        fromFirestore: ((snapshot, options) => UserModel.fromfireStore(snapshot.data()!) ),
//
//        toFirestore : (data , options) => data.tofirestore()) ;
//
//  }
//
//  static Future<bool> createUser(UserModel user)async
//  {
//    try{
//      final collectionref = getusercollection() ;
//
//      final docRef = await collectionref.doc(user.uid).set(user) ;
//
// return Future.value(true) ;
//
//    }catch(erroe){
//
//      return Future.value(false) ;
//
//    }
//  }
//
//  static Future<UserModel?> getusers(String uid)async
//  {
//
//
//      final collectionref = getusercollection() ;
//      final user =await collectionref.doc(uid).get() ;
//      return user.data() ;
//
//
//  }
//
//  static Future<bool> updateuser(UserModel user)async
//  {
//
//    try{
//      final collectionref = getusercollection() ;
//      final docRef  =collectionref.doc(user.uid) ;
//      await docRef.update(user.tofirestore()) ;
//      return Future.value(true) ;
//
//    }catch(error){
//      return Future.value(false) ;
//    }
//
//
//  }


}