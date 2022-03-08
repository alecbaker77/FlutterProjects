import 'package:firebase_core/firebase_core.dart';
import 'package:chatapp/loginpage.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDy6cpHq6cX_SfwZ8ujd8AWfPNss8vRPkM",
      appId: "1:725550754875:web:1b44351ffe0fa17135c01e",
      messagingSenderId: "725550754875",
      projectId: "chatapp-9ddf4",
    ),
  );




  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LogInPage(),
    );
  }
}