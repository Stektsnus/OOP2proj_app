import 'package:flutter/material.dart';

class NavigationBarNotifier extends ChangeNotifier {
  int value = 0;

  void updateValue(int val) {
    value = val;
    notifyListeners();
  }
}