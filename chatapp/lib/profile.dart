import 'package:chatapp/constants.dart';
import 'package:chatapp/database.dart';
import 'package:chatapp/chat.dart';
import 'package:chatapp/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController searchEditingController = new TextEditingController();

  QuerySnapshot? searchResultSnapshot;

  bool isLoading = false;
  bool haveUserSearched = false;




  Widget userTile(String userName, String userEmail) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Text(
                userEmail,
                style: TextStyle(color: Colors.black, fontSize: 16),
              )
            ],
          ),
        ],
      ),
    );
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var myScore = Constants.myScore;
    var rating = "";
    if (myScore.toString() == "NaN"){
      rating = "No Ratings Yet";
    } else if (myScore != null){
      rating = myScore.toString() + " / 5";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (Constants.myName.toString() + "'s Profile"),
        ),
        elevation: 0.0,
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username: " + Constants.myName.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  "Email: " + Constants.myEmail.toString(),
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Text(
                  "Average Chat Rating: " + rating,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
