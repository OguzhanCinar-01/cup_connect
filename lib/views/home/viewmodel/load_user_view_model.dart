import 'package:coffee_shop/services/firebase_service.dart';
import 'package:flutter/material.dart';

class LoadUserViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();
  String _userName = '';
  bool _isLoading = true;

  String get userName => _userName;
  bool get isLoading => _isLoading;

  Future<void> loadUserData(String userId) async {
    try {
      String? userName = await _firebaseService.getUserName(userId);
      _userName = userName ?? 'User';
      _userName = _userName[0].toUpperCase() + _userName.substring(1);
      _isLoading = false;
    } catch (e) {
      print('Error: $e');
      _isLoading = false;
    }
    notifyListeners();
  }
}
