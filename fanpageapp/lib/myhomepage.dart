import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fanpageapp/message_entry_model.dart';
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final messageEntries = Provider.of<List<MessageEntry>>(context);
    if (role == "admin") {
      return Scaffold(
        appBar: AppBar(
          bottom: const PreferredSize(
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
                const SizedBox(height: 40),
                for (var messageData in messageEntries)
                  MessageCard(messageEntry: messageData),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Log Out',
                        style: const TextStyle(
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
          bottom: const PreferredSize(
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
                const SizedBox(height: 40),
                for (var messageData in messageEntries)
                    MessageCard(messageEntry: messageData),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: 'Log Out',
                        style: const TextStyle(
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
