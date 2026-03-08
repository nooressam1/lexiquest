import 'dart:math';

import 'package:lexiquest/Features/Quest/Domain/levelrules.dart';
import 'package:lexiquest/Features/Quest/Domain/questcategories.dart';
import 'package:lexiquest/Data/Model/questmodel.dart';
import 'package:lexiquest/Features/Quest/Domain/queststatus.dart';
import 'package:lexiquest/Features/Quest/Domain/questtype.dart';

class Questgenerator {
  final Map<Questcategories, List<String>> categoryWords = {
    Questcategories.Animals: [
      'cat',
      'dog',
      'lion',
      'elephant',
      'tiger',
      'bear',
      'wolf',
      'fox',
      'giraffe',
      'monkey',
    ],
    Questcategories.Colors: [
      'red',
      'blue',
      'green',
      'yellow',
      'purple',
      'orange',
      'pink',
      'brown',
      'black',
      'white',
    ],
    Questcategories.Countries: [
      'Egypt',
      'France',
      'Japan',
      'Brazil',
      'India',
      'Canada',
      'Germany',
      'China',
      'Italy',
      'Mexico',
    ],
    Questcategories.Emotion: [
      'happy',
      'sad',
      'angry',
      'excited',
      'scared',
      'bored',
      'surprised',
      'nervous',
      'proud',
      'jealous',
    ],
    Questcategories.Flowers: [
      'rose',
      'tulip',
      'lily',
      'daisy',
      'sunflower',
      'orchid',
      'violet',
      'marigold',
      'daffodil',
      'lotus',
    ],
    Questcategories.Food: [
      'pizza',
      'bread',
      'apple',
      'banana',
      'pasta',
      'cheese',
      'chocolate',
      'rice',
      'cake',
      'soup',
    ],
    Questcategories.Shape: [
      'circle',
      'square',
      'triangle',
      'rectangle',
      'oval',
      'pentagon',
      'hexagon',
      'star',
      'heart',
      'diamond',
    ],
    Questcategories.Travel: [
      'airport',
      'hotel',
      'beach',
      'train',
      'passport',
      'ticket',
      'luggage',
      'tour',
      'map',
      'cruise',
    ],
  };
  final List<String> Words = [
    'apple',
    'bicycle',
    'mountain',
    'river',
    'elephant',
    'guitar',
    'horizon',
    'jungle',
    'kite',
    'lantern',
    'moon',
    'notebook',
    'ocean',
    'pancake',
    'quilt',
    'rainbow',
    'sunflower',
    'tornado',
    'umbrella',
    'violin',
    'waterfall',
    'xylophone',
    'yacht',
    'zeppelin',
    'avocado',
    'balloon',
    'castle',
    'dragon',
    'envelope',
    'feather',
    'galaxy',
    'hammock',
    'iceberg',
    'jasmine',
    'koala',
    'lemonade',
    'mushroom',
    'nebula',
    'octopus',
    'pillow',
    'quartz',
    'rocket',
    'sandwich',
    'telescope',
    'universe',
    'volcano',
    'window',
    'x-ray',
    'yo-yo',
    'zucchini',
  ];

  String generateUniqueId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final randomNumber = Random().nextInt(10000);
    return "$timestamp-$randomNumber";
  }

  String generateQuestName({
    Questcategories? category, // optional
    required Questtype questType,
  }) {
    switch (questType) {
      case Questtype.scanWord:
        String questWord = (Words..shuffle()).first;
        return "Scan the word $questWord ";
      case Questtype.scanLetterCount:
        final length =
            5 +
            (DateTime.now().millisecondsSinceEpoch % 3); // example 5-7 letters
        return category != null
            ? "Scan a $length-letter word from ${category.name}"
            : "Scan a $length-letter word";

      case Questtype.scanFirstLetter:
        final letter = String.fromCharCode(
          65 + (DateTime.now().millisecondsSinceEpoch % 26),
        );
        return category != null
            ? "Scan a word starting with '$letter' from ${category.name}"
            : "Scan a word starting with '$letter'";

      case Questtype.scanPOS:
        final posList = ["noun", "verb", "adjective"];
        final pos = (posList..shuffle()).first;
        return category != null
            ? "Scan a $pos from ${category.name}"
            : "Scan a $pos word";

      case Questtype.scanCategory:
        return "Scan a word from ${category?.name}";
    }
  }

  String generateQuestHint({
    required Questtype type,
    Questcategories? category,
  }) {
    switch (type) {
      case Questtype.scanWord:
        return "Try to match the exact word shown in the quest.";
      case Questtype.scanLetterCount:
        return "Focus on words with a specific number of letters";
      case Questtype.scanFirstLetter:
        return "Find a word starting with the correct letter";
      case Questtype.scanPOS:
        return "This word should match the required part of speech";
      case Questtype.scanCategory:
        return "Look for any word in the ${category?.name} category";
    }
  }

  Questmodel generateQuest(int userLevel) {
    final unlockedFeatures = Levelrules.unlockedFeatures(userLevel);

    final allowedCategories = Levelrules.categoriesLevel(userLevel);
    Questtype questType = (unlockedFeatures..shuffle()).first;
    Questcategories? category;
    if (allowedCategories.isNotEmpty) {
      category = (allowedCategories..shuffle()).first;
    }
    return Questmodel(
      uid: generateUniqueId(),
      questName: generateQuestName(questType: questType, category: category),
      status: Queststatus.incomplete,
      questHint: generateQuestHint(type: questType, category: category),
      questXp: xpAmount(category, userLevel),
      questType: questType,
    );
  }

  int xpAmount(Questcategories? categoriesLevel, int userLevel) {
    if (categoriesLevel == null) {
      return (userLevel + 1) * 10;
    } else {
      return (userLevel + 1) * 20 * 10;
    }
  }
}
