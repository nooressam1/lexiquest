import 'package:lexiquest/Features/Quest/Domain/questcategories.dart';
import 'package:lexiquest/Features/Quest/Domain/questtype.dart';

class Levelrules {
  static List<Questtype> unlockedFeatures(int level) {
    List<Questtype> features = [Questtype.scanWord];
    if (level >= 11) {
      features.add(Questtype.scanLetterCount);
    }
    if (level >= 21) {
      features.add(Questtype.scanFirstLetter);
    }
    if (level >= 31) {
      features.add(Questtype.scanPOS);
    }
    if (level >= 41) {
      features.add(Questtype.scanCategory);
    }
    return features;
  }

  static List<Questcategories> categoriesLevel(int level) {
    final allCategories = Questcategories.values;
    int count = 5 * (level - 1) * 2;
    if (count < 0) count = 0;

    if (count > allCategories.length) {
      count = allCategories.length;
    }
    return allCategories.take(count).toList();
  }

  static int xpForLevel(int level) {
    return level * 1000;
  }
}
