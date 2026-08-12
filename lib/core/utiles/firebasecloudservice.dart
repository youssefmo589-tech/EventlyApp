import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyapp/modules/AddEvent/EventData.dart';
import 'package:firebase_auth/firebase_auth.dart';


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




}