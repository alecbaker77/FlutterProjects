import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpageapp/myhomepage.dart';
import 'package:fanpageapp/message_entry_model.dart';
import 'package:fanpageapp/message_entry_page.dart';
import 'package:provider/provider.dart';

class TransitionPage extends StatelessWidget {
  const TransitionPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final messageCollection = FirebaseFirestore.instance.collection('messages');
    final messageStream = messageCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => MessageEntry.fromDoc(doc)).toList();
    });

    return StreamProvider<List<MessageEntry>>(
      initialData: [],
      create: (_) => messageStream,
      child: MaterialApp(
        title: "Alec Baker's Fanpage",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          secondaryHeaderColor: Colors.pink,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(),
          '/new-entry': (context) => const MessageEntryPage.add(),
        },
      ),
    );
  }
}