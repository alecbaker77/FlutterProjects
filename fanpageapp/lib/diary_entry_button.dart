import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fanpageapp/diary_entry_button.dart';
import 'package:fanpageapp/diary_card.dart';
import 'package:fanpageapp/top_bar_title.dart';
import 'package:fanpageapp/diary_entry_model.dart';
import 'package:fanpageapp/pop_up_menu.dart';
import 'package:fanpageapp/emoji_helpers.dart';
import 'package:fanpageapp/diary_entry_page.dart';

class DiaryEntryButton extends StatelessWidget {
  const DiaryEntryButton({
    Key? key,
    required this.titleController,
    required this.bodyTextController,
    required String emoji,
    required this.widget,
  })  : _emoji = emoji,
        super(key: key);

  final TextEditingController titleController;
  final TextEditingController bodyTextController;
  final String _emoji;
  final DiaryEntryPage widget;

  @override
  Widget build(BuildContext context) {
    final isAddAction = widget.diaryAction == DiaryAction.add;
    return FloatingActionButton.extended(
      elevation: 2,
      onPressed: () {
        final id = widget.diaryEntry?.id ?? "";
        final diaryEntryMap = DiaryEntry(
          title: titleController.text,
          body: bodyTextController.text,
          emoji: _emoji,
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