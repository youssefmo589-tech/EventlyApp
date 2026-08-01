import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyapp/modules/AddEvent/EventData.dart';

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

    final data = await collectionRef.get();

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
      "categoryId",
      isEqualTo: categoryID,
    );
    return collectionRef.snapshots();
  }

  static Stream<QuerySnapshot<EventData>> getfavourites() {
    final collectionref = getcollectionref();
    return collectionref.where("isfavourite", isEqualTo: true).snapshots();
  }
}
