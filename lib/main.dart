import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mcl_fantasy/pages/home.dart';
import 'package:mcl_fantasy/pages/signin.dart';
import 'package:mcl_fantasy/pages/signup.dart';
import 'package:mcl_fantasy/pages/votescreen.dart';
void main() {//
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MCL Fantasy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: 'votescreen',
      routes: {
        'signin': (context) => Signin(),
        'signup': (context) => SignUp(),
        'home': (context) => Home(),
        'votescreen':(context)=>VoteScreen()
      },
    );
  }
}
