import 'package:firebase_core/firebase_core.dart';
import 'package:fanpageapp/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDj66B0Sw-lKzPCBNmIAUPdatTLUcmz5Y0",
      appId: "1:627744689399:web:708cb95fb6e9baa39717f2",
      messagingSenderId: "627744689399",
      projectId: "flutter-login-c6244",
    ),
  );
  if (kIsWeb) {
    // initialize the facebook javascript SDK
    FacebookAuth.i.webInitialize(
      appId: "506116797609060",//<-- YOUR APP_ID
      cookie: true,
      xfbml: true,
      version: "v12.0",
    );
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Splash(),
    );
  }
}

