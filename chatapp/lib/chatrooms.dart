import 'package:chatapp/auth.dart';
import 'package:chatapp/constants.dart';
import 'package:chatapp/theme.dart';
import 'package:chatapp/database.dart';
import 'package:chatapp/chat.dart';
import 'package:chatapp/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/database.dart';
import 'package:chatapp/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/loginpage.dart';
import 'package:chatapp/database.dart';
import "package:chatapp/profile.dart";

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  Stream? chatRooms;
  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
            itemCount: (snapshot.data! as QuerySnapshot).docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ChatRoomsTile(
                userName: (snapshot.data! as QuerySnapshot).docs[index]['chatRoomId']
                    .toString()
                    .replaceAll("_", " and "),
                chatRoomId: (snapshot.data! as QuerySnapshot).docs[index]["chatRoomId"],
              );
            })
            : Container();
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    getChats();
    super.initState();
  }

  getUserInfo() async {
    print("trying");
    DatabaseMethods databaseMethods = new DatabaseMethods();
    final FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if(user != null) {
      Constants.myName = await databaseMethods.getUserName(user.uid);
      Constants.myEmail = await databaseMethods.getUserEmail(user.uid);
      Constants.userId = user.uid;
      Constants.myScore = await databaseMethods.getUserRating(user.uid);
      print("MY RATING IN CHATROOM = " + Constants.myScore.toString());
    }

  }
  getChats() async {
    DatabaseMethods().getAllChats().then((snapshots) {
      setState(() {
        chatRooms = snapshots;
      });
    });
}

  @override
  Widget build(BuildContext context) {
    print("BUILDING CHATROOMS");
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          ("Alec Baker's Chat App"),
        ),
        elevation: 0.0,
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () {
              AuthService().signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LogInPage()));
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app)),
          )
        ],
      ),
      body: Container(
        child: chatRoomsList(),
      ),

      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
        children: [

          FloatingActionButton(
            child: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Search()));
            },
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            child: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
          ),
        ]
      )


    );
  }
}

class ChatRoomsTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;

  ChatRoomsTile({required this.userName,required this.chatRoomId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Chat(
              chatRoomId: chatRoomId,
            )
        ));
      },
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            //color: Colors.black45,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(30)),
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(userName.split(" and ").first.substring(0, 1) + userName.split(" and ").last.substring(0, 1),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'OverpassRegular',
                          fontWeight: FontWeight.w300)),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(userName,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'OverpassRegular',
                        fontWeight: FontWeight.w300)),
                SizedBox(
                  width: 12,
                )
              ],
            ),

          ),
          SizedBox(
            height: 10,
          ),
        ]
      ),

    );
  }
}