import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcl_fantasy/classes/dataClass.dart';
import 'package:provider/provider.dart';

class MainMatchClass extends StatelessWidget {
  final String s;
  MainMatchClass(this.s);
  String dateFormat(DateTime dt) {
    List months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
  }

  String timeFormat(DateTime dt) {
    String ampm;
    int hr = dt.hour;
    if (dt.hour < 12) {
      ampm = 'AM';
    } else {
      hr = dt.hour - 12;
      ampm = 'PM';
    }
    if (hr == 0) hr = 12;
    String toreturn = '';
    if (hr < 10) toreturn += '0';
    toreturn += '$hr:';
    if (dt.minute < 9) toreturn += '0';
    toreturn += '${dt.minute} $ampm';
    return toreturn;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(colors: [
            teams[Provider.of<DataClass>(context).matches[s].team1]['color'],
            teams[Provider.of<DataClass>(context).matches[s].team2]['color']
          ])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://drive.google.com/uc?export=view&id=1pkRm-_6c_3JOTD0vWOXfSB_EI8ImccJY",
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  s,
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontSize: 37,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Group ' + Provider.of<DataClass>(context).matches[s].group,
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              // color: Colors.green,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: teams[Provider.of<DataClass>(context)
                                .matches[s]
                                .team1]['logo'],
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          '${teams[Provider.of<DataClass>(context).matches[s].team1]['name']}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.bebasNeue(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://comicvine1.cbsistatic.com/uploads/original/11141/111417311/7460362-versus-letters-vs-logo-vector-13673484.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CachedNetworkImage(
                            imageUrl: teams[Provider.of<DataClass>(context)
                                .matches[s]
                                .team2]['logo'],
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text(
                          '${teams[Provider.of<DataClass>(context).matches[s].team2]['name']}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.bebasNeue(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dateFormat(
                      Provider.of<DataClass>(context).matches[s].dateTime),
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  timeFormat(
                      Provider.of<DataClass>(context).matches[s].dateTime),
                  style: GoogleFonts.bebasNeue(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
