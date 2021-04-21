import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mcl_fantasy/auth/firebase.dart';
import 'package:mcl_fantasy/auth/sign.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:mcl_fantasy/pages/home.dart';
import 'package:provider/provider.dart';

class Starting extends StatelessWidget {
  void initialise(context) async {
    int page = 0;
    if (AuthService().isnotSignedIn()) {
      User u = await AuthService().signInWithGoogle();
      if (u == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Error signing in! Make sure you are using your mace mail ID.')));
        return;
      }
      try {
        Provider.of<DataClass>(context, listen: false).updateuser(u);
        await FireBaseService().getTeams(context);
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Oops, Error getting data from Cloud!')));
        return;
      }
    }
    Map mats = Provider.of<DataClass>(context, listen: false).matches;
    for (String s in mats.keys)
      if (mats[s].dateTime.isAfter(DateTime.now())) {
        page = mats.keys.toList().indexOf(s);
        break;
      }
    Provider.of<DataClass>(context, listen: false).updateloader();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home(page)));
  }

  @override
  Widget build(BuildContext context) {
    initialise(context);
    return Scaffold(
        body: Column(
      children: [
        Expanded(child: Container()),
        Expanded(
            flex: 2,
            child: Image.asset(
              'assets/mcl.png',
              fit: BoxFit.contain,
            )),
        Expanded(
          child: SpinKitChasingDots(
            color: Colors.black,
          ),
        ),
        Expanded(child: Container()),
      ],
    ));
  }
}
