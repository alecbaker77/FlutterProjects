import 'package:flutter/material.dart';
import 'package:chatapp/message_entry_button.dart';
import 'package:chatapp/message_entry_model.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageEntryPage extends StatefulWidget {
  const MessageEntryPage({
    Key? key,
    this.messageAction,
    this.messageEntry,
  }) : super(key: key);


  const MessageEntryPage.edit(
      {Key? key, this.messageAction = MessageAction.edit, this.messageEntry})
      : super(key: key);

  const MessageEntryPage.add(
      {Key? key, this.messageAction = MessageAction.add, this.messageEntry})
      : super(key: key);

  const MessageEntryPage.read(
      {Key? key, this.messageAction = MessageAction.read, this.messageEntry})
      : super(key: key);

  final MessageEntry? messageEntry;

  final MessageAction? messageAction;

  @override
  _MessageEntryPageState createState() => _MessageEntryPageState();
}

class _MessageEntryPageState extends State<MessageEntryPage> {
  TextEditingController bodyTextController = TextEditingController();
  bool isReadOnly = true;

  String role = "customer";

  @override
  void initState() {
    bodyTextController = TextEditingController(text: widget.messageEntry?.body ?? '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.black),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 3 / 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 50),
                TextField(
                  readOnly: false,
                  controller: bodyTextController,
                  maxLines: null,
                  style: Theme.of(context)
                      .textTheme
                      .headline6,
                  //.copyWith(color: Colors.black87, height: 1.7),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Type your message here.',
                    border: InputBorder.none,
                    hintStyle: Theme.of(context)
                        .textTheme
                        .headline6,
                    //.copyWith(color: Colors.grey.shade400),
                  ),
                ),
                const SizedBox(height: 100)
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isReadOnly
          ? const SizedBox()
          : MessageEntryButton(
        bodyTextController: bodyTextController,
        widget: widget,
      ),
    );
  }

  @override
  void dispose() {
    bodyTextController.dispose();
    super.dispose();
  }
}

enum MessageAction { edit, add, read }

