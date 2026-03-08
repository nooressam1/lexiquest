import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lexiquest/Data/Model/questmodel.dart';
import 'package:lexiquest/Data/Model/usermodel.dart';
import 'package:lexiquest/Data/Repositories/userrepository.dart';



class Fetchuser  {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Usermodel?> fetchUserbyId(String userId) async{
    final doc = await _firestore.collection('users').doc(userId).get();
    if (!doc.exists) return null;
    return Usermodel.fromMap(doc.data()!);
  }

  @override
  Future<void> addCompletedQuest(String userId, Questmodel quest) {
    // TODO: implement addCompletedQuest
    throw UnimplementedError();
  }

  @override
  Future<void> addLanguagesExplored(String userId, String language) {
    // TODO: implement addLanguagesExplored
    throw UnimplementedError();
  }

  @override
  Future<void> addScannedWord(String userId, String word) {
    // TODO: implement addScannedWord
    throw UnimplementedError();
  }

  @override
  Future<void> addXp(String userId, int pointsToAdd) {
    // TODO: implement addXp
    throw UnimplementedError();
  }

  @override
  Future<void> createUser(Usermodel usermodel) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<List<Usermodel>> fetchAllUsers() {
    // TODO: implement fetchAllUsers
    throw UnimplementedError();
  }

  @override
  Future<List<Questmodel>> fetchCompletedQuests(String userId) {
    // TODO: implement fetchCompletedQuests
    throw UnimplementedError();
  }


  @override
  Future<void> updateUser(Usermodel usermodel) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
  
  @override
  Future<void> addIncompleteQuests(String userId, Questmodel quest) {
    // TODO: implement addIncompleteQuests
    throw UnimplementedError();
  }
}
