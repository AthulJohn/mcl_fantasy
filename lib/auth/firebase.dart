import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mcl_fantasy/Classes/dataClass.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class FireBaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //funtion to change the format of date to DATEDDMMYYYY
  // String dateFormat(DateTime dt) {
  //   String st = 'DATE';
  //   if (dt.day < 10) st += '0';
  //   st += dt.day.toString();
  //   if (dt.month < 10) st += '0';
  //   st += dt.month.toString();
  //   st += dt.year.toString();
  //   return st;
  // }

  void getTeams(context) async {}

//same logic for the next 2 functions...

  void vote(context, int no, String id) async {
    await firestore
        .collection('Fantasy Results')
        .doc(id)
        .collection(no == 1 ? 'Team 1' : 'Team 2')
        .add({
      'user': Provider.of<Data>(context).user.email,
      'time': DateTime.now().toString()
    });
  }
}
