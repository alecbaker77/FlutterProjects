import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpageapp/diary_entry_button.dart';
import 'package:fanpageapp/message_card.dart';
import 'package:fanpageapp/top_bar_title.dart';
import 'package:fanpageapp/diary_entry_model.dart';
import 'package:fanpageapp/pop_up_menu.dart';
import 'package:fanpageapp/diary_entry_page.dart';

class DiaryEntry {
   String body;
   String id;
  DiaryEntry({
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

  factory DiaryEntry.fromDoc(QueryDocumentSnapshot doc) {
    return DiaryEntry(
      body: doc['body'],
      id: doc.id,
    );
  }
}