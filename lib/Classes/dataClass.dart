import 'package:flutter/foundation.dart';

class Match {
  DateTime dateTime;
  String team1;
  String team2;
  String winner = "NILL";

  Match({this.team1, this.team2, this.dateTime, this.winner});
}

class Data extends ChangeNotifier {
  List<Match> matches;
}
