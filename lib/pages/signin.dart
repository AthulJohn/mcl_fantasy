import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcl_fantasy/auth/firebase.dart';
import 'package:mcl_fantasy/auth/sign.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Image.network(
                  "https://drive.google.com/uc?export=view&id=1pkRm-_6c_3JOTD0vWOXfSB_EI8ImccJY"),
            ),
            Expanded(
              flex: 3,
              child: Card(
                child: Center(
                  child: Stack(
                    children: [
                      Center(
                        child: Opacity(
                          opacity: 0.1,
                          child: Image.network(
                            "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/605c07da-2ce9-49c5-b4a0-1baf94053177/d82lkbh-25611235-0068-40f6-a9e9-28b91c03539d.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3sicGF0aCI6IlwvZlwvNjA1YzA3ZGEtMmNlOS00OWM1LWI0YTAtMWJhZjk0MDUzMTc3XC9kODJsa2JoLTI1NjExMjM1LTAwNjgtNDBmNi1hOWU5LTI4YjkxYzAzNTM5ZC5naWYifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6ZmlsZS5kb3dubG9hZCJdfQ.Zw5LraFAep1gzjTjLHIYm7DSW5_41isoZnB8XwUtXlk",
                            height: MediaQuery.of(context).size.height,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 35,
                              width: 85,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  gradient: new LinearGradient(colors: [
                                    Color(0xff4758dd),
                                    Color(0xff814fed)
                                  ])),
                              child: TextButton(
                                onPressed: () async {
                                  User u = await AuthService()
                                      .signInWithGoogle(context);
                                  if (!u.email.endsWith('mace.ac.in') &&
                                      u.email !=
                                          'johnychackopulickal@gmail.com') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Please use your mace email id.')));
                                    AuthService().signOutGoogle(context);
                                  } else {
                                    Provider.of<DataClass>(context,
                                            listen: false)
                                        .updateuser(u);
                                    await FireBaseService().getTeams(context);
                                    int page = 1;
                                    for (String s in Provider.of<DataClass>(
                                            context,
                                            listen: false)
                                        .matches
                                        .keys)
                                      if (Provider.of<DataClass>(context,
                                              listen: false)
                                          .matches[s]
                                          .dateTime
                                          .isAfter(DateTime.now())) {
                                        page = Provider.of<DataClass>(context,
                                                    listen: false)
                                                .matches
                                                .keys
                                                .toList()
                                                .indexOf(s) +
                                            1;
                                        break;
                                      }
                                    if (u != null)
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Home(page);
                                      }));
                                  }
                                },
                                child: Center(
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Please sign in using your MACE mail ID',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Image.network(
                  "https://drive.google.com/uc?export=view&id=1AFOecVT5hadOZyafBNeISMMK2SvlIVwc"),
            ),
          ],
        ),
      ),
    );
  }
}
