import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Match {
  DateTime dateTime;
  String team1;
  String team2;
  String winner = "NILL";
  String voted = "NILL";
  void vote(String vot) {
    voted = vot;
  }

  void winnerIs(String win) {
    winner = win;
  }

  Match(
      {this.team1,
      this.team2,
      this.dateTime,
      this.winner = 'NILL',
      this.voted = 'NILL'});
}

class UserStat {
  String mail, name, image;
  int won, lost;
  int min;

  UserStat({this.mail, this.min, this.won, this.name, this.image, this.lost});
}

class DataClass extends ChangeNotifier {
  User user;
  Map<String, Match> matches = {};
  UserStat userstat;
  List<UserStat> leaderboard = [];

  void add(String id, Match mat) {
    matches[id] = mat;
  }

  void notify() {
    notifyListeners();
  }

  void updateuserstat(UserStat userst) {
    userstat = userst;
    notifyListeners();
  }

  void updateuser(User fuser) {
    user = fuser;
    notifyListeners();
  }

  void updateWinner(String r, String s) {
    matches[r].winnerIs(s);
    notifyListeners();
  }

  void vote(String vot, String id) {
    matches[id].vote(vot);
    notifyListeners();
  }

  void resetLeader() {
    leaderboard = [];
  }

  void addLeader(UserStat userStat) {
    leaderboard.add(userStat);
  }

  void sortLeaderBoard() {
    leaderboard.sort((a, b) {
      if (a.won == b.won)
        return a.min.compareTo(b.min);
      else
        return b.won.compareTo(a.won);
    });
  }
}

Map teams = {
  'IDK': {
    'name': 'Idukki Gladiators',
    'logo':
        'https://drive.google.com/uc?export=view&id=1vEVVbNKwI4jDP5GDchmpG8cmbuEmDjFL',
    'color': Color.fromRGBO(55, 55, 55, 1)
  },
  'ALP': {
    'name': 'Decoders Alleyppey',
    'logo':
        'https://drive.google.com/uc?export=view&id=12dZyT3gki2jfB5LxVgBV8yuw-MbVfAUf',
    'color': Color.fromRGBO(1, 122, 141, 1)
  },
  'TRV': {
    'name': 'Trivandrum Dragons',
    'logo':
        'https://drive.google.com/uc?export=view&id=1aZevJZjA6Vpf4sFc6xXH9URuDFsMmvp9',
    'color': Color.fromRGBO(150, 44, 54, 1)
  },
  'CLT': {
    'name': 'Calicut Cavaliers',
    'logo':
        'https://drive.google.com/uc?export=view&id=151702foS4xkfYkq_vpOrgsW4HpQy6Z-6',
    'color': Color.fromRGBO(30, 27, 22, 1)
  },
  'KNR': {
    'name': 'Kannur Knights',
    'logo':
        'https://drive.google.com/uc?export=view&id=17nFt6XpWFASghEVB_fIhL23QpGjydUMN',
    'color': Color.fromRGBO(170, 15, 21, 1)
  },
  'PLK': {
    'name': 'Palakkad Warriors',
    'logo':
        'https://drive.google.com/uc?export=view&id=1Onjac15ODg6LyE1WqB5j7QphuR6Cp98Y',
    'color': Color.fromRGBO(114, 3, 10, 1)
  },
  'EKM': {
    'name': 'King Coders EKM',
    'logo':
        'https://drive.google.com/uc?export=view&id=1AvzP18MMlurhZ0SapPUu1D37rhRnT1CL',
    'color': Color.fromRGBO(66, 96, 160, 1)
  },
  'KZD': {
    'name': 'Kasargod DigitHeads',
    'logo':
        'https://drive.google.com/uc?export=view&id=1EmUBlAm5oeWDc18PlP1WkQpCU2Qr4fQK',
    'color': Color.fromRGBO(55, 123, 136, 1)
  },
  'KTM': {
    'name': 'Kottayam Koders',
    'logo':
        'https://drive.google.com/uc?export=view&id=1xfEU6jawFRCuHWYEtkWSSmKdiLiFBvEA',
    'color': Color.fromRGBO(204, 167, 21, 1)
  },
  'KLM': {
    'name': 'Cyber Falcons Kollam',
    'logo':
        'https://drive.google.com/uc?export=view&id=1B10MJNjv6oh2C8puibb-onCZPbq_ePWy',
    'color': Color.fromRGBO(169, 60, 4, 1)
  },
  'MLP': {
    'name': 'Malappuram Mavericks',
    'logo':
        'https://drive.google.com/uc?export=view&id=1sgWYNNHjvLsdC6og-A71f0STfAup1hjl',
    'color': Color.fromRGBO(33, 62, 102, 1)
  },
  'PTM': {
    'name': 'Royal Pythons Pathanamthitta',
    'logo':
        'https://drive.google.com/uc?export=view&id=1BuNbli8rJ3u46wc03zUZo6CNHUYbGiXC',
    'color': Color.fromRGBO(96, 15, 135, 1)
  },
  'TRS': {
    'name': 'Thrissur Raptors',
    'logo':
        'https://drive.google.com/uc?export=view&id=1vsL-A2-64QYMj49qzxWfDQDwAfDQmMKL',
    'color': Color.fromRGBO(29, 40, 102, 1)
  },
  'WYD': {
    'name': 'Wayanad Blackhats',
    'logo':
        'https://drive.google.com/uc?export=view&id=1C9K-GILQ7Bk3-fiOqy40gku7nRZO45uS',
    'color': Color.fromRGBO(1, 0, 2, 1)
  },
};
