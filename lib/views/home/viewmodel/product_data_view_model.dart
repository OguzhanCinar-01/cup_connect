import 'package:coffee_shop/services/firebase_service.dart';
import 'package:flutter/material.dart';

class ProductDataViewModel extends ChangeNotifier{
  List<Map<String, dynamic>> _hotCoffeeList = [];
  List<Map<String, dynamic>> _coldCoffeeList = [];
  List<Map<String, dynamic>> _dessertList = [];

  List<Map<String, dynamic>> get hotCoffeeList => _hotCoffeeList;
  List<Map<String, dynamic>> get coldCoffeeList => _coldCoffeeList;
  List<Map<String, dynamic>> get dessertList => _dessertList;

  /// Get hot coffee data
  Future<void> getHotCoffeeData() async {
    _hotCoffeeList = await FirebaseService().getHotCoffeeData();
    notifyListeners();
  }
  /// Get cold coffee data
  Future<void> getColdCoffeeData() async {
    _coldCoffeeList = await FirebaseService().getColdCoffeeData();
    notifyListeners();
  }
  /// Get dessert data
  Future<void> getDessertData() async {
    _dessertList = await FirebaseService().getDessertData();
    notifyListeners();
  }


}