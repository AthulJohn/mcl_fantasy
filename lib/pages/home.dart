import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcl_fantasy/auth/firebase.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:provider/provider.dart';

import 'adminpanel.dart';

class Home extends StatefulWidget {
  final int page;
  Home(this.page);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController pgc;
  List<String> admins = [
    'johnychackopulickal@gmail.com',
    'b19cs068@mace.ac.in',
    'codechef@mace.ac.in'
  ];

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    pgc = PageController(initialPage: widget.page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Provider.of<DataClass>(context) == null
              ? Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text('Please wait, while we fetch your data!')
                    ],
                  ),
                )
              : Provider.of<DataClass>(context).matches.keys.length == 0
                  ? Center(
                      child: Column(
                        children: [Text('Looks like there is nothing here!')],
                      ),
                    )
                  : PageView(
                      controller: pgc,
                      children: [
                        if (admins.contains(
                            Provider.of<DataClass>(context).user.email))
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
                                          teams[Provider.of<DataClass>(context)
                                              .matches[s]
                                              .team1]['logo'],
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6666,
                                        ),
                                        Image.network(
                                          teams[Provider.of<DataClass>(context)
                                              .matches[s]
                                              .team2]['logo'],
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6666,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Image.network(
                                      "https://www.freepngimg.com/thumb/orange/85889-thunder-text-triangle-lightning-png-image-high-quality.png", //thunder image mattanam ithu match illa

                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.66,
                                      width: MediaQuery.of(context).size.width *
                                          0.2,
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
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
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
                                              if (Provider.of<DataClass>(
                                                          context)
                                                      .matches[s]
                                                      .voted !=
                                                  0)
                                                Text(
                                                  Provider.of<DataClass>(
                                                                  context)
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
                                                  ? Provider.of<DataClass>(context)
                                                          .matches[s]
                                                          .dateTime
                                                          .isBefore(DateTime.now()
                                                              .add(Duration(
                                                                  days: 1)))
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
                                                                        Radius.circular(
                                                                            5.0),
                                                                      ),
                                                                      gradient:
                                                                          new LinearGradient(
                                                                              colors: [
                                                                            Color(0xff4758dd),
                                                                            Color(0xff814fed)
                                                                          ])),
                                                              child: TextButton(
                                                                onPressed: () {
                                                                  FireBaseService()
                                                                      .vote(
                                                                          context,
                                                                          1,
                                                                          s);
                                                                },
                                                                child: Center(
                                                                  child: Text(
                                                                    '${Provider.of<DataClass>(context).matches[s].team1}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
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
                                                                        Radius.circular(
                                                                            5.0),
                                                                      ),
                                                                      gradient:
                                                                          new LinearGradient(
                                                                              colors: [
                                                                            Color(0xff4758dd),
                                                                            Color(0xff814fed)
                                                                          ])),
                                                              child: TextButton(
                                                                onPressed: () {
                                                                  FireBaseService()
                                                                      .vote(
                                                                          context,
                                                                          2,
                                                                          s);
                                                                },
                                                                child: Center(
                                                                  child: Text(
                                                                    '${Provider.of<DataClass>(context).matches[s].team2}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      : Text(
                                                          'Prediction not yet started!!')
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
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.leaderboard,
          ),
          onPressed: () async {
            await FireBaseService().findLeaderBoard(context);
            Navigator.pushNamed(context, 'leaderboard');
          },
        ));
  }
}
