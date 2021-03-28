import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Match {
  DateTime dateTime;
  String team1;
  String team2;
  String winner = "NILL";
  int voted = 0;
  void vote(int vot) {
    voted = vot;
  }

  void winnerIs(String win) {
    winner = win;
  }

  Match({this.team1, this.team2, this.dateTime, this.winner, this.voted});
}

class DataClass extends ChangeNotifier {
  User user;
  Map<String, Match> matches = {};
  void add(String id, Match mat) {
    matches[id] = mat;
  }

  void updateuser(User fuser) {
    user = fuser;
    notifyListeners();
  }

  void updateWinner(String r, String s) {
    matches[r].winnerIs(s);
    notifyListeners();
  }

  void vote(int vot, String id) {
    matches[id].vote(vot);
    notifyListeners();
  }
}
