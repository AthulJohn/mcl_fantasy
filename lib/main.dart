import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mcl_fantasy/pages/home.dart';
import 'package:mcl_fantasy/pages/signin.dart';
<<<<<<< HEAD
import 'package:mcl_fantasy/pages/signup.dart';
import 'package:mcl_fantasy/pages/votescreen.dart';
void main() {//
  Firebase.initializeApp();
=======
import 'package:provider/provider.dart';
import './classes/dataClass.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
>>>>>>> f8fb108374cbc33504b8e63e31f1cc78b2da7c60
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    return ChangeNotifierProvider<Data>(
        create: (context) => Data(),
        child: MaterialApp(
          title: 'MCL Fantasy',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          // routes: {
          //   'signin': (context) => Signin(),
          //   'home': (context) => Home()
          // },
          // initialRoute: 'signin',
          home: Signin(),
        ));
>>>>>>> f8fb108374cbc33504b8e63e31f1cc78b2da7c60
  }
}
