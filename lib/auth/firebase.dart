import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class FireBaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getTeams(context) async {
    String vote = 'NILL';
    QuerySnapshot quesnap;
    DocumentSnapshot usersnap;
    try {
      quesnap =
          await FirebaseFirestore.instance.collection('Fantasy Results').get();

      usersnap = await FirebaseFirestore.instance
          .collection('Users')
          .doc(Provider.of<DataClass>(context, listen: false).user.email)
          .get();
    } catch (e) {
      return;
    }
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
                  : snap.data()['Winner'] == 3
                      ? 'DRAW'
                      : snap.data()['Winner'] == 1
                          ? snap.data()['Team1']
                          : snap.data()['Team2'],
              voted: vote,
              group: snap.data()['Group']));
    }
    if (usersnap.exists) {
      Provider.of<DataClass>(context, listen: false).updateuserstat(UserStat(
          name: usersnap.data()['name'] ??
              Provider.of<DataClass>(context, listen: false).getUserName(),
          mail: usersnap.id,
          total: usersnap.data()['total'] ?? 0,
          won: usersnap.data()['won'] ?? 0,
          lost: usersnap.data()['lost'] ?? 0,
          min: usersnap.data()['time'] ?? 0,
          image: usersnap.data()['image'] ??
              'https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png'));
    } else {
      Provider.of<DataClass>(context, listen: false).updateuserstat(UserStat(
          name: Provider.of<DataClass>(context, listen: false).getUserName(),
          mail: Provider.of<DataClass>(context, listen: false).user.email,
          total: 0,
          won: 0,
          lost: 0,
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
          .update({id: team, 'total': snap.data()['total'] + 1});
    } else
      await firestore
          .collection('Users')
          .doc(Provider.of<DataClass>(context, listen: false).user.email)
          .set({
        'won': 0,
        'lost': 0,
        'total': 1,
        'time': 0,
        id: team,
        'name': Provider.of<DataClass>(context, listen: false).getUserName(),
        'image': Provider.of<DataClass>(context, listen: false).user.photoURL
      });
    Provider.of<DataClass>(context, listen: false).userstat.incrementTotal();
    Provider.of<DataClass>(context, listen: false).vote(team, id);
  }

  void addPlayerID(String mail) async {
    OSPermissionSubscriptionState osState =
        await OneSignal.shared.getPermissionSubscriptionState();
    String id = osState.subscriptionStatus.userId;
    String keyis = mail.split('@')[0];
    DocumentSnapshot snap =
        await firestore.collection('Users').doc('PlayerIds').get();
    if (id != null) {
      if (snap.exists)
        firestore.collection('Users').doc('PlayerIds').update({keyis: id});
      else
        firestore.collection('Users').doc('PlayerIds').set({keyis: id});
    }
  }

  Future<List> getPlayerID() async {
    DocumentSnapshot snap =
        await firestore.collection('Users').doc('PlayerIds').get();
    return List<String>.from(snap.data().values);
  }

  Future<void> updatewinner(String s, int val, DateTime dt) async {
    DateTime date = DateTime(dt.year, dt.month, dt.day, 6);
    await firestore
        .collection('Fantasy Results')
        .doc(s)
        .update({'Winner': val});
    QuerySnapshot qs;
    if (val != 3) {
      qs = await firestore
          .collection('Fantasy Results')
          .doc(s)
          .collection(val == 1 ? 'Team 1' : 'Team 2')
          .get();

      for (QueryDocumentSnapshot qds in qs.docs) {
        DocumentSnapshot ds =
            await firestore.collection('Users').doc(qds.id).get();
        if (ds.exists) {
          int mins =
              -DateTime.tryParse(qds.data()['time']).difference(date).inMinutes;
          await firestore.collection('Users').doc(qds.id).update({
            'won': ds.data()['won'] + 1,
            'time': (ds.data()['time'] ?? 0) + mins
          });
        }
      }
      qs = await firestore
          .collection('Fantasy Results')
          .doc(s)
          .collection(val == 2 ? 'Team 1' : 'Team 2')
          .get();
      for (QueryDocumentSnapshot qds in qs.docs) {
        DocumentSnapshot ds =
            await firestore.collection('Users').doc(qds.id).get();
        if (ds.exists) {
          await firestore
              .collection('Users')
              .doc(qds.id)
              .update({'lost': ds.data()['lost'] + 1});
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
      'Group': mat.group
    });
  }

  Future<void> findLeaderBoard(context) async {
    Provider.of<DataClass>(context, listen: false).resetLeader();
    QuerySnapshot qs = await firestore.collection('Users').get();
    for (QueryDocumentSnapshot qds in qs.docs) {
      if (qds.id != 'PlayerIds')
        Provider.of<DataClass>(context, listen: false).addLeader(UserStat(
            mail: qds.id,
            total: qds.data()['total'] ?? 0,
            won: qds.data()['won'] ?? 0,
            lost: qds.data()['lost'] ?? 0,
            min: qds.data()['time'] ?? 0,
            name: qds.data()['name'] ?? '',
            image: qds.data()['image'] ??
                'https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png'));
    }

    Provider.of<DataClass>(context, listen: false).sortLeaderBoard();
  }
}
