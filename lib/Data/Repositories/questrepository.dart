import 'package:lexiquest/Data/Model/questmodel.dart';

abstract class Questrepository {
  Future<void> completeQuest(
    String userId,
    Questmodel quest,
    String completedLocation,
    String scannedPhoto,
  );

  Future<List<Questmodel>> fetchAllQuests();

  Future<Questmodel?> fetchQuestById(String questId);

  Future<List<Questmodel>> fetchUserCompletedQuests(String userId);
  Future<List<Questmodel>> fetchUserActiveQuests(String userId);

  Future<List<Questmodel>> fetchUserIncompleteQuests(String userId);

  Future<void> saveQuestLocally(Questmodel quest);

  Future<void> syncLocalQuestsToCloud(
    String userId,
    Future<void> Function(String, Questmodel) uploadQuest,
  );

  Future<void> clearLocalQuests();

  Future<Questmodel?> callGenerateQuest();

  void updateQuest(Questmodel quest) {}
}
