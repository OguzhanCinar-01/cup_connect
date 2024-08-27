import 'package:flutter/material.dart';

class SyrupModel with ChangeNotifier{
  String _selectedSyrup = 'Classic';

  String get selectedSyrup => _selectedSyrup;

  void selectSyrup(String syrup){
    _selectedSyrup = syrup;
    notifyListeners();
  }
}