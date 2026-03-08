import 'dart:math';

class Usermodel {
  final String uid;
  String username;
  String email;
  int profilepicture;
  int userXp;
  int leaderboardRank;
  int userlevel;
  int streak;

  // Quest IDs only
  List<String>? scannedWords;
  List<String>? languagesExplored;

  List<String>? completedQuests;
  List<String>? incompletedQuests;
  List<String>? activeQuests;

  Usermodel({
    required this.uid,
    required this.username,
    required this.email,
    this.profilepicture = 7,
    this.userXp = 0,
    int? userlevel,
    this.streak = 0,
    this.leaderboardRank = 0,
    this.scannedWords,
    this.completedQuests,
    this.incompletedQuests,
    this.activeQuests,
    this.languagesExplored,
  }) : userlevel = userlevel ?? _calculateLevel(userXp);

  static int _calculateLevel(int xp) {
    return (sqrt(xp / 1000)).floor();
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'profilepicture': profilepicture,
      'userXp': userXp,
      'userlevel': userlevel,
      'streak': streak,
      'leaderboardRank': leaderboardRank,
      'scannedWords': scannedWords,
      'languagesExplored': languagesExplored,

      // Store quest IDs
      'completedQuests': completedQuests,
      'incompletedQuests': incompletedQuests,
      'activeQuests': activeQuests,
    };
  }

  String toJsonString() => toMap().toString();

  factory Usermodel.fromMap(Map<String, dynamic> map) {
    return Usermodel(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
      profilepicture: map['profilepicture'] ?? 7,
      userXp: map['userXp'] ?? 0,
      userlevel: map['userlevel'],
      streak: map['streak'] ?? 0,
      leaderboardRank: map['leaderboardRank'] ?? 0,

      scannedWords: map['scannedWords'] != null
          ? List<String>.from(map['scannedWords'])
          : [],

      languagesExplored: map['languagesExplored'] != null
          ? List<String>.from(map['languagesExplored'])
          : [],

      // Read quest IDs
      completedQuests: map['completedQuests'] != null
          ? List<String>.from(map['completedQuests'])
          : [],

      incompletedQuests: map['incompletedQuests'] != null
          ? List<String>.from(map['incompletedQuests'])
          : [],

      activeQuests: map['activeQuests'] != null
          ? List<String>.from(map['activeQuests'])
          : [],
    );
  }
}
