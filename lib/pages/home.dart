import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:mcl_fantasy/auth/firebase.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:mcl_fantasy/pages/teamInfo.dart';
import 'package:mcl_fantasy/widgets/loading.dart';
import 'package:mcl_fantasy/widgets/mainCard.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

import 'adminpanel.dart';
import 'schedule.dart';

class Home extends StatefulWidget {
  final int page;
  Home(this.page);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  PageController pgc;
  List<String> admins = [
    'b19cs063@mace.ac.in',
    'johnychackopulickal@gmail.com',
    'b19cs068@mace.ac.in',
    'codechef@mace.ac.in'
  ];

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    if (widget.page != -1) pgc = PageController(initialPage: widget.page);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                  iconSize: 28,
                  icon: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  onPressed: () => _scaffoldKey.currentState.openDrawer()),
              actions: [
                IconButton(
                  iconSize: 28,
                  icon: Icon(
                    Icons.leaderboard,
                    color: Colors.black,
                  ),
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      await FireBaseService().findLeaderBoard(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Oops! Error getting Leaderboard!')));
                      return;
                    }
                    setState(() {
                      loading = false;
                    });
                    Navigator.pushNamed(context, 'leaderboard');
                  },
                )
              ],
            ),
            body: SafeArea(
              child: Provider.of<DataClass>(context) == null
                  ? Center(
                      child: Column(
                        children: [
                          SpinKitChasingDots(),
                          Text('Please wait, while we fetch your data!')
                        ],
                      ),
                    )
                  : PageView(
                      controller: pgc,
                      children: [
                        if (admins.contains(
                            Provider.of<DataClass>(context).user.email))
                          AdminPanel(),
                        if (Provider.of<DataClass>(context)
                                .matches
                                .keys
                                .length ==
                            0)
                          Center(
                            child: Column(
                              children: [
                                SpinKitRipple(
                                  color: Colors.black,
                                ),
                                Text(
                                  'No match has been scheduled!',
                                  style: GoogleFonts.aBeeZee(),
                                )
                              ],
                            ),
                          ),
                        for (String s
                            in Provider.of<DataClass>(context).matches.keys)
                          Card(
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            margin: EdgeInsets.all(12),
                            child: Column(
                              children: [
                                //Poster Card including of team logos and names
                                Expanded(flex: 3, child: MainMatchClass(s)),
                                //Prediction buttons
                                Expanded(
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Center(
                                        child: Opacity(
                                          opacity: 0.075,
                                          child: CachedNetworkImage(
                                            //CodeChef Logo
                                            imageUrl:
                                                "https://drive.google.com/uc?export=view&id=1WSDax83g2k3PC_R3-XU_YriW1F2Ulos3",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                child:

                                                    //IF 2: if it is match day (before 24 hours of the match time)
                                                    Provider.of<DataClass>(
                                                                context)
                                                            .matches[s]
                                                            .checkStartTime()
                                                        ? //IF 3: if the user has voted
                                                        Provider.of<DataClass>(
                                                                        context)
                                                                    .matches[s]
                                                                    .voted !=
                                                                'NILL'
                                                            ? Center(
                                                                child: Text(
                                                                  'Voted ${teams[Provider.of<DataClass>(context).matches[s].voted]['name']}',
                                                                  style: GoogleFonts
                                                                      .bebasNeue(
                                                                    color: teams[Provider.of<DataClass>(
                                                                            context)
                                                                        .matches[
                                                                            s]
                                                                        .voted]['color'],
                                                                    fontSize:
                                                                        24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                ),
                                                              )
                                                            : //ELSE of IF 3: (user has not voted)
                                                            // IF 5: if the match has not started/ended
                                                            Provider.of<DataClass>(
                                                                        context)
                                                                    .matches[s]
                                                                    .checkEndTime()
                                                                ? Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        'Predict the winner',
                                                                        style: GoogleFonts
                                                                            .bebasNeue(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                        ),
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.10,
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                35,
                                                                            width:
                                                                                85,
                                                                            decoration: BoxDecoration(
                                                                                shape: BoxShape.rectangle,
                                                                                borderRadius: BorderRadius.all(
                                                                                  Radius.circular(5.0),
                                                                                ),
                                                                                color: teams[Provider.of<DataClass>(context).matches[s].team1]['color']),
                                                                            child:
                                                                                TextButton(
                                                                              onPressed: () async {
                                                                                setState(() {
                                                                                  loading = true;
                                                                                });
                                                                                bool connect = await connected();
                                                                                if (connect) {
                                                                                  try {
                                                                                    await FireBaseService().vote(context, 1, Provider.of<DataClass>(context, listen: false).matches[s].team1, s);
                                                                                  } catch (e) {
                                                                                    setState(() {
                                                                                      loading = false;
                                                                                    });
                                                                                    print(e);
                                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Oops! Error submiting your Prediction!')));
                                                                                  }
                                                                                  setState(() {
                                                                                    loading = false;
                                                                                  });
                                                                                } else {
                                                                                  setState(() {
                                                                                    loading = false;
                                                                                  });
                                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Oops, Could not connect to a network!')));
                                                                                }
                                                                              },
                                                                              child: Center(
                                                                                child: Text(
                                                                                  '${Provider.of<DataClass>(context).matches[s].team1}',
                                                                                  style: TextStyle(
                                                                                    fontSize: 18,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.30,
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                35,
                                                                            width:
                                                                                85,
                                                                            decoration: BoxDecoration(
                                                                                shape: BoxShape.rectangle,
                                                                                borderRadius: BorderRadius.all(
                                                                                  Radius.circular(5.0),
                                                                                ),
                                                                                color: teams[Provider.of<DataClass>(context).matches[s].team2]['color']),
                                                                            child:
                                                                                TextButton(
                                                                              onPressed: () async {
                                                                                setState(() {
                                                                                  loading = true;
                                                                                });
                                                                                bool connect = await connected();
                                                                                if (connect) {
                                                                                  try {
                                                                                    await FireBaseService().vote(context, 2, Provider.of<DataClass>(context, listen: false).matches[s].team2, s);
                                                                                  } catch (e) {
                                                                                    setState(() {
                                                                                      loading = false;
                                                                                    });
                                                                                    print(e);
                                                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Oops! Error submiting your Prediction!')));
                                                                                  }
                                                                                  setState(() {
                                                                                    loading = false;
                                                                                  });
                                                                                } else {
                                                                                  setState(() {
                                                                                    loading = false;
                                                                                  });
                                                                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Oops, Could not connect to a network!')));
                                                                                }
                                                                              },
                                                                              child: Center(
                                                                                child: Text(
                                                                                  '${Provider.of<DataClass>(context).matches[s].team2}',
                                                                                  style: TextStyle(
                                                                                    fontSize: 18,
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  )
                                                                : Container()
                                                        : //ELSE of IF 2: (It is not match day)
                                                        Center(
                                                            child: Text(
                                                              'Prediction has not yet started!!',
                                                              style: GoogleFonts
                                                                  .bebasNeue(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 24,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ),
                                              ),
                                              !Provider.of<DataClass>(context)
                                                      .matches[s]
                                                      .checkEndTime() // IF 4: If the winner is unknown (not updated)
                                                  ? Provider.of<DataClass>(
                                                                  context)
                                                              .matches[s]
                                                              .winner ==
                                                          'NILL'
                                                      ? Center(
                                                          child: Text(
                                                            'Prediction Time Over!',
                                                            style: GoogleFonts
                                                                .bebasNeue(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        )
                                                      : //ELSE of IF 4: if the winner is updated
                                                      Center(
                                                          child: Text(
                                                            Provider.of<DataClass>(
                                                                            context)
                                                                        .matches[
                                                                            s]
                                                                        .winner ==
                                                                    'DRAW' // If the match is a draw
                                                                ? 'The match is a Draw!' // If the match has a winner
                                                                : teams[Provider.of<DataClass>(
                                                                            context)
                                                                        .matches[
                                                                            s]
                                                                        .winner]['name'] +
                                                                    ' has won',
                                                            style: GoogleFonts
                                                                .bebasNeue(
                                                              color: Provider.of<DataClass>(
                                                                              context)
                                                                          .matches[
                                                                              s]
                                                                          .winner ==
                                                                      'DRAW'
                                                                  ? Colors.blue
                                                                  : Provider.of<DataClass>(context).matches[s].winner ==
                                                                          Provider.of<DataClass>(context)
                                                                              .matches[
                                                                                  s]
                                                                              .voted
                                                                      ? Colors
                                                                          .green
                                                                      : Provider.of<DataClass>(context).matches[s].voted ==
                                                                              'NILL'
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .red,
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        )
                                                  : Container(),
                                            ]),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                      ],
                    ),
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  DrawerHeader(
                      child: CircleAvatar(
                    radius: 55,
                    foregroundImage: NetworkImage(
                        Provider.of<DataClass>(context).userstat.image),
                  )),
                  Text(Provider.of<DataClass>(context).getUserName(),
                      style: GoogleFonts.aBeeZee(fontSize: 23)),
                  Divider(),
                  Container(
                    child: Column(
                      children: [
                        Text('Total Matches Predicted',
                            style: GoogleFonts.aBeeZee(fontSize: 19)),
                        Text(
                            '${Provider.of<DataClass>(context).userstat.total}',
                            style: GoogleFonts.aBeeZee(fontSize: 19))
                      ],
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text('Won',
                                style: GoogleFonts.aBeeZee(fontSize: 19)),
                            Text(
                                '${Provider.of<DataClass>(context).userstat.won}',
                                style: GoogleFonts.aBeeZee(fontSize: 19))
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text('Lost',
                              style: GoogleFonts.aBeeZee(fontSize: 19)),
                          Text(
                              '${Provider.of<DataClass>(context).userstat.lost}',
                              style: GoogleFonts.aBeeZee(fontSize: 19))
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  Divider(),
                  TextButton(
                    child: Text(
                      'View Team Details',
                      style: GoogleFonts.aBeeZee(
                          fontSize: 17, color: Colors.black),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TeamDetails()));
                    },
                  ),
                  Divider(),
                  TextButton(
                      child: Text(
                        'View Match Schedule',
                        style: GoogleFonts.aBeeZee(
                            fontSize: 17, color: Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Schedule()));
                      }),
                ],
              ),
            ),
          );
  }
}
