class EventData {
  static const String collectionname = "EventCollection";

  String title;

  String categoryId;

  String descreption;

  DateTime? selecteddatetime;

  bool isfavourite;

  String? eventid;

  EventData({
    required this.title,
    required this.categoryId,
    required this.descreption,
    required this.selecteddatetime,
    this.isfavourite = false,
    this.eventid,
  });

  // Map<String , dynamic>toFirebase()
  // {
  //   return {
  //
  //     "title" : title ,
  //     "categoryId" : categoryId ,
  //     "descreption" : descreption ,
  //     "selecteddatetime" : selecteddatetime?.millisecondsSinceEpoch ,
  //     "isfavourite" : isfavourite ,
  //     "eventid" : eventid ,
  //
  //   };
  //
  // }
  // factory EventData.fromFirebase(Map<String , dynamic> json)
  // {
  //   return EventData(title: json['title'],
  //       categoryId: json['categoryId'],
  //       descreption:json["descreption"],
  //       selecteddatetime: DateTime.fromMillisecondsSinceEpoch(json['selecteddatetime']) ,
  //     isfavourite: json["isfavourite"] ,
  //   ) ;
  // }

  Map<String, dynamic> tofirebase() {
    return {
      "title": title,
      "categoryId": categoryId,
      "descreption": descreption,
      "selecteddatetime": selecteddatetime?.millisecondsSinceEpoch,
      "isfavourite": isfavourite,
      "eventid": eventid,
    };
  }

  factory EventData.fromfirebase(Map<String, dynamic> json) {
    return EventData(
      title: json["title"],
      descreption: json["descreption"],
      categoryId: json["categoryId"],
      selecteddatetime: DateTime.fromMillisecondsSinceEpoch(
        json["selecteddatetime"],
      ),
      isfavourite: json["isfavourite"] ?? false,
      eventid: json["eventid"],
    );
  }
}
