import 'package:coffee_shop/services/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileViewModel extends ChangeNotifier{
  
  final FirebaseService _firebaseService = FirebaseService();
  String _userName = 'User';
  String _userSurname = '';
  bool _isLoading = true;

  String get userName => _userName;
  String get userSurname => _userSurname;
  bool get isLoading => _isLoading;


  Future<void> loadUserData() async {
   try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        String? userName = await _firebaseService.getUserName(userId);
        String? userSurname = await _firebaseService.getUserSurname(userId);

        _userName = userName != null && userName.isNotEmpty
            ? userName[0].toUpperCase() + userName.substring(1)
            : 'User';

        _userSurname = userSurname.isNotEmpty
            ? userSurname[0].toUpperCase() + userSurname.substring(1)
            : '';

        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      print('Error loading user data: $e');
      _isLoading = false;
      notifyListeners();
    }
  }
  }
