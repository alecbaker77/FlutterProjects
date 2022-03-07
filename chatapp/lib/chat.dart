
import 'dart:io';
import 'package:chatapp/constants.dart';
import 'package:chatapp/database.dart';
import 'package:chatapp/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import "package:chatapp/constants.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";

class Chat extends StatefulWidget {
  final String chatRoomId;

  Chat({required this.chatRoomId});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  var chatters;
  var currentRating;

  Stream<QuerySnapshot>? chats;

  TextEditingController messageEditingController = new TextEditingController();

  Widget chatMessages() {
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      message: (snapshot.data! as QuerySnapshot).docs[index]
                          ["message"],
                      sendBy: (snapshot.data! as QuerySnapshot).docs[index]
                          ["sendBy"],
                      chatters: chatters);
                })
            : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  addRating(rating){
    Map<String, dynamic> chatRatingMap = {
      "chatRoomId": widget.chatRoomId,
      "sendBy": Constants.myName,
      "rating": rating,
      'time': DateTime.now().millisecondsSinceEpoch,
    };
    DatabaseMethods().addRating(widget.chatRoomId, Constants.myName, chatRatingMap);
  }

  @override
  void initState() {
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    DatabaseMethods().getChatters(widget.chatRoomId).then((val) {
      setState(() {
        chatters = val;
      });
    });
    DatabaseMethods().getChatRoomRating(widget.chatRoomId).then((val) {
      setState(() {

        var myScore = val;
        if (myScore.toString() == "NaN"){
          currentRating = "No Ratings Yet";
        } else if (myScore != null){
          currentRating = myScore.toString() + " / 5";
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("CHATTERS IN CHAT --- " + chatters.toString().split(",").first.replaceAll("[", ""));
    if (chatters.toString().contains(Constants.myName.toString())) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            (chatters
                .toString()
                .replaceAll("[", "")
                .replaceAll(", ", " and ")
                .replaceAll("]", "")) + "           Logged in as: " + Constants.myName.toString()
                + "            Current Chat Rating: " + currentRating.toString()
          ),
        ),
        body: Container(
          child: Stack(
            children: [
              chatMessages(),
              Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  color: Color(0x54FFFFFF),
                  child: Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: messageEditingController,
                        style: simpleTextStyle(),
                        decoration: InputDecoration(
                            hintText: "Message ...",
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            border: InputBorder.none),
                      )),
                      SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          addMessage();
                        },
                        child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      const Color(0x36FFFFFA),
                                      const Color(0x0FFFFFFA)
                                    ],
                                    begin: FractionalOffset.topLeft,
                                    end: FractionalOffset.bottomRight),
                                borderRadius: BorderRadius.circular(40)),
                            padding: EdgeInsets.all(12),
                            child: Image.asset(
                              "assets/images/send.png",
                              height: 25,
                              width: 25,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            (chatters
                .toString()
                .replaceAll("[", "")
                .replaceAll(", ", " x ")
                .replaceAll("]", "")) + "           Logged in as: " + Constants.myName.toString()
                + "            Current Chat Rating: " + currentRating.toString()
          ),
        ),
        body: Container(
          child: Stack(
            children: [
              chatMessages(),
              SizedBox(
                width: 16,
              ),
              Container(
                alignment: Alignment.bottomCenter,
                width: MediaQuery.of(context).size.width,
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    addRating(rating);
                  },
                ),
              ),
              SizedBox(
                width: 16,
              ),

            ],
          ),
        ),
      );
    }
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final String sendBy;
  var chatters;

  MessageTile(
      {required this.message, required this.sendBy, required this.chatters});

  @override
  Widget build(BuildContext context) {
    bool sendByMe;
    if (!chatters.toString().contains(Constants.myName.toString())) {
      sendByMe = chatters.toString().split(",").first.contains(sendBy);
    } else {
      sendByMe = Constants.myName == sendBy;
    }
    if (sendByMe) {
      return Container(
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 0, right: 24),
        alignment: Alignment.centerRight,

        child: Column(
          children: [
            Text(
              sendBy
            ),
            Container(
              margin: EdgeInsets.only(left: 30),
              padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomLeft: Radius.circular(23)),
                  gradient: LinearGradient(
                    colors: [ Colors.indigo, Colors.indigo],
                  )),
              child: Text(message,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
            )
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 24, right: 0),
        alignment: Alignment.centerLeft,

        child: Column(
          children: [
            Text(
              sendBy
            ),
            Container(
              margin: EdgeInsets.only(right: 30),
              padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(23),
                      topRight: Radius.circular(23),
                      bottomRight: Radius.circular(23)),
                  gradient: LinearGradient(
                    colors: [Colors.indigo, Colors.indigo],
                  )),
              child: Text(message,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'OverpassRegular',
                      fontWeight: FontWeight.w300)),
            )
          ]
        )
      );
    }
  }
}
