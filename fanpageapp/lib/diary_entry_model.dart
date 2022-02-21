import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpageapp/diary_entry_button.dart';
import 'package:fanpageapp/diary_card.dart';
import 'package:fanpageapp/top_bar_title.dart';
import 'package:fanpageapp/diary_entry_model.dart';
import 'package:fanpageapp/pop_up_menu.dart';
import 'package:fanpageapp/diary_entry_page.dart';

class DiaryEntry {
   String emoji;
   String title;
   String body;
   String id;

  DiaryEntry({
    required this.emoji,
    required this.title,
    required this.body,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'emoji': emoji,
      'title': title,
      'body': body,
    };
  }

  factory DiaryEntry.fromDoc(QueryDocumentSnapshot doc) {
    return DiaryEntry(
      emoji: doc['emoji'],
      title: doc['title'],
      body: doc['body'],
      id: doc.id,
    );
  }
}