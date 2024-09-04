import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/navigation/navigation_manager.dart';
import 'package:coffee_shop/views/adminPanel/view/admin_panel_view.dart';
import 'package:coffee_shop/views/home/view/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  /// Instance of FirebaseAuth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Sign user in
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      String userId = userCredential.user!.uid;

      /// Get user role
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(userId).get();
      String role = userDoc.get('role');    

      if(role == 'admin') {
        /// Navigate to admin panel
        NavigationManager.instance.navigateToPageClear(const AdminPanelView());
      } else {
        /// Navigate to home page
        NavigationManager.instance.navigateToPageClear(const HomeView());
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  /// New signInAnonymously method
  Future<UserCredential> signInAnonymously() async {
    return await _firebaseAuth.signInAnonymously();
  }

  /// create user account
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  /// Sign user out
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
