import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:provider/provider.dart';

class TeamDetails extends StatelessWidget {
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
        title: Text('Team Details',
            style: GoogleFonts.aBeeZee(
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(children: [
          for (String i in teams.keys)
            Container(
              height: 360,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('  ' + teams[i]['name'],
                        style: GoogleFonts.aBeeZee(
                          fontSize: 17,
                          color: Colors.black,
                        )),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: CachedNetworkImage(
                          imageUrl: teams[i]['intro'],
                          fit: BoxFit.contain,
                          httpHeaders: {
                            "Authorization":
                                "Bearer ${Provider.of<DataClass>(context).token}"
                          },
                        ),
                      ),
                    ),
                  ]),
            ),
        ]),
      ),
    );
  }
}
