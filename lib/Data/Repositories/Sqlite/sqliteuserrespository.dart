import 'package:lexiquest/Data/Model/questmodel.dart';
import 'package:lexiquest/Data/Model/usermodel.dart';
import 'package:lexiquest/Data/Repositories/userrepository.dart';
import 'package:lexiquest/Data/databasehelper.dart';

class Sqliteuserrespository implements Userrepository {
  final Databasehelper dbHelper = Databasehelper();

  @override
  Future<void> addCompletedQuest(String userId, Questmodel quest) {
    // leave empty. Quest hangleds storing locally
    throw UnimplementedError();
  }

  @override
  Future<void> addLanguagesExplored(String userId, String language) {
    // leave empty.
    throw UnimplementedError();
  }

  @override
  Future<void> addScannedWord(String userId, String word) {
    // leave empty.
    throw UnimplementedError();
  }

  @override
  Future<void> addXp(String userId, int pointsToAdd) {
    // leave empty.
    throw UnimplementedError();
  }

  @override
  Future<void> createUser(Usermodel usermodel) {
    return dbHelper.insertUser(usermodel);
  }

  @override
  Future<List<Usermodel>> fetchAllUsers() {
    // leave empty.
    throw UnimplementedError();
  }

  @override
  Future<List<Questmodel>> fetchCompletedQuests(String userId) {
    // leave empty.
    throw UnimplementedError();
  }

  @override
  Future<Usermodel?> fetchUserbyId(String userId) {
    return dbHelper.getUserById(userId);
  }

  @override
  Future<void> updateUser(Usermodel usermodel) {
    return dbHelper.updateUser(usermodel);
  }

  @override
  Future<void> addIncompleteQuests(String userId, Questmodel quest) {
    // TODO: implement addIncompleteQuests
    throw UnimplementedError();
  }

  @override
  Future<void> addActiveQuests(String userId, Questmodel quest) {
    // TODO: implement addActiveQuests
    throw UnimplementedError();
  }

  @override
  Future<void> removeActiveQuests(String userId, Questmodel quest) {
    // TODO: implement removeActiveQuests
    throw UnimplementedError();
  }

  @override
  Future<void> removeIncompleteQuests(String userId, Questmodel quest) {
    // TODO: implement removeIncompleteQuests
    throw UnimplementedError();
  }

  @override
  Future<void> updateProfile(
    String? username,
    String? email,
    String? password,
    int? imageId,
  ) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
