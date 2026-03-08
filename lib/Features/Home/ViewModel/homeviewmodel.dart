import 'package:flutter/material.dart';

class Homeviewmodel extends ChangeNotifier {
  int currentIndex = 0;
  final navigatorKeys = List.generate(5, (_) => GlobalKey<NavigatorState>());

  void selectTab(int index) {
    if (index == currentIndex) {
      navigatorKeys[index].currentState!.popUntil((r) => r.isFirst);
    } else {
      currentIndex = index;
      notifyListeners();
    }
  }
}
