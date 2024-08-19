import 'package:flutter/material.dart';

class SizeButtonModel with ChangeNotifier {
  int _selectedSize = 0;

  int get selectedSize => _selectedSize;

  void setSelectedSize(int size) {
    _selectedSize = size;
    notifyListeners();
  }
}
