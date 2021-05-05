import 'package:flutter/material.dart';
import 'package:mcl_fantasy/auth/firebase.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:mcl_fantasy/widgets/addDialog.dart';
import 'package:mcl_fantasy/widgets/loading.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Consumer<DataClass>(
            builder: (context, data, child) => ListView(
              children: [
                Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      'Admin Page',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 25,
                        fontFamily: "Monsterrat",
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                for (String s in data.matches.keys)
                  Card(
                    margin: EdgeInsets.all(10),
                    elevation: 5,
                    child: Column(
                      children: [
                        Text(s),
                        Text(data.matches[s].team1 +
                            ' vs ' +
                            data.matches[s].team2),
                        Text(
                            'Date: ${data.matches[s].dateTime.day}/${data.matches[s].dateTime.month}/${data.matches[s].dateTime.year}'),
                        Text('Winner: '),
                        data.matches[s].winner == 'NILL'
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(children: [
                                    Text(data.matches[s].team1),
                                    Radio(
                                        value: data.matches[s].team1,
                                        groupValue: data.matches[s].winner,
                                        onChanged: (val) async {
                                          bool connect = await connected();
                                          if (connect) {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text("Really?"),
                                                    content: Text(data
                                                            .matches[s].team1 +
                                                        " won and " +
                                                        data.matches[s].team2 +
                                                        " lost?"),
                                                    actions: [
                                                      TextButton(
                                                        child: Text('Nah..'),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text('Yeah..'),
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);

                                                          try {
                                                            data.updateWinner(
                                                                s,
                                                                data.matches[s]
                                                                    .team1);
                                                            await FireBaseService()
                                                                .updatewinner(
                                                                    s,
                                                                    1,
                                                                    data
                                                                        .matches[
                                                                            s]
                                                                        .dateTime);
                                                            List<String> ids =
                                                                await FireBaseService()
                                                                    .getPlayerID();
                                                            OneSignal.shared.postNotification(
                                                                OSCreateNotification(
                                                                    playerIds:
                                                                        ids,
                                                                    content:
                                                                        'The result of Match between ${teams[data.matches[s].team1]['name']} and ${teams[data.matches[s].team2]['name']} has been updated! Check whether your prediction stands...',
                                                                    heading:
                                                                        'Match Result Updated!'));
                                                          } catch (e) {
                                                            setState(() {
                                                              loading = false;
                                                            });
                                                            print(e);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        content:
                                                                            Text('Oops! Error submiting winner!')));
                                                          }
                                                          setState(() {
                                                            loading = false;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Oops, Could not connect to a network!')));
                                          }
                                        }),
                                  ]),
                                  Row(children: [
                                    Text(data.matches[s].team2),
                                    Radio(
                                        value: data.matches[s].team2,
                                        groupValue: data.matches[s].winner,
                                        onChanged: (val) async {
                                          bool alertloading = false;

                                          bool connect = await connected();
                                          if (connect) {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text("Really?"),
                                                    content: Text(data
                                                            .matches[s].team2 +
                                                        " won and " +
                                                        data.matches[s].team1 +
                                                        " lost?"),
                                                    actions: [
                                                      TextButton(
                                                        child: Text('Nah..'),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text('Yeah..'),
                                                        onPressed: () async {
                                                          setState(() {
                                                            alertloading = true;
                                                          });
                                                          try {
                                                            data.updateWinner(
                                                                s,
                                                                data.matches[s]
                                                                    .team2);
                                                            await FireBaseService()
                                                                .updatewinner(
                                                                    s,
                                                                    2,
                                                                    data
                                                                        .matches[
                                                                            s]
                                                                        .dateTime);
                                                            List<String> ids =
                                                                await FireBaseService()
                                                                    .getPlayerID();
                                                            OneSignal.shared.postNotification(
                                                                OSCreateNotification(
                                                                    playerIds:
                                                                        ids,
                                                                    content:
                                                                        'The result of Match between ${teams[data.matches[s].team1]['name']} and ${teams[data.matches[s].team2]['name']} has been updated! Check whether your prediction stands...',
                                                                    heading:
                                                                        'Match Result Updated!'));
                                                          } catch (e) {
                                                            setState(() {
                                                              alertloading =
                                                                  false;
                                                            });
                                                            print(e);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        content:
                                                                            Text('Oops! Error submiting winner!')));
                                                          }
                                                          setState(() {
                                                            alertloading =
                                                                false;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Oops, Could not connect to a network!')));
                                          }
                                        })
                                  ]),
                                  Row(children: [
                                    Text("Draw"),
                                    Radio(
                                        value: data.matches[s].team2,
                                        groupValue: data.matches[s].winner,
                                        onChanged: (val) async {
                                          bool alertloading = false;

                                          bool connect = await connected();
                                          if (connect) {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text("Really?"),
                                                    content: Text(
                                                        "The match is draw?.."),
                                                    actions: [
                                                      TextButton(
                                                        child: Text('Nah..'),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text('Yeah..'),
                                                        onPressed: () async {
                                                          setState(() {
                                                            alertloading = true;
                                                          });
                                                          try {
                                                            data.updateWinner(
                                                                s, "DRAW");
                                                            await FireBaseService()
                                                                .updatewinner(
                                                                    s,
                                                                    3,
                                                                    data
                                                                        .matches[
                                                                            s]
                                                                        .dateTime);
                                                            List<String> ids =
                                                                await FireBaseService()
                                                                    .getPlayerID();
                                                            OneSignal.shared
                                                                .postNotification(
                                                                    OSCreateNotification(
                                                              playerIds: ids,
                                                              content:
                                                                  'The result of Match between ${teams[data.matches[s].team1]['name']} and ${teams[data.matches[s].team2]['name']} has been updated! Check whether your prediction stands...',
                                                              heading:
                                                                  'Match Result Updated!',
                                                            ));
                                                          } catch (e) {
                                                            setState(() {
                                                              alertloading =
                                                                  false;
                                                            });
                                                            print(e);
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        content:
                                                                            Text('Oops! Error submiting winner!')));
                                                          }
                                                          setState(() {
                                                            alertloading =
                                                                false;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                });
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Oops, Could not connect to a network!')));
                                          }
                                        })
                                  ]),
                                ],
                              )
                            : Text(data.matches[s].winner),
                      ],
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      size: 40,
                    ),
                    onPressed: () async {
                      bool connect = await connected();
                      if (connect) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AddDialog();
                            });
                      } else {
                        setState(() {
                          loading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text('Oops, Could not connect to a network!')));
                      }
                    },
                  ),
                )
              ],
            ),
          );
  }
}
