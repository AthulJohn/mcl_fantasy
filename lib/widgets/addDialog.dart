import 'package:flutter/material.dart';
import 'package:mcl_fantasy/auth/firebase.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

class AddDialog extends StatefulWidget {
  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  int newnumber = 0;
  String team1 = 'IDK', team2 = 'ALP', tt = 'PM', group = 'A';
  DateTime dat = DateTime(2021, 4, 15), temp;
  int th = 1, tm = 0;

  int convert() {
    if (tt == 'AM' && th == 12) return 0;
    if (tt == 'PM' && th == 12) return 12;
    if (tt == 'PM') return 12 + th;
    if (tt == 'AM') return th;
    return th;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text('New Match'),
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  textAlign: TextAlign.center,
                  maxLength: 3,
                  decoration: InputDecoration(
                      hintText: 'Match Number',
                      border:
                          OutlineInputBorder(borderSide: BorderSide(width: 2))),
                  keyboardType: TextInputType.number,
                  onChanged: (val) {
                    newnumber = int.tryParse(val);
                  },
                ),
              ),
            ),
            Expanded(
              child: DropdownButton(
                value: group,
                items: [
                  DropdownMenuItem(
                    child: Text('Group A'),
                    value: 'A',
                  ),
                  DropdownMenuItem(
                    child: Text('Group B'),
                    value: 'B',
                  )
                ],
                onChanged: (val) {
                  setState(() {
                    group = val;
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DropdownButton(
              value: team1,
              items: [
                for (String s in teams.keys)
                  DropdownMenuItem(
                    child: Text(s),
                    value: s,
                  )
              ],
              onChanged: (val) {
                setState(() {
                  team1 = val;
                });
              },
            ),
            Text('v/s'),
            DropdownButton(
              value: team2,
              items: [
                for (String s in teams.keys)
                  DropdownMenuItem(
                    child: Text(s),
                    value: s,
                  )
              ],
              onChanged: (val) {
                setState(() {
                  team2 = val;
                });
              },
            )
          ],
        ),
        TextButton(
            onPressed: () async {
              temp = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2021, 4, 15),
                  firstDate: DateTime(2021, 3, 30),
                  lastDate: DateTime(2021, 8, 30));
              if (temp != null) {
                setState(() {
                  dat = temp;
                });
              }
            },
            child: Row(
              children: [
                Icon(Icons.calendar_today_rounded),
                Text('${dat.day}/${dat.month}/${dat.year}')
              ],
            )),
        // CalendarDatePicker(
        //     initialDate: DateTime(2021, 4, 15),
        //     firstDate: DateTime(2021, 3, 30),
        //     lastDate: DateTime(2021, 8, 30),
        //     onDateChanged: (val) {
        //       dat = val;
        //     }),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.access_time),
            DropdownButton(
              value: th,
              items: [
                for (int i in List.generate(12, (ind) => ind + 1))
                  DropdownMenuItem(
                    child: Text('$i'),
                    value: i,
                  )
              ],
              onChanged: (val) {
                setState(() {
                  th = val;
                });
              },
            ),
            DropdownButton(
              value: tm,
              items: [
                for (int i in List.generate(12, (ind) => ind * 5))
                  DropdownMenuItem(
                    child: Text('$i'),
                    value: i,
                  )
              ],
              onChanged: (val) {
                setState(() {
                  tm = val;
                });
              },
            ),
            DropdownButton(
              value: tt,
              items: [
                for (String i in ['AM', 'PM'])
                  DropdownMenuItem(
                    child: Text(i),
                    value: i,
                  )
              ],
              onChanged: (val) {
                setState(() {
                  tt = val;
                });
              },
            )
          ],
        ),
        TextButton(
          child: Text('Submit'),
          onPressed: () async {
            dat = dat.add(Duration(hours: convert(), minutes: tm));
            Provider.of<DataClass>(context, listen: false).add(
                'Match $newnumber',
                Match(team1: team1, team2: team2, dateTime: dat, group: group));
            Provider.of<DataClass>(context, listen: false).notify();
            await FireBaseService().addmatch('Match $newnumber',
                Match(team1: team1, team2: team2, dateTime: dat, group: group));
            List<String> ids = await FireBaseService().getPlayerID();
            OneSignal.shared.postNotification(OSCreateNotification(
              playerIds: ids,
              content: 'A new match has been Scheduled! Check it out.',
              heading: 'Next Match Scheduled',
            ));
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
