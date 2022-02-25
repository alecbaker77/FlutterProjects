import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fanpageapp/diary_entry_button.dart';
import 'package:fanpageapp/message_card.dart';
import 'package:fanpageapp/top_bar_title.dart';
import 'package:fanpageapp/diary_entry_model.dart';
import 'package:fanpageapp/pop_up_menu.dart';
import 'package:fanpageapp/diary_entry_page.dart';

class DiaryEntryButton extends StatelessWidget {
  const DiaryEntryButton({
    Key? key,
    required this.bodyTextController,
    required this.widget,
  })  :
        super(key: key);


  final TextEditingController bodyTextController;

  final DiaryEntryPage widget;

  @override
  Widget build(BuildContext context) {
    final isAddAction = widget.diaryAction == DiaryAction.add;
    return FloatingActionButton.extended(
      elevation: 2,
      onPressed: () {
        final id = widget.diaryEntry?.id ?? "";
        final diaryEntryMap = DiaryEntry(
          body: bodyTextController.text,
          id: id,
        ).toMap();


        if (isAddAction) {
          FirebaseFirestore.instance.collection('messages').add(diaryEntryMap);
        } else {
          FirebaseFirestore.instance
              .collection('messages')
              .doc(id)
              .update(diaryEntryMap);
        }

        Navigator.of(context).popUntil(ModalRoute.withName('/'));
      },
      label: Text(isAddAction ? 'Post Message' : 'Update'),
      icon: Icon(isAddAction ? Icons.book : Icons.bookmark_border),
    );
  }
}