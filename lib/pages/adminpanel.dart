import 'package:flutter/material.dart';
import 'package:mcl_fantasy/auth/firebase.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:mcl_fantasy/widgets/addDialog.dart';
import 'package:provider/provider.dart';

class AdminPanel extends StatefulWidget {
  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataClass>(
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
                  Text(data.matches[s].team1 + ' vs ' + data.matches[s].team2),
                  Text(
                      'Date: ${data.matches[s].dateTime.day}/${data.matches[s].dateTime.month}/${data.matches[s].dateTime.year}'),
                  Text('Winner: '),
                  // ListTile(
                  //   onTap: () {
                  //     data.updateWinner(s, 'NILL');
                  //     FireBaseService().updatewinner(s, 0);
                  //   },
                  //   title: Text('None'),
                  //   trailing: Radio(
                  //       value: 'NILL',
                  //       groupValue: data.matches[s].winner,
                  //       onChanged: (val) {}),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(children: [
                        Text(data.matches[s].team1),
                        Radio(
                            value: data.matches[s].team1,
                            groupValue: data.matches[s].winner,
                            onChanged: (val) {
                              data.updateWinner(s, data.matches[s].team1);
                              FireBaseService().updatewinner(s, 1);
                            }),
                      ]),
                      Row(children: [
                        Text(data.matches[s].team2),
                        Radio(
                            value: data.matches[s].team2,
                            groupValue: data.matches[s].winner,
                            onChanged: (val) {
                              data.updateWinner(s, data.matches[s].team2);
                              FireBaseService().updatewinner(s, 2);
                            })
                      ]),
                    ],
                  ),
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
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AddDialog();
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
