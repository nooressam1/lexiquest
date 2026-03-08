import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lexiquest/Data/Model/questmodel.dart';
import 'package:lexiquest/Data/Model/usermodel.dart';
import 'package:lexiquest/Data/Repositories/userrepository.dart';
import 'package:lexiquest/Data/Repositories/fetchuser.dart';

class Userviewmodel extends ChangeNotifier {
  final Userrepository _userRepository;
  final Fetchuser _fetchuser = Fetchuser();

  Userviewmodel(this._userRepository);

  Usermodel? user;

  Future<void> fetchUser(String uid) async {
    final fetchedUsers = await _userRepository.fetchUserbyId(uid);
    if (fetchedUsers == null) {
      return;
    }
    user = fetchedUsers;
    notifyListeners();
  }

  Future<void> fetchUserby(String uid) async {
    user = await _fetchuser.fetchUserbyId(uid);
    notifyListeners();
  }

  Future<List<Usermodel>> fetchUsers() async {
    final users = await _userRepository.fetchAllUsers();
    print('Fetched ${users} users from Userrepository');
    return await _userRepository.fetchAllUsers();
    
  }

  Future<void> updateUser(Usermodel usermodel) async {
    await _userRepository.updateUser(usermodel);
    user = usermodel;
    notifyListeners();
  }

  Future<void> addXp(int amount) async {
    if (user == null) return;
    user!.userXp += amount; // local state
    await _userRepository.addXp(user!.uid, amount); // update database
    notifyListeners();
  }

  Future<void> addCompletedQuest(Questmodel quest) async {
    if (user == null) return;
    user!.completedQuests ??= [];
    if (!user!.completedQuests!.contains(quest.uid)) {
      user!.completedQuests!.add(quest.uid);
    }

    user!.completedQuests!.add(quest.uid); // local state
    await addXp(100); // business logic
    await _userRepository.addCompletedQuest(user!.uid, quest); // database
    notifyListeners();
  }

  Future<void> addScannedWord(String userId, String word) async {
    user!.scannedWords ??= [];
    if (!user!.scannedWords!.contains(word)) {
      user!.scannedWords!.add(word);
    }
    await _userRepository.addScannedWord(user!.uid, word);
    notifyListeners();
  }

  Future<void> addLanguagesExplored(String userId, String language) async {
    user!.languagesExplored ??= [];
    if (!user!.scannedWords!.contains(language)) {
      user!.scannedWords!.add(language);
    }
    await _userRepository.addScannedWord(userId, language);
    notifyListeners();
  }

  Future<List<Questmodel>> fetchCompletedQuests(String userId) async {
    if (user == null) return [];

    return _userRepository.fetchCompletedQuests(userId);
  }

  Future<double> calculateProgressBarXp() async {
    final xp = user!.userXp;

    final minXpForLevel = user!.userlevel * user!.userlevel * 1000;
    final maxXpForNextLevel =
        (user!.userlevel + 1) * (user!.userlevel + 1) * 1000;

    final value = ((xp - minXpForLevel) / (maxXpForNextLevel - minXpForLevel))
        .clamp(0.0, 1.0);

    print(
      'XP: $xp, Level: ${user!.userlevel}, minXP: $minXpForLevel, maxXP: $maxXpForNextLevel, Progress: $value',
    );

    return value;
  }

  Future<void> updateUserProfile({
    String? username,
    String? email,
    String? password,
    int? imageId,
  }) async {
    await _userRepository.updateProfile(username!, email!, password!, imageId!);
    if (username != null) user!.username = username;
    if (email != null) user!.email = email;
    if (imageId != null) user!.profilepicture = imageId;
    notifyListeners();
  }
}
