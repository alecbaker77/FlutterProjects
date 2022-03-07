/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatapp/message_entry_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:chatapp/loginpage.dart';
import 'package:chatapp/top_bar_title.dart';
import 'package:chatapp/message_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
*/
/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  //final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {

    super.initState();
  }

  String role = "customer";

  @override
  Widget build(BuildContext context) {
    final messageEntries = Provider.of<List<MessageEntry>>(context);
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(94.0),
          child: TopBarTitle("Alec Baker's Chat App"),
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
        onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
            builder: (context) => LogInPage())
        ),
        tooltip: 'New Chat',
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}*/
