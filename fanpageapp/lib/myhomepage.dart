import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpageapp/diary_entry_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:fanpageapp/loginpage.dart';
import 'package:fanpageapp/top_bar_title.dart';
import 'package:fanpageapp/message_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  //final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState(){
    _checkRole();
    super.initState();
  }

  String role = "customer";

  void _checkRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    final DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('fanpageusers')
        .doc(user?.uid)
        .get();
    role = snap['role'];
    print(role + "1");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final diaryEntries = Provider.of<List<DiaryEntry>>(context);
    if (role == "admin") {
      print(role + "2");
      return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(94.0),
            child: TopBarTitle("Alec Baker's Fanpage"),
          ),
          elevation: 0,
        ),
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 3 / 5,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 40),
                if (diaryEntries != null)
                  for (var diaryData in diaryEntries)
                    MessageCard(diaryEntry: diaryData),
                if (diaryEntries == null)
                  Center(child: CircularProgressIndicator()),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Log Out',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogInPage()));
                          }),
                  ]),
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          elevation: 1.5,
          onPressed: () => Navigator.of(context).pushNamed('/new-entry'),
          tooltip: 'New Entry',
          child: Icon(Icons.add),
          backgroundColor: Theme.of(context).colorScheme.secondary,
        ),
      );
    } else {
      print(role + "3");
      return Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(94.0),
            child: TopBarTitle("Alec Baker's Fanpage"),
          ),
          elevation: 0,
        ),
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 3 / 5,
            child: ListView(
              children: <Widget>[
                SizedBox(height: 40),
                if (diaryEntries != null)
                  for (var diaryData in diaryEntries)
                    MessageCard(diaryEntry: diaryData),
                if (diaryEntries == null)
                  Center(child: CircularProgressIndicator()),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Log Out',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LogInPage()));
                          }),
                  ]),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
