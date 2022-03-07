import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {


  getUserInfo(String? email) async {
    return FirebaseFirestore.instance
        .collection("chatappusers")
        .where("userEmail", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserName(String? uid) async {
    var name = "";
    var data;
    await FirebaseFirestore.instance.collection("chatappusers").doc(uid).get().then ((DocumentSnapshot ds){
     data = ds.data();
    });
    if(data != null){
      name = data["userName"];
    }
    return name;
  }

  getUserEmail(String? uid) async {
    var email = "";
    var data;
    await FirebaseFirestore.instance.collection("chatappusers").doc(uid).get().then ((DocumentSnapshot ds){
      data = ds.data();
    });
    if(data != null){
      email = data["userEmail"];
    }
    return email;
  }


  searchByName(String? searchField) {
    return FirebaseFirestore.instance
        .collection("chatappusers")
        .where('userName', isEqualTo: searchField)
        .get();
  }

  Future<bool>? addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .set(chatRoom)
        .catchError((e) {
      print(e);
    });
  }

  getChats(String? chatRoomId) async {
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  getChatters(String? chatRoomId) async{
    var snapshot =  await FirebaseFirestore.instance.collection('chatRoom').doc(chatRoomId).get();
    var data = snapshot.data();
    var names = [];
    if (data != null){
      names = data["users"];
    }
    return names;
  }


  getUserId(String? userName) async{
    var data = await FirebaseFirestore.instance
    .collection("chatappusers")
    .where('userName', isEqualTo: userName)
    .get();
    for(DocumentSnapshot ds in data.docs){
      return ds.id;
    }
  }
  getAllChats() async {

    var collection =  await FirebaseFirestore.instance.collection('chatRoom');
    var snapshot = collection.snapshots();
    return snapshot;
  }

  Future<void>? addMessage(String? chatRoomId, chatMessageData) {
    FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData)
        .catchError((e) {
      print(e.toString());
    });
  }

  addRating(String? chatRoomId, userName, rating) async{
    //delete previous user ratings for chatroom
    await FirebaseFirestore.instance.collection('chatRoom').doc(chatRoomId).collection("ratings").where("sendBy", isEqualTo: userName).get().then((snapshot){
        for(DocumentSnapshot ds in snapshot.docs){
          ds.reference.delete();
}
    });
    //add new rating to chatroom
    await FirebaseFirestore.instance
       .collection("chatRoom")
       .doc(chatRoomId)
       .collection("ratings")
       .add(rating)
       .catchError((e) {
          print(e.toString());
       });
    var chatters = await getChatters(chatRoomId);
    var userOne = await getUserId(chatters.toString().split(",").first.replaceAll("[", "").trim());
    var userTwo = await getUserId(chatters.toString().split(",").last.replaceAll("]", "").trim());
    await addUserRating(chatRoomId, userOne, rating, userName);
    await addUserRating(chatRoomId, userTwo, rating, userName);
  }

  addUserRating(String? chatRoomId, userId, rating, userName) async{
    await FirebaseFirestore.instance.collection('chatappusers').doc(userId).collection("ratings").where("chatRoomId", isEqualTo: chatRoomId).where("sendBy", isEqualTo: userName).get().then((snapshot){
    for(DocumentSnapshot ds in snapshot.docs){
      ds.reference.delete();
    }
    });
    await FirebaseFirestore.instance
      .collection("chatappusers")
      .doc(userId)
     .collection("ratings")
     .add(rating)
     .catchError((e) {
     print(e.toString());
    });
  }


  getUserRating(String? userId) async {
    var snapshot = await FirebaseFirestore.instance
    .collection("chatappusers")
    .doc(userId)
    .collection("ratings")
    .get();

    var data;
    num rating = 0;
    num index = 0;
    for(DocumentSnapshot ds in snapshot.docs){
      data = ds.data();
      if (data != null){
        rating += data["rating"];
        index += 1;
      }
    }

    rating = rating / index;
    return rating;


  }

  getChatRoomRating(String? chatRoomId) async {
    var snapshot = await FirebaseFirestore.instance
    .collection("chatRoom")
    .doc(chatRoomId)
    .collection("ratings")
    .get();

    var data;
    num rating = 0;
    num index = 0;
    for(DocumentSnapshot ds in snapshot.docs){
      data = ds.data();
      if (data != null){
        rating += data["rating"];
        index += 1;
      }
    }

    rating = rating / index;
    print("RATINGGGG for CHATROOM ------" + rating.toString());
    return rating;
  }

  getUserChats(String? itIsMyName) async {
    return await FirebaseFirestore.instance
        .collection("chatRoom")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}
