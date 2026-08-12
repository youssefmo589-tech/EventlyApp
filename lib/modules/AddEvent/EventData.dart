import 'package:flutter/material.dart';

class EventData {
  static const String collectionname = "EventCollection";

  String title;

  String categoryId;

  String descreption;

  DateTime? selecteddatetime;
  TimeOfDay ? selectedtime;
  String ? userid;

  bool isfavourite;

  String? eventid;

  EventData({
    required this.title,
    required this.categoryId,
    required this.descreption,
    required this.selecteddatetime,
    this.isfavourite = false,
    this.eventid,
    this.selectedtime,
    this.userid
  });

  Map<String, dynamic> tofirebase() {
    return {
      "title": title,
      "categoryId": categoryId,
      "descreption": descreption,
      "selecteddatetime": selecteddatetime?.millisecondsSinceEpoch,
      "isfavourite": isfavourite,
      "eventid": eventid,
      "selectedhour": selectedtime?.hourOfPeriod,
      "selectedminute": selectedtime?.minute,
      "userid": userid

    };
  }

  factory EventData.fromfirebase(Map<String, dynamic> json) {
    return EventData(
        userid: json["userid"],
      title: json["title"],
      descreption: json["descreption"],
      categoryId: json["categoryId"],
      selecteddatetime: DateTime.fromMillisecondsSinceEpoch(
        json["selecteddatetime"],
      ),
      isfavourite: json["isfavourite"] ?? false,
      eventid: json["eventid"],
        selectedtime: json["selectedhour"] == null ? null : TimeOfDay(
            hour: json["selectedhour"], minute: json["selectedminute"])
    );
  }
}
