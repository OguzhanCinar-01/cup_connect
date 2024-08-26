import 'package:flutter/material.dart';

class CardModel with ChangeNotifier {
  bool _isSelected = false;

  bool get isSelected => _isSelected;

  void toggleSelection() {
    _isSelected = !_isSelected;
    notifyListeners();
  }
}
