import 'package:cloud_firestore/cloud_firestore.dart';


class MessageEntry {
  String body;
  String id;
  MessageEntry({
    required this.body,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    DateTime currentDate = DateTime.now(); //DateTime
    Timestamp myTimeStamp = Timestamp.fromDate(currentDate); //To TimeStamp
    DateTime myDateTime = myTimeStamp.toDate();
    id = currentDate.millisecondsSinceEpoch.toString();
    return {
      'body': body,
      'id': id,
      'postedDateTime': myDateTime,
    };
  }

  factory MessageEntry.fromDoc(QueryDocumentSnapshot doc) {
    return MessageEntry(
      body: doc['body'],
      id: doc.id,
    );
  }
}