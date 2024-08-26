import 'package:flutter/material.dart';

class SelectionViewModel extends ChangeNotifier {
  bool _isSelected = false;

  bool get isSelected => _isSelected;

  void toggleSelection() {
    _isSelected = !_isSelected;
    notifyListeners();
  }
}
