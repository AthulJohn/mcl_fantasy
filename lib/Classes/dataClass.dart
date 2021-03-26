import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Match {
  DateTime dateTime;
  String team1;
  String team2;
  String winner = "NILL";

  Match({this.team1, this.team2, this.dateTime, this.winner});
}

class Data extends ChangeNotifier {
  User user;
  Map<String, Match> matches = {};
  void add(String id, Match mat) {
    matches[id] = mat;
  }

  void updateuser(User fuser) {
    user = fuser;
  }
}
