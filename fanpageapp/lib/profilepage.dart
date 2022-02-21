import 'package:firebase_core/firebase_core.dart';
import 'package:fanpageapp/splash.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpageapp/myhomepage.dart';
import 'package:fanpageapp/diary_entry_model.dart';
import 'package:fanpageapp/pop_up_menu.dart';
import 'package:fanpageapp/diary_entry_page.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
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
        title: 'My Diary',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.pink,
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