import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpageapp/myhomepage.dart';
import 'package:fanpageapp/diary_entry_model.dart';
import 'package:fanpageapp/diary_entry_page.dart';
import 'package:provider/provider.dart';

class TransitionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final diaryCollection = FirebaseFirestore.instance.collection('messages');
    final diaryStream = diaryCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => DiaryEntry.fromDoc(doc)).toList();
    });

    return StreamProvider<List<DiaryEntry>>(
      initialData: [],
      create: (_) => diaryStream,
      child: MaterialApp(
        title: "Alec Baker's Fanpage",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          secondaryHeaderColor: Colors.pink,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(),
          '/new-entry': (context) => DiaryEntryPage.add(),
        },
      ),
    );
  }
}