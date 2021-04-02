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

  String dateFormat(DateTime dt) {
    List months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }

  String timeFormat(DateTime dt) {
    String ampm;
    int hr = dt.hour;
    if (dt.hour < 12) {
      ampm = 'AM';
    } else {
      hr = dt.hour - 12;
      ampm = 'PM';
    }
    if (hr == 0) hr = 12;
    String toreturn = '';
    if (hr < 10) toreturn += '0';
    toreturn += '$hr:';
    if (dt.minute < 9) toreturn += '0';
    toreturn += '${dt.minute} $ampm';
    return toreturn;
  }

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
                          Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            margin: EdgeInsets.all(12),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    // width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14),
                                        gradient: LinearGradient(colors: [
                                          teams[Provider.of<DataClass>(context)
                                              .matches[s]
                                              .team1]['color'],
                                          teams[Provider.of<DataClass>(context)
                                              .matches[s]
                                              .team2]['color']
                                        ])),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          s,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 22,
                                            fontFamily: "Monsterrat",
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Row(
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 4,
                                              child: Image.network(
                                                teams[Provider.of<DataClass>(
                                                        context)
                                                    .matches[s]
                                                    .team1]['logo'],
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Expanded(
                                              child: Image.network(
                                                'https://comicvine1.cbsistatic.com/uploads/original/11141/111417311/7460362-versus-letters-vs-logo-vector-13673484.png',
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Image.network(
                                                teams[Provider.of<DataClass>(
                                                        context)
                                                    .matches[s]
                                                    .team2]['logo'],
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              dateFormat(Provider.of<DataClass>(
                                                      context)
                                                  .matches[s]
                                                  .dateTime),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontFamily: "Monsterrat",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            Text(
                                              timeFormat(Provider.of<DataClass>(
                                                      context)
                                                  .matches[s]
                                                  .dateTime),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontFamily: "Monsterrat",
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Center(
                                  //     child: Container(
                                  //   child: Column(
                                  //     mainAxisAlignment:
                                  //         MainAxisAlignment.spaceAround,
                                  //     children: [],
                                  //   ),
                                  // ))
                                  // Center(
                                  //   child: Image.network(
                                  //     "https://www.freepngimg.com/thumb/orange/85889-thunder-text-triangle-lightning-png-image-high-quality.png", //thunder image mattanam ithu match illa

                                  //     height: MediaQuery.of(context)
                                  //             .size
                                  //             .height *
                                  //         0.66,
                                  //     width: MediaQuery.of(context)
                                  //             .size
                                  //             .width *
                                  //         0.2,
                                  //     fit: BoxFit.fill,
                                  //   ),
                                  // )
                                ),
                                Stack(
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.28,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  '${teams[Provider.of<DataClass>(context).matches[s].team1]['name']}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 22,
                                                    fontFamily: "Monsterrat",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'vs',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 22,
                                                    fontFamily: "Monsterrat",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  '${teams[Provider.of<DataClass>(context).matches[s].team2]['name']}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 22,
                                                    fontFamily: "Monsterrat",
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ],
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
                                                  ? Provider.of<DataClass>(
                                                                  context)
                                                              .matches[s]
                                                              .voted !=
                                                          0
                                                      ? Center(
                                                          child: Text(
                                                            Provider.of<DataClass>(
                                                                            context)
                                                                        .matches[
                                                                            s]
                                                                        .voted ==
                                                                    1
                                                                ? 'Voted ${Provider.of<DataClass>(context).matches[s].team1}'
                                                                : 'Voted ${Provider.of<DataClass>(context).matches[s].team2}',
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                              fontSize: 17,
                                                              fontFamily:
                                                                  "Monsterrat",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        )
                                                      : Row(
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
                                                  : Center(
                                                      child: Text(
                                                          'Prediction not yet started!!'),
                                                    )
                                              : Provider.of<DataClass>(context)
                                                          .matches[s]
                                                          .winner ==
                                                      'NILL'
                                                  ? Center(
                                                      child: Text(
                                                          'Prediction Time Over!'),
                                                    )
                                                  : Center(
                                                      child: Text(
                                                          Provider.of<DataClass>(
                                                                      context)
                                                                  .matches[s]
                                                                  .winner +
                                                              ' has won'),
                                                    ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
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
