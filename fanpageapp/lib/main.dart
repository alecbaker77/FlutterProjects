// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:firebase_core/firebase_core.dart';
import 'package:fanpageapp/splash.dart';
import 'package:flutter/material.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDj66B0Sw-lKzPCBNmIAUPdatTLUcmz5Y0",
      appId: "1:627744689399:web:708cb95fb6e9baa39717f2",
      messagingSenderId: "627744689399",
      projectId: "flutter-login-c6244",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
    );
  }
}

