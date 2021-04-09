import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class FireBaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getTeams(context) async {
    String vote = 'NILL';
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
        vote = 'NILL';
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
    if (usersnap.exists) {
      Provider.of<DataClass>(context, listen: false).updateuserstat(UserStat(
          name: usersnap.data()['name'] ??
              Provider.of<DataClass>(context, listen: false).user.displayName,
          mail: usersnap.id,
          won: usersnap.data()['won'] ?? 0,
          min: usersnap.data()['time'] ?? 0,
          image: usersnap.data()['image'] ??
              'https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png'));
    } else {
      Provider.of<DataClass>(context, listen: false).updateuserstat(UserStat(
          name: Provider.of<DataClass>(context, listen: false).user.displayName,
          mail: Provider.of<DataClass>(context, listen: false).user.email,
          won: 0,
          min: 0,
          image:
              'https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png'));
    }
  }

  Future<void> vote(context, int no, String team, String id) async {
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
          .update({id: team});
    } else
      await firestore
          .collection('Users')
          .doc(Provider.of<DataClass>(context, listen: false).user.email)
          .set({
        'won': 0,
        'lost': 0,
        id: team,
        'name': Provider.of<DataClass>(context, listen: false).user.displayName,
        'image': Provider.of<DataClass>(context, listen: false).user.photoURL
      });

    Provider.of<DataClass>(context, listen: false).vote(team, id);
  }

  void updatewinner(String s, int val) async {
    await firestore
        .collection('Fantasy Results')
        .doc(s)
        .update({'Winner': val});
    if (val != 0) {
      QuerySnapshot qs = await firestore
          .collection('Fantasy Results')
          .doc(s)
          .collection(val == 1 ? 'Team 1' : 'Team 2')
          .get();
      for (QueryDocumentSnapshot qds in qs.docs) {
        DocumentSnapshot ds =
            await firestore.collection('Users').doc(qds.id).get();
        if (ds.exists) {
          int mins = DateTime.tryParse(qds.data()['time'])
              .difference(DateTime(2021, 4))
              .inMinutes;
          await firestore.collection('Users').doc(qds.id).update(
              {'won': ds.data()['won'] + 1, 'time': ds.data()['time'] + mins});
        }
      }
    }
  }

  Future<void> addmatch(String key, Match mat) async {
    await firestore.collection('Fantasy Results').doc(key).set({
      'Team1': mat.team1,
      'Team2': mat.team2,
      'Winner': 0,
      'Date': mat.dateTime.toIso8601String(),
    });
  }

  Future<void> findLeaderBoard(context) async {
    Provider.of<DataClass>(context, listen: false).resetLeader();
    QuerySnapshot qs = await firestore.collection('Users').get();
    for (QueryDocumentSnapshot qds in qs.docs) {
      Provider.of<DataClass>(context, listen: false).addLeader(UserStat(
          mail: qds.id,
          won: qds.data()['won'] ?? 0,
          min: qds.data()['time'] ?? 0,
          name: qds.data()['name'],
          image: qds.data()['image'] ??
              'https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png'));
    }

    Provider.of<DataClass>(context, listen: false).sortLeaderBoard();
  }
}
