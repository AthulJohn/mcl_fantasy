import 'package:flutter/material.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:provider/provider.dart';

class LeaderBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LeaderBoard'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            for (int i = 0;
                i < Provider.of<DataClass>(context).leaderboard.length;
                i++)
              ListTile(
                tileColor:
                    Provider.of<DataClass>(context).leaderboard[i].mail ==
                            Provider.of<DataClass>(context).user.email
                        ? Colors.orange
                        : Colors.white,
                leading: Text('${i + 1}'),
                title:
                    Text(Provider.of<DataClass>(context).leaderboard[i].name),
                trailing: Text(
                    '${Provider.of<DataClass>(context).leaderboard[i].won}'),
              )
          ],
        ),
      ),
    );
  }
}
