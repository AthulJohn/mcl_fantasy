import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcl_fantasy/auth/firebase.dart';
import 'package:mcl_fantasy/auth/sign.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:mcl_fantasy/widgets/loading.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 3,
                    child: Image.asset('assets/mcl.png'
                        // "https://drive.google.com/uc?export=view&id=1pkRm-_6c_3JOTD0vWOXfSB_EI8ImccJY",
                        //  headers: {"Authorization": "Bearer ${Provider.of<DataClass>(context).user.}"}
                        // errorBuilder:
                        //     (context, exception, StackTrace stacktrace) {
                        //   return Center(
                        //     child: Text('MCL Fantasy App'),
                        //   );
                        // },
                        // loadingBuilder: (context, exception, stacktrace) {
                        //   return Center(
                        //     child: Text('MCL Fantasy App'),
                        //   );
                        // },
                        ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Card(
                      margin: EdgeInsets.all(15),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/605c07da-2ce9-49c5-b4a0-1baf94053177/d82lkbh-25611235-0068-40f6-a9e9-28b91c03539d.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3sicGF0aCI6IlwvZlwvNjA1YzA3ZGEtMmNlOS00OWM1LWI0YTAtMWJhZjk0MDUzMTc3XC9kODJsa2JoLTI1NjExMjM1LTAwNjgtNDBmNi1hOWU5LTI4YjkxYzAzNTM5ZC5naWYifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6ZmlsZS5kb3dubG9hZCJdfQ.Zw5LraFAep1gzjTjLHIYm7DSW5_41isoZnB8XwUtXlk",
                          ),
                          colorFilter: new ColorFilter.mode(
                              Colors.white.withOpacity(0.2), BlendMode.dstATop),
                        )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 40,
                              width: 205,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                  gradient: new LinearGradient(colors: [
                                    Color(0xffb7485d),
                                    Color(0xfff14f5d)
                                  ])),
                              child: TextButton(
                                onPressed: () async {
                                  bool connected = false;
                                  setState(() {
                                    loading = true;
                                  });
                                  try {
                                    final result = await InternetAddress.lookup(
                                        'google.com');
                                    if (result.isNotEmpty &&
                                        result[0].rawAddress.isNotEmpty) {
                                      connected = true;
                                    }
                                  } on SocketException catch (_) {
                                    setState(() {
                                      loading = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Oops, No internet connection found! Please check your internet connection...')));
                                  }
                                  if (connected) {
                                    User u;
                                    try {
                                      u = await AuthService()
                                          .signInWithGoogle(context);
                                    } catch (e) {
                                      setState(() {
                                        loading = false;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Oops, Error while signing in!')));
                                      return;
                                    }
                                    if (!u.email.endsWith('mace.ac.in') &&
                                        u.email !=
                                            'johnychackopulickal@gmail.com') {
                                      try {
                                        setState(() {
                                          loading = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Please use your mace email id.')));
                                        AuthService().signOutGoogle(context);
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Oops, Error while signing in! Non-MACE ID Usage')));
                                        setState(() {
                                          loading = true;
                                        });
                                        return;
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    } else {
                                      try {
                                        Provider.of<DataClass>(context,
                                                listen: false)
                                            .updateuser(u);
                                        await FireBaseService()
                                            .getTeams(context);
                                      } catch (e) {
                                        setState(() {
                                          loading = false;
                                        });
                                        print(e);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Oops, Error getting data from Cloud!')));
                                        return;
                                      }
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
                                      setState(() {
                                        loading = false;
                                      });
                                      if (u != null)
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return Home(page);
                                        }));
                                    }
                                  }
                                },
                                child: Text(
                                  'Sign in using Google',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Please sign in using your MACE mail ID',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/macechef.png'),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
