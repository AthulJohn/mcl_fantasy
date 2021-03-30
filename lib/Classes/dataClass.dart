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

  Match(
      {this.team1,
      this.team2,
      this.dateTime,
      this.winner = 'NILL',
      this.voted = 0});
}

class DataClass extends ChangeNotifier {
  User user;
  Map<String, Match> matches = {};
  void add(String id, Match mat) {
    matches[id] = mat;
  }

  void notify() {
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

  void vote(int vot, String id) {
    matches[id].vote(vot);
    notifyListeners();
  }
}

Map teams = {
  'IDK': {
    'name': 'Idukki Gladiators',
    'logo':
        'https://drive.google.com/uc?export=view&id=1vEVVbNKwI4jDP5GDchmpG8cmbuEmDjFL'
  },
  'ALP': {
    'name': 'Decoders Alleyppey',
    'logo':
        'https://drive.google.com/uc?export=view&id=12dZyT3gki2jfB5LxVgBV8yuw-MbVfAUf'
  },
  'TRV': {
    'name': 'Trivandrum Dragons',
    'logo':
        'https://drive.google.com/uc?export=view&id=1aZevJZjA6Vpf4sFc6xXH9URuDFsMmvp9'
  },
  'CLT': {
    'name': 'Calicut Cavaliers',
    'logo':
        'https://drive.google.com/uc?export=view&id=19qduGu1PuHoAKvi1L7jRYWSItJtjpnZc'
  },
  'KNR': {
    'name': 'Kannur Knights',
    'logo':
        'https://drive.google.com/uc?export=view&id=17nFt6XpWFASghEVB_fIhL23QpGjydUMN'
  },
  'PLK': {
    'name': 'Palakkad Warriors',
    'logo':
        'https://drive.google.com/uc?export=view&id=1Onjac15ODg6LyE1WqB5j7QphuR6Cp98Y'
  },
  'EKM': {
    'name': 'King Coders EKM',
    'logo':
        'https://drive.google.com/uc?export=view&id=1AvzP18MMlurhZ0SapPUu1D37rhRnT1CL'
  },
  'KZD': {
    'name': 'Kasargod DigitHeads',
    'logo':
        'https://drive.google.com/uc?export=view&id=1EmUBlAm5oeWDc18PlP1WkQpCU2Qr4fQK'
  },
  'KTM': {
    'name': 'Kottayam Koders',
    'logo':
        'https://drive.google.com/uc?export=view&id=1xfEU6jawFRCuHWYEtkWSSmKdiLiFBvEA'
  },
  'KLM': {
    'name': 'Cyber Falcons Kollam',
    'logo':
        'https://drive.google.com/uc?export=view&id=1B10MJNjv6oh2C8puibb-onCZPbq_ePWy'
  },
  'MLP': {
    'name': 'Malappuram Mavericks',
    'logo':
        'https://drive.google.com/uc?export=view&id=1sgWYNNHjvLsdC6og-A71f0STfAup1hjl'
  },
  'PTM': {
    'name': 'Royal Pythons Pathanamthitta',
    'logo':
        'https://drive.google.com/uc?export=view&id=1BuNbli8rJ3u46wc03zUZo6CNHUYbGiXC'
  },
  'TRS': {
    'name': 'Thrissur Raptors',
    'logo':
        'https://drive.google.com/uc?export=view&id=1vsL-A2-64QYMj49qzxWfDQDwAfDQmMKL'
  },
  'WYD': {
    'name': 'Wayanad Blackhats',
    'logo':
        'https://drive.google.com/uc?export=view&id=1C9K-GILQ7Bk3-fiOqy40gku7nRZO45uS'
  },
};
