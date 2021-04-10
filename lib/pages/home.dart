import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:mcl_fantasy/auth/firebase.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:mcl_fantasy/widgets/loading.dart';
import 'package:mcl_fantasy/widgets/mainCard.dart';
import 'package:provider/provider.dart';

import 'adminpanel.dart';

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
    'johnychackopulickal@gmail.com',
    'b19cs068@mace.ac.in',
    'codechef@mace.ac.in'
  ];

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    pgc = PageController(initialPage: widget.page);
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
                  : Provider.of<DataClass>(context).matches.keys.length == 0
                      ? Center(
                          child: Column(
                            children: [
                              SpinKitRipple(),
                              Text('Looks like there is nothing here!')
                            ],
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
                                    //Poster Card including of team logos and names
                                    Expanded(flex: 3, child: MainMatchClass(s)),
                                    //Prediction buttons
                                    Expanded(
                                      child: Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          Center(
                                            child: Opacity(
                                              opacity: 0.1,
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
                                                                .dateTime
                                                                .isBefore(DateTime
                                                                        .now()
                                                                    .add(Duration(
                                                                        days:
                                                                            1)))
                                                            ? //IF 3: if the user has voted
                                                            Provider.of<DataClass>(
                                                                            context)
                                                                        .matches[
                                                                            s]
                                                                        .voted !=
                                                                    'NILL'
                                                                ? Center(
                                                                    child: Text(
                                                                      'Voted ${teams[Provider.of<DataClass>(context).matches[s].voted]['name']}',
                                                                      style: GoogleFonts
                                                                          .bebasNeue(
                                                                        color: teams[Provider.of<DataClass>(context)
                                                                            .matches[s]
                                                                            .voted]['color'],
                                                                        fontSize:
                                                                            24,
                                                                        fontWeight:
                                                                            FontWeight.w700,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : //ELSE of IF 3: (user has not voted)
                                                                // IF 5: if the match has started/ended
                                                                Provider.of<DataClass>(
                                                                            context)
                                                                        .matches[
                                                                            s]
                                                                        .dateTime
                                                                        .isAfter(
                                                                            DateTime.now())
                                                                    ? Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            'Predict the winner',
                                                                            style:
                                                                                GoogleFonts.bebasNeue(
                                                                              color: Colors.black,
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.w700,
                                                                            ),
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              SizedBox(
                                                                                width: MediaQuery.of(context).size.width * 0.10,
                                                                              ),
                                                                              Container(
                                                                                height: 35,
                                                                                width: 85,
                                                                                decoration: BoxDecoration(
                                                                                    shape: BoxShape.rectangle,
                                                                                    borderRadius: BorderRadius.all(
                                                                                      Radius.circular(5.0),
                                                                                    ),
                                                                                    color: teams[Provider.of<DataClass>(context).matches[s].team1]['color']),
                                                                                child: TextButton(
                                                                                  onPressed: () async {
                                                                                    setState(() {
                                                                                      loading = true;
                                                                                    });
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
                                                                                width: MediaQuery.of(context).size.width * 0.30,
                                                                              ),
                                                                              Container(
                                                                                height: 35,
                                                                                width: 85,
                                                                                decoration: BoxDecoration(
                                                                                    shape: BoxShape.rectangle,
                                                                                    borderRadius: BorderRadius.all(
                                                                                      Radius.circular(5.0),
                                                                                    ),
                                                                                    color: teams[Provider.of<DataClass>(context).matches[s].team2]['color']),
                                                                                child: TextButton(
                                                                                  onPressed: () async {
                                                                                    setState(() {
                                                                                      loading = true;
                                                                                    });
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
                                                                    fontSize:
                                                                        24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                ),
                                                              ),
                                                  ),
                                                  Provider.of<DataClass>(
                                                              context)
                                                          .matches[s]
                                                          .dateTime
                                                          .isBefore(DateTime
                                                              .now()) // IF 4: If the winner is unknown (not updated)
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
                                                                  color: Colors
                                                                      .black,
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
                                                                teams[Provider.of<DataClass>(
                                                                            context)
                                                                        .matches[
                                                                            s]
                                                                        .winner]['name'] +
                                                                    ' has won',
                                                                style: GoogleFonts
                                                                    .bebasNeue(
                                                                  color: Provider.of<DataClass>(context).matches[s].winner ==
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
                      child: Image.network(
                          Provider.of<DataClass>(context).userstat.image)),
                  Text(Provider.of<DataClass>(context).user.displayName),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Text('Won'),
                            Text(
                                '${Provider.of<DataClass>(context).userstat.won}')
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text('Lost'),
                          Text(
                              '${Provider.of<DataClass>(context).userstat.lost}')
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
