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
  Future<void> getTeams(context) async {
    int vote = 0;
    QuerySnapshot quesnap =
        await FirebaseFirestore.instance.collection('Fantasy Results').get();
    DocumentSnapshot usersnap = await FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<Data>(context, listen: false).user.email)
        .get();
    for (QueryDocumentSnapshot snap in quesnap.docs) {
      if (usersnap.exists) if (usersnap.data().keys.contains(snap.id))
        vote = usersnap.data()[snap.id];
      else
        vote = 0;
      Provider.of<Data>(context, listen: false).add(
          snap.id,
          Match(
              team1: snap.data()['Team1'],
              team2: snap.data()['Team2'],
              dateTime: DateTime.tryParse(snap.data()['Date'].toString()),
              winner: snap.data()['Winner'],
              voted: vote));
    }
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Expanded(
      child: Scaffold(
        body: SafeArea(
          child: Expanded(
            child: Column(
              children: [
                Image.network(
                    "https://drive.google.com/uc?export=view&id=1pkRm-_6c_3JOTD0vWOXfSB_EI8ImccJY"),
                Card(
                  child: Column(
                    children: [
                      Text('Signin'),
                      TextField(),
                      TextField(),
                    ],
                  ),
                ),
                Image.network(
                    "https://drive.google.com/uc?export=view&id=1WSDax83g2k3PC_R3-XU_YriW1F2Ulos3"),
              ],
            ),
          ),
=======
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
                child: Column(
                  children: [
                    TextButton(
                      child: Text('Signin'),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>((_) {
                          return Colors.red;
                        }),
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                                (_) {
                          return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15));
                        }),
                      ),
                      onPressed: () async {
                        User u = await AuthService().signInWithGoogle(context);
                        if (!u.email.endsWith('mace.ac.in') &&
                            u.email != 'johnychackopulickal@gmail.com') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please use your mace email id.')));
                          AuthService().signOutGoogle(context);
                        } else {
                          Provider.of<Data>(context, listen: false)
                              .updateuser(u);
                          await getTeams(context);

                          if (u != null)
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return Home();
                            }));
                        }
                      },
                    ),
                    Text('Please sign in using your MACE mail id.'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Image.network(
                  "https://drive.google.com/uc?export=view&id=1WSDax83g2k3PC_R3-XU_YriW1F2Ulos3"),
            ),
          ],
>>>>>>> f8fb108374cbc33504b8e63e31f1cc78b2da7c60
        ),
      ),
    );
  }
}
