import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mcl_fantasy/auth/firebase.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
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
                            Image.network(
                                "https://drive.google.com/uc?export=view&id=1pkRm-_6c_3JOTD0vWOXfSB_EI8ImccJY"),
                            Card(
                              child: Column(
                                children: [
                                  Text(
                                      '${Provider.of<Data>(context).matches[s].team1} vs ${Provider.of<Data>(context).matches[s].team2}'),
                                  Text(
                                      'Voted ${Provider.of<Data>(context).matches[s].voted}'),
                                  Row(
                                    children: [
                                      TextButton(
                                        child: Text('Team 1'),
                                        onPressed: () {
                                          vote(context, 1, s);
                                        },
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            vote(context, 2, s);
                                          },
                                          child: Text('Team 2'))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Image.network(
                                "https://drive.google.com/uc?export=view&id=1WSDax83g2k3PC_R3-XU_YriW1F2Ulos3"),
                          ],
                        )
                    ],
                  ),
      ),
    );
  }
}
