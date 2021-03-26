import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:polls/polls.dart';

class VoteScreen extends StatefulWidget {
  VoteScreen({Key key}) : super(key: key);

  @override
  _VoteScreenState createState() => _VoteScreenState();
}

class _VoteScreenState extends State<VoteScreen> {
  Map usersWhoVoted = {
    'sam@mail.com': 3,
    'mike@mail.com': 4,
    'john@mail.com': 1,
    'kenny@mail.com': 1
  };
  double option1 = 0.0;
  double option2 = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    Image.network(
                      "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/mh-12-30-tanner-3-1-1609368496.png",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height * 0.6666,
                    ),
                    Image.network(
                      "https://i0.wp.com/decider.com/wp-content/uploads/2019/04/tory-cobra-kai.jpg?quality=80&strip=all&ssl=1",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height * 0.6666,
                    ),
                  ],
                ),
              ),
              Image.network(
                "http://www.pngall.com/wp-content/uploads/5/Vertical-Line-PNG-File.png", //thunder image mattanam ithu match illa

                height: MediaQuery.of(context).size.height * 0.6666,
                fit: BoxFit.cover,
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height:
                      MediaQuery.of(context).size.height * 0.000000000000003,
                  child: Scaffold(
                    body: SafeArea(
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_left_rounded,color: Colors.white,size: 48,),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// "https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/mh-12-30-tanner-3-1-1609368496.png"
// "https://i0.wp.com/decider.com/wp-content/uploads/2019/04/tory-cobr                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              a-kai.jpg?quality=80&strip=all&ssl=1"
// "https://pngimg.com/uploads/thunder/thunder_PNG69.png"