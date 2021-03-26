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
  void getTeams(context) async {
    QuerySnapshot quesnap =
        await FirebaseFirestore.instance.collection('Fantasy Results').get();
    for (QueryDocumentSnapshot snap in quesnap.docs) {
      Provider.of<Data>(context, listen: false).add(
          snap.id,
          Match(
              team1: snap.data()['Team1'],
              team2: snap.data()['Team2'],
              dateTime: DateTime.tryParse(snap.data()['Date'].toString()),
              winner: snap.data()['Winner']));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        getTeams(context);
                        User u = await AuthService().signInWithGoogle(context);
                        if (!u.email.endsWith('mace.ac.in') &&
                            u.email != 'johnychackopulickal@gmail.com') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Please use your mace email id.')));
                          AuthService().signOutGoogle(context);
                        } else {
                          Provider.of<Data>(context, listen: false)
                              .updateuser(u);
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
        ),
      ),
    );
  }
}
