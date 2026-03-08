import 'package:lexiquest/Data/Model/questmodel.dart';
import 'package:lexiquest/Data/Model/usermodel.dart';

abstract class Userrepository {
  Future<List<Usermodel>> fetchAllUsers();
  Future<Usermodel?> fetchUserbyId(String userId);
  Future<void> createUser(Usermodel usermodel);
  Future<void> updateUser(Usermodel usermodel);
  Future<void> updateProfile(
    String? username,
    String? email,
    String? password,
    int? imageId,
  );
  Future<void> addXp(String userId, int pointsToAdd);
  Future<List<Questmodel>> fetchCompletedQuests(String userId);
  Future<void> addCompletedQuest(String userId, Questmodel quest);
  Future<void> addIncompleteQuests(String userId, Questmodel quest);
  Future<void> addActiveQuests(String userId, Questmodel quest);
  Future<void> removeIncompleteQuests(String userId, Questmodel quest);
  Future<void> removeActiveQuests(String userId, Questmodel quest);
  Future<void> addScannedWord(String userId, String word);
  Future<void> addLanguagesExplored(String userId, String language);
}
