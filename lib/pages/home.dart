import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcl_fantasy/auth/firebase.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:provider/provider.dart';

import 'adminpanel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Data data;

  List<String> admins = [
    'johnychackopulickal@gmail.com',
    'b19cs068@mace.ac.in',
    'codechef@mace.ac.in'
  ];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Provider.of<DataClass>(context) == null
            ? Text('onnu wait cheyetto')
            : Provider.of<DataClass>(context).matches.keys.length == 0
                ? Text('ivide onnum illa')
                : PageView(
                    children: [
                      if (admins
                          .contains(Provider.of<DataClass>(context).user.email))
                        AdminPanel(),
                      for (String s
                          in Provider.of<DataClass>(context).matches.keys)
                        Column(
                          children: [
                            Stack(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: <Widget>[
                                      Image.network(
                                        "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/mh-12-30-tanner-3-1-1609368496.png",
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.6666,
                                      ),
                                      Image.network(
                                        "https://i0.wp.com/decider.com/wp-content/uploads/2019/04/tory-cobra-kai.jpg?quality=80&strip=all&ssl=1",
                                        fit: BoxFit.cover,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.6666,
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Image.network(
                                    "https://www.freepngimg.com/thumb/orange/85889-thunder-text-triangle-lightning-png-image-high-quality.png", //thunder image mattanam ithu match illa

                                    height: MediaQuery.of(context).size.height *
                                        0.66,
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              ],
                            ),
                            Stack(
                              children: <Widget>[
                                Card(
                                  borderOnForeground: false,
                                  elevation: 5.0,
                                  semanticContainer: false,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Opacity(
                                          opacity: 0.2,
                                          child: Image.network(
                                            "https://drive.google.com/uc?export=view&id=1WSDax83g2k3PC_R3-XU_YriW1F2Ulos3",
                                            fit: BoxFit.contain,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.15,
                                          ),
                                        ),
                                      ),
                                      // Center(
                                      //   child: Opacity(
                                      //     opacity: 0.1,
                                      //     child: Image.network(
                                      //       "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/605c07da-2ce9-49c5-b4a0-1baf94053177/d82lkbh-25611235-0068-40f6-a9e9-28b91c03539d.gif?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3sicGF0aCI6IlwvZlwvNjA1YzA3ZGEtMmNlOS00OWM1LWI0YTAtMWJhZjk0MDUzMTc3XC9kODJsa2JoLTI1NjExMjM1LTAwNjgtNDBmNi1hOWU5LTI4YjkxYzAzNTM5ZC5naWYifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6ZmlsZS5kb3dubG9hZCJdfQ.Zw5LraFAep1gzjTjLHIYm7DSW5_41isoZnB8XwUtXlk",
                                      //       height: MediaQuery.of(context)
                                      //               .size
                                      //               .height *
                                      //           0.1,
                                      //       fit: BoxFit.fill,
                                      //     ),
                                      //   ),
                                      // ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.28,
                                        decoration: BoxDecoration(
                                          gradient: new LinearGradient(
                                            colors: [
                                              Color(0x319fa4c4),
                                              Color(0x41b3cdd1)
                                            ],
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              '${Provider.of<DataClass>(context).matches[s].team1} vs ${Provider.of<DataClass>(context).matches[s].team2}',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 24,
                                                fontFamily: "Monsterrat",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              Provider.of<DataClass>(context)
                                                          .matches[s]
                                                          .voted ==
                                                      1
                                                  ? 'Voted ${Provider.of<DataClass>(context).matches[s].team1}'
                                                  : 'Voted ${Provider.of<DataClass>(context).matches[s].team2}',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 17,
                                                fontFamily: "Monsterrat",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 40,
                                            ),
                                            Provider.of<DataClass>(context)
                                                    .matches[s]
                                                    .dateTime
                                                    .isAfter(DateTime.now())
                                                ? Row(
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.10,
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        width: 85,
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0),
                                                                ),
                                                                gradient:
                                                                    new LinearGradient(
                                                                        colors: [
                                                                      Color(
                                                                          0xff4758dd),
                                                                      Color(
                                                                          0xff814fed)
                                                                    ])),
                                                        child: TextButton(
                                                          onPressed: () {
                                                            FireBaseService()
                                                                .vote(context,
                                                                    1, s);
                                                          },
                                                          child: Center(
                                                            child: Text(
                                                              '${Provider.of<DataClass>(context).matches[s].team1}',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.30,
                                                      ),
                                                      Container(
                                                        height: 35,
                                                        width: 85,
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0),
                                                                ),
                                                                gradient:
                                                                    new LinearGradient(
                                                                        colors: [
                                                                      Color(
                                                                          0xff4758dd),
                                                                      Color(
                                                                          0xff814fed)
                                                                    ])),
                                                        child: TextButton(
                                                          onPressed: () {
                                                            FireBaseService()
                                                                .vote(context,
                                                                    2, s);
                                                          },
                                                          child: Center(
                                                            child: Text(
                                                              '${Provider.of<DataClass>(context).matches[s].team2}',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                : Provider.of<DataClass>(
                                                                context)
                                                            .matches[s]
                                                            .winner ==
                                                        'NILL'
                                                    ? Text(
                                                        'Prediction Time Over!')
                                                    : Text(
                                                        Provider.of<DataClass>(
                                                                    context)
                                                                .matches[s]
                                                                .winner +
                                                            ' has won'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                    ],
                  ),
      ),
    );
  }
}
