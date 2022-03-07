import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/myhomepage.dart';
import 'package:chatapp/message_entry_model.dart';
import 'package:chatapp/message_entry_page.dart';
import 'package:provider/provider.dart';
import 'package:chatapp/chatrooms.dart';
import "package:chatapp/database.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:chatapp/constants.dart";
class TransitionPage extends StatelessWidget {
  const TransitionPage({Key? key}) : super(key: key);
  @override

  Widget build(BuildContext context) {
    final messageCollection = FirebaseFirestore.instance.collection('chats');
    final messageStream = messageCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => MessageEntry.fromDoc(doc)).toList();
    });

    return StreamProvider<List<MessageEntry>>(
      initialData: [],
      create: (_) => messageStream,
      child: MaterialApp(
        title: "Alec Baker's Chat App",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          secondaryHeaderColor: Colors.pink,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) =>  ChatRoom(),
          '/new-entry': (context) => const MessageEntryPage.add(),
        },
      ),
    );
  }

}