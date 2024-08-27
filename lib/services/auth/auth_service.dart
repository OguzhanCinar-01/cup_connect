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
