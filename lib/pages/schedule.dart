import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:provider/provider.dart';

class Schedule extends StatelessWidget {
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
        title: Text('MCL Schedule',
            style: GoogleFonts.aBeeZee(
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: schedule.length,
              itemBuilder: (context, ind) {
                return Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    teams[schedule[ind][0]]['color'],
                    Colors.white,
                    teams[schedule[ind][1]]['color']
                  ])),
                  height: 150,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'May ${(ind ~/ 2) + 1}',
                          style: GoogleFonts.bebasNeue(fontSize: 18),
                        ),
                        ind % 2 == 0
                            ? Text(
                                'Match ${ind + 1}   Group A',
                                style: GoogleFonts.bebasNeue(fontSize: 18),
                              )
                            : Text(
                                'Match ${ind + 1}   Group B',
                                style: GoogleFonts.bebasNeue(fontSize: 18),
                              ),
                        Row(
                          children: [
                            Expanded(
                              child: Image.network(
                                teams[schedule[ind][0]]['logo'],
                                fit: BoxFit.contain,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                teams[schedule[ind][0]]['name'],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bebasNeue(fontSize: 18),
                              ),
                            ),
                            Text('vs'),
                            Expanded(
                              flex: 2,
                              child: Text(
                                teams[schedule[ind][1]]['name'],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.bebasNeue(fontSize: 18),
                              ),
                            ),
                            Expanded(
                              child: Image.network(
                                teams[schedule[ind][1]]['logo'],
                                fit: BoxFit.contain,
                              ),
                            )
                          ],
                        ),
                        Divider()
                      ]),
                );
              })),
    );
  }
}
