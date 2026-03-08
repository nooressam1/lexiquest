import 'package:lexiquest/Data/Model/questmodel.dart';
import 'package:lexiquest/Data/Repositories/questrepository.dart';
import 'package:lexiquest/Data/databasehelper.dart';
import 'package:lexiquest/Features/Quest/Domain/queststatus.dart';
import 'package:lexiquest/Features/Quest/Domain/questtype.dart';

class SqliteQuestRepository implements Questrepository {
  final Databasehelper dbHelper = Databasehelper();

  @override
  Future<void> completeQuest(
    String userId,
    Questmodel quest,
    String completedLocation,
    String scannedPhoto,
  ) async {
    // Update existing quest
    quest.completedLocation = completedLocation;
    quest.scannedPhoto = scannedPhoto;
    quest.completedAt = DateTime.now();
    quest.status = Queststatus.complete;

    await dbHelper.insertOfflineQuest(quest);
  }

  @override
  Future<List<Questmodel>> fetchAllQuests() async {
    return await dbHelper.getAllQuests();
  }

  @override
  Future<Questmodel?> fetchQuestById(String questId) async {
    return await dbHelper.getQuestById(questId);
  }

  @override
  Future<List<Questmodel>> fetchUserCompletedQuests(String userId) async {
    // Filter offline quests marked complete
    final offlineQuests = await dbHelper.getAllOfflineQuests();
    return offlineQuests
        .where((q) => q.status == Queststatus.complete)
        .toList();
  }

  @override
  Future<List<Questmodel>> fetchUserIncompleteQuests(String userId) async {
    final offlineQuests = await dbHelper.getAllOfflineQuests();
    return offlineQuests
        .where((q) => q.status != Queststatus.complete)
        .toList();
  }

  @override
  Future<void> saveQuestLocally(Questmodel quest) async {
    await dbHelper.insertOfflineQuest(quest);
  }

  @override
  Future<void> syncLocalQuestsToCloud(
    String userId,
    Future<void> Function(String, Questmodel) uploadQuest,
  ) async {
    final offlineQuests = await dbHelper.getAllOfflineQuests();

    for (var quest in offlineQuests) {
      await uploadQuest(userId, quest); // Call Firebase repository
    }

    await clearLocalQuests();
  }

  @override
  Future<void> clearLocalQuests() async {
    await dbHelper.clearOfflineQuests();
  }

  @override
  Future<Questmodel?> callGenerateQuest() {
    // Offline repo doesn't generate quests; leave unimplemented
    throw UnimplementedError();
  }

  @override
  void updateQuest(Questmodel quest) async {
    await dbHelper.updateQuest(quest);
  }
  
  @override
  Future<List<Questmodel>> fetchUserActiveQuests(String userId) {
    // TODO: implement fetchUserActiveQuests
    throw UnimplementedError();
  }
}
