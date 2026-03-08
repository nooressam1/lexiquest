import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lexiquest/Features/Quest/Domain/queststatus.dart';
import 'package:lexiquest/Features/Quest/Domain/questtype.dart';

class Questmodel {
  final String uid;
  final String questName;
  Queststatus status;
  final Questtype questType;
  final String questHint;
  final int questXp;
  DateTime completedAt;
  String completedLocation;
  String scannedPhoto;

  Questmodel({
    required this.uid,
    required this.questName,
    this.status = Queststatus.incomplete,
    required this.questHint,
    required this.questXp,
    DateTime? completedAt,
    required this.questType,
    this.completedLocation = "",
    this.scannedPhoto = "",
  }) : completedAt = completedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'questName': questName,
      'status': status.name,
      'questType': questType.name,
      'questHint': questHint,
      'questXp': questXp,
      'completedAt': Timestamp.fromDate(completedAt),
      'completedLocation': completedLocation,
      'scannedPhoto': scannedPhoto,
    };
  }

  factory Questmodel.fromMap(Map<String, dynamic> map) {
    return Questmodel(
      uid: map['uid'],
      questName: map['questName'],
      status: Queststatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => Queststatus.incomplete,
      ),
      questHint: map['questHint'] ?? "",
      questXp: map['questXp'] ?? 0,
      completedAt: (map['completedAt'] as Timestamp).toDate(),
      completedLocation: map['completedLocation'] ?? "",
      scannedPhoto: map['scannedPhoto'] ?? "",
      questType: Questtype.values.firstWhere(
        (e) => e.name == map['questType'],
        orElse: () => Questtype.scanWord,
      ),
    );
  }
}
