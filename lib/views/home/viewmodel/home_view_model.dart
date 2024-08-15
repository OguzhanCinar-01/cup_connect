import 'package:flutter/material.dart';

class HomeViewModel with ChangeNotifier {
  HomeViewModel();

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    debugPrint('Current Index: $_currentIndex');
    notifyListeners();
  }
}
