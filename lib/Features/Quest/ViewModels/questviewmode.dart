import 'package:flutter/material.dart';
import 'package:lexiquest/Data/Model/questmodel.dart';
import 'package:lexiquest/Data/Repositories/questrepository.dart';
import 'package:lexiquest/Data/Repositories/sharedpreferences.dart';
import 'package:lexiquest/Data/Repositories/userrepository.dart';
import 'package:lexiquest/Features/Quest/Domain/queststatus.dart';

class Questviewmode extends ChangeNotifier {
  final Questrepository _questRepository;
  final Userrepository _userRepository;

  Questviewmode(this._questRepository, this._userRepository);

  Future<Questmodel> generateQuest() async {
    final quest = await _questRepository.callGenerateQuest();
    return quest!;
  }

  Future<void> loadNewQuests() async {
    final userid = await Sharedpreferences.getUserId();
    final List<Questmodel> incompletedQuests = await _questRepository
        .fetchUserIncompleteQuests(userid!);
    print("testing inside viewmodel : ${incompletedQuests}");

    if (incompletedQuests.isEmpty) {
      final newQuest = await generateQuest();
      _userRepository.addIncompleteQuests(userid, newQuest);
    }

    notifyListeners();
  }

  Future<void> activateQuest(String questID) async {
    final userId = await Sharedpreferences.getUserId();
    if (userId == null) return;

    final Questmodel? quest = await _questRepository.fetchQuestById(questID);

    if (quest == null) return;

    quest.status = Queststatus.active;

    _questRepository.updateQuest(quest);
    _userRepository.removeIncompleteQuests(userId, quest);
    _userRepository.addActiveQuests(userId, quest);

    //remove from incompleted quests
    // add to active quetsts
    print("yay it worked}");

    // Notify listeners after successful update
    notifyListeners();
  }
}
