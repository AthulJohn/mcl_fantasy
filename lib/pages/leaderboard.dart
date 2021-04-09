import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:provider/provider.dart';

class LeaderBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('LeaderBoard',
            style: GoogleFonts.aBeeZee(
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Pos', style: GoogleFonts.aBeeZee()),
                  Text('    Name', style: GoogleFonts.aBeeZee()),
                  Text('Points', style: GoogleFonts.aBeeZee()),
                ],
              ),
            ),
            Expanded(
              child: ListView(
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
                      leading: Text('${i + 1}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.aBeeZee()),
                      title: Row(
                        children: [
                          CircleAvatar(
                            child: Image.network(Provider.of<DataClass>(context)
                                .leaderboard[i]
                                .image),
                          ),
                          Text(
                              '  ' +
                                  Provider.of<DataClass>(context)
                                      .leaderboard[i]
                                      .name,
                              style: GoogleFonts.aBeeZee()),
                        ],
                      ),
                      trailing: Text(
                          '${Provider.of<DataClass>(context).leaderboard[i].won}',
                          style: GoogleFonts.aBeeZee()),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
