import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcl_fantasy/auth/firebase.dart';
import 'package:mcl_fantasy/Classes/dataClass.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Data data;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> vote(context, int no, String id) async {
    await firestore
        .collection('Fantasy Results')
        .doc(id)
        .collection(no == 1 ? 'Team 1' : 'Team 2')
        .add({
      'user': Provider.of<Data>(context, listen: false).user.email,
      'time': DateTime.now().toString()
    });
    DocumentSnapshot snap = await firestore
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false).user.email)
        .get();
    if (snap.exists) {
      await firestore
          .collection('Users')
          .doc(Provider.of<Data>(context, listen: false).user.email)
          .update({id: no});
    } else
      await firestore
          .collection('Users')
          .doc(Provider.of<Data>(context, listen: false).user.email)
          .set({'won': 0, 'lost': 0, id: no});

    Provider.of<Data>(context, listen: false).vote(no, id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Provider.of<Data>(context) == null
            ? Text('onnu wait cheyetto')
            : Provider.of<Data>(context).matches.keys.length == 0
                ? Text('ivide onnum illa')
                : PageView(
                    children: [
                      for (String s in Provider.of<Data>(context).matches.keys)
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
                                Image.network(
                                  "http://www.pngall.com/wp-content/uploads/5/Vertical-Line-PNG-File.png", //thunder image mattanam ithu match illa

                                  height:
                                      MediaQuery.of(context).size.height * 0.66,
                                  fit: BoxFit.cover,
                                )
                              ],
                            ),
                            Stack(
                              children: <Widget>[
                                Expanded(
                                  child: Card(
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
                                            children: [
                                              Text(
                                                '${Provider.of<Data>(context).matches[s].team1} vs ${Provider.of<Data>(context).matches[s].team2}',
                                                style: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 24,
                                                  fontFamily: "Monsterrat",
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              Text(
                                                Provider.of<Data>(context)
                                                            .matches[s]
                                                            .voted ==
                                                        1
                                                    ? 'Voted ${Provider.of<Data>(context).matches[s].team1}'
                                                    : 'Voted ${Provider.of<Data>(context).matches[s].team2}',
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
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.10,
                                                  ),
                                                  Container(
                                                    height: 35,
                                                    width: 85,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5.0),
                                                        ),
                                                        gradient:
                                                            new LinearGradient(
                                                                colors: [
                                                              Color(0xff4758dd),
                                                              Color(0xff814fed)
                                                            ])),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        vote(context, 1, s);
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          '${Provider.of<Data>(context).matches[s].team1}',
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
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.30,
                                                  ),
                                                  Container(
                                                    height: 35,
                                                    width: 85,
                                                    decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.rectangle,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5.0),
                                                        ),
                                                        gradient:
                                                            new LinearGradient(
                                                                colors: [
                                                              Color(0xff4758dd),
                                                              Color(0xff814fed)
                                                            ])),
                                                    child: TextButton(
                                                      onPressed: () {
                                                        vote(context, 2, s);
                                                      },
                                                      child: Center(
                                                        child: Text(
                                                          '${Provider.of<Data>(context).matches[s].team2}',
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
                                          ),
                                        ),
                                      ],
                                    ),
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
