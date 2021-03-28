import 'package:flutter/material.dart';
import 'package:mcl_fantasy/auth/firebase.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:provider/provider.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataClass>(
        builder: (context, data, child) => Container(
              height: 400,
              child: ListView(
                children: [
                  for (String s in data.matches.keys)
                    Card(
                      child: Column(
                        children: [
                          Text(data.matches[s].team1 +
                              ' vs ' +
                              data.matches[s].team2),
                          Text(
                              '${data.matches[s].dateTime.day}/${data.matches[s].dateTime.month}'),
                          Text('Winner: '),
                          ListTile(
                            onTap: () {
                              data.updateWinner(s, 'NILL');
                              FireBaseService().updatewinner(s, 0);
                            },
                            title: Text('None'),
                            trailing: Radio(
                                value: 'NILL',
                                groupValue: data.matches[s].winner,
                                onChanged: (val) {}),
                          ),
                          ListTile(
                            onTap: () {
                              data.updateWinner(s, data.matches[s].team1);
                              FireBaseService().updatewinner(s, 1);
                            },
                            title: Text(data.matches[s].team1),
                            trailing: Radio(
                                value: data.matches[s].team1,
                                groupValue: data.matches[s].winner,
                                onChanged: (val) {}),
                          ),
                          ListTile(
                              onTap: () {
                                data.updateWinner(s, data.matches[s].team2);
                                FireBaseService().updatewinner(s, 2);
                              },
                              title: Text(data.matches[s].team2),
                              trailing: Radio(
                                  value: data.matches[s].team2,
                                  groupValue: data.matches[s].winner,
                                  onChanged: (val) {})),
                        ],
                      ),
                    )
                ],
              ),
            ));
  }
}
