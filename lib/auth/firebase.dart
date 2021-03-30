import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
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

  Future<void> getTeams(context) async {
    int vote = 0;
    QuerySnapshot quesnap =
        await FirebaseFirestore.instance.collection('Fantasy Results').get();
    DocumentSnapshot usersnap = await FirebaseFirestore.instance
        .collection('Users')
        .doc(Provider.of<DataClass>(context, listen: false).user.email)
        .get();
    for (QueryDocumentSnapshot snap in quesnap.docs) {
      if (usersnap.exists) if (usersnap.data().keys.contains(snap.id))
        vote = usersnap.data()[snap.id];
      else
        vote = 0;
      Provider.of<DataClass>(context, listen: false).add(
          snap.id,
          Match(
              team1: snap.data()['Team1'],
              team2: snap.data()['Team2'],
              dateTime: DateTime.tryParse(snap.data()['Date'].toString()) ??
                  DateTime.now(),
              winner: snap.data()['Winner'] == 0
                  ? 'NILL'
                  : snap.data()['Winner'] == 1
                      ? snap.data()['Team1']
                      : snap.data()['Team2'],
              voted: vote));
    }
  }

  Future<void> vote(context, int no, String id) async {
    await firestore
        .collection('Fantasy Results')
        .doc(id)
        .collection(no == 1 ? 'Team 1' : 'Team 2')
        .doc(Provider.of<DataClass>(context, listen: false).user.email)
        .set({
      'user': Provider.of<DataClass>(context, listen: false).user.email,
      'time': DateTime.now().toString()
    });
    DocumentSnapshot dsnap = await firestore
        .collection('Fantasy Results')
        .doc(id)
        .collection(no == 1 ? 'Team 2' : 'Team 1')
        .doc(Provider.of<DataClass>(context, listen: false).user.email)
        .get();
    if (dsnap.exists)
      await firestore
          .collection('Fantasy Results')
          .doc(id)
          .collection(no == 1 ? 'Team 2' : 'Team 1')
          .doc(Provider.of<DataClass>(context, listen: false).user.email)
          .delete();
    DocumentSnapshot snap = await firestore
        .collection('Users')
        .doc(Provider.of<DataClass>(context, listen: false).user.email)
        .get();
    if (snap.exists) {
      await firestore
          .collection('Users')
          .doc(Provider.of<DataClass>(context, listen: false).user.email)
          .update({id: no});
    } else
      await firestore
          .collection('Users')
          .doc(Provider.of<DataClass>(context, listen: false).user.email)
          .set({'won': 0, 'lost': 0, id: no});

    Provider.of<DataClass>(context, listen: false).vote(no, id);
  }

  void updatewinner(String s, int val) async {
    await firestore
        .collection('Fantasy Results')
        .doc(s)
        .update({'Winner': val});
  }

  Future<void> addmatch(String key, Match mat) async {
    await firestore.collection('Fantasy Results').doc(key).set({
      'Team1': mat.team1,
      'Team2': mat.team2,
      'Winner': 0,
      'Date': mat.dateTime.toIso8601String(),
    });
  }
}
