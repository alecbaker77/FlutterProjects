import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fanpageapp/message_entry_model.dart';
import 'package:fanpageapp/message_entry_page.dart';

class MessageEntryButton extends StatelessWidget {
  const MessageEntryButton({
    Key? key,
    required this.bodyTextController,
    required this.widget,
  })  :
        super(key: key);


  final TextEditingController bodyTextController;

  final MessageEntryPage widget;

  @override
  Widget build(BuildContext context) {
    final isAddAction = widget.messageAction == MessageAction.add;
    return FloatingActionButton.extended(
      elevation: 2,
      onPressed: () {
        final id = widget.messageEntry?.id ?? "";
        final messageEntryMap = MessageEntry(
          body: bodyTextController.text,
          id: id,
        ).toMap();


        if (isAddAction) {
          FirebaseFirestore.instance.collection('messages').add(messageEntryMap);
        } else {
          FirebaseFirestore.instance
              .collection('messages')
              .doc(id)
              .update(messageEntryMap);
        }

        Navigator.of(context).popUntil(ModalRoute.withName('/'));
      },
      label: Text(isAddAction ? 'Post Message' : 'Update'),
      icon: Icon(isAddAction ? Icons.book : Icons.bookmark_border),
    );
  }
}