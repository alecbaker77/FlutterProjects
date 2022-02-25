import 'package:flutter/material.dart';
import 'package:fanpageapp/diary_entry_button.dart';
import 'package:fanpageapp/message_card.dart';
import 'package:fanpageapp/top_bar_title.dart';
import 'package:fanpageapp/diary_entry_model.dart';
import 'package:fanpageapp/pop_up_menu.dart';
import 'package:fanpageapp/diary_entry_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DiaryEntryPage extends StatefulWidget {
  const DiaryEntryPage({
    Key? key,
    this.diaryAction,
    this.diaryEntry,
  }) : super(key: key);


  const DiaryEntryPage.edit(
      {Key? key, this.diaryAction = DiaryAction.edit, this.diaryEntry})
      : super(key: key);

  const DiaryEntryPage.add(
      {Key? key, this.diaryAction = DiaryAction.add, this.diaryEntry})
      : super(key: key);

  const DiaryEntryPage.read(
      {Key? key, this.diaryAction = DiaryAction.read, this.diaryEntry})
      : super(key: key);

  final DiaryEntry? diaryEntry;

  final DiaryAction? diaryAction;

  @override
  _DiaryEntryPageState createState() => _DiaryEntryPageState();
}

class _DiaryEntryPageState extends State<DiaryEntryPage> {
  TextEditingController bodyTextController = TextEditingController();
  bool isReadOnly = true;

  String role = "customer";

  void _checkRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('fanpageusers')
        .doc(user?.uid)
        .get();
    role = snap['role'];
    print(role);
    if (role == "admin") {
      isReadOnly = false;
    }else {
      isReadOnly = true;
    }
    setState(() {});
  }
  @override
  void initState() {
    bodyTextController = TextEditingController(text: widget.diaryEntry?.body ?? '');
    _checkRole();

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
                SizedBox(height: 50),
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
                SizedBox(height: 100)
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isReadOnly
          ? SizedBox()
          : DiaryEntryButton(
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

enum DiaryAction { edit, add, read }
