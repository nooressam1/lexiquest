import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lexiquest/Data/Model/questmodel.dart';
import 'package:lexiquest/Data/Repositories/questrepository.dart';
import 'package:lexiquest/Data/Repositories/sharedpreferences.dart';
import 'package:lexiquest/Data/Repositories/userrepository.dart';
import 'package:lexiquest/Features/Quest/Domain/questgenerator%20.dart';
import 'package:lexiquest/Features/Quest/Domain/queststatus.dart';

class FirebaseQuestRepository implements Questrepository {
  final FirebaseFirestore _firestore;
  final Userrepository _userRepository;

  FirebaseQuestRepository({
    FirebaseFirestore? firestore,
    required Userrepository userRepository,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _userRepository = userRepository;

  @override
  Future<void> completeQuest(
    String userId,
    Questmodel quest,
    String completedLocation,
    String scannedPhoto,
  ) async {
    quest.completedLocation = completedLocation;
    quest.scannedPhoto = scannedPhoto;
    quest.completedAt = DateTime.now();
    quest.status = Queststatus.complete;

    await _firestore.collection("quests").doc(quest.uid).update(quest.toMap());
    await _userRepository.addCompletedQuest(userId, quest);
    await _userRepository.addXp(userId, quest.questXp);
  }

  @override
  Future<Questmodel?> fetchQuestById(String questId) async {
    final snapshot = await _firestore.collection("quests").doc(questId).get();
    if (!snapshot.exists || snapshot.data() == null) return null;
    return Questmodel.fromMap(snapshot.data()!);
  }

  @override
  Future<List<Questmodel>> fetchAllQuests() async {
    final snapshot = await _firestore.collection("quests").get();
    print('Fetched ${snapshot.docs.length} quests from Firestore');

    return snapshot.docs.map((doc) => Questmodel.fromMap(doc.data())).toList();
  }

  @override
  Future<List<Questmodel>> fetchUserCompletedQuests(String userId) async {
    final user = await _userRepository.fetchUserbyId(userId);

    if (user == null || user.completedQuests == null) return [];

    List<Questmodel> quests = [];

    for (String questId in user.completedQuests!) {
      final doc = await FirebaseFirestore.instance
          .collection("quests")
          .doc(questId)
          .get();

      if (doc.exists) {
        quests.add(Questmodel.fromMap(doc.data()!));
      }
    }

    return quests;
  }

  @override
  Future<List<Questmodel>> fetchUserIncompleteQuests(String userId) async {
    final user = await _userRepository.fetchUserbyId(userId);

    if (user == null || user.incompletedQuests == null) return [];

    List<Questmodel> quests = [];

    for (String questId in user.incompletedQuests!) {
      final doc = await FirebaseFirestore.instance
          .collection("quests")
          .doc(questId)
          .get();

      if (doc.exists) {
        quests.add(Questmodel.fromMap(doc.data()!));
      }
    }

    return quests;
  }

  @override
  Future<void> saveQuestLocally(Questmodel quest) async {
    throw UnimplementedError();
  }

  @override
  Future<void> syncLocalQuestsToCloud(
    String userId,
    Future<void> Function(String, Questmodel) uploadQuest,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<void> clearLocalQuests() async {
    throw UnimplementedError();
  }

  Future<void> storeQuestInFirestore(Questmodel quest) async {
    await FirebaseFirestore.instance
        .collection("quests")
        .doc(quest.uid)
        .set(quest.toMap());
  }

  Future<void> updateQuest(Questmodel quest) async {
    await FirebaseFirestore.instance
        .collection("quests")
        .doc(quest.uid)
        .update(quest.toMap());
  }

  @override
  Future<Questmodel?> callGenerateQuest() async {
    final userId = await Sharedpreferences.getUserId();
    final user = await _userRepository.fetchUserbyId(userId!);
    print("testing inside firebase quest repo : ${user}");

    Questgenerator questGenerator = Questgenerator();
    if (user == null) {
      return null;
    }
    print(
      "testing inside firebase quest repo : ${questGenerator.generateQuest(user.userlevel)}",
    );
    final newQuest = questGenerator.generateQuest(user.userlevel);
    storeQuestInFirestore(newQuest);
    return newQuest;
  }

  @override
  Future<List<Questmodel>> fetchUserActiveQuests(String userId) async {
    final user = await _userRepository.fetchUserbyId(userId);

    if (user == null || user.incompletedQuests == null) return [];

    List<Questmodel> quests = [];

    for (String questId in user.activeQuests!) {
      final doc = await FirebaseFirestore.instance
          .collection("quests")
          .doc(questId)
          .get();

      if (doc.exists) {
        quests.add(Questmodel.fromMap(doc.data()!));
      }
    }

    return quests;
  }
}
