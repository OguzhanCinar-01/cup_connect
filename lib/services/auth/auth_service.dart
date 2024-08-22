import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  /// Instance of FirebaseAuth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Instance of Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  /// Add user details to firestore
  Future<void> addUserDetails(String name, String surname, String email) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'surname': surname,
          'email': email,
        });
      } else {
        throw Exception("No user is currently signed in.");
      }
    } catch (e) {
      print("Error adding user details: $e");
      rethrow;
    }
  }

  /// Get user name from firestore
  Future<String?> getUserName(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return doc['name'] as String?;
      } else {
        print("No user data found for the given user ID.");
        return null;
      }
    } catch (e) {
      print("Error fetching user name: $e");
      return null;
    }
  }

  Future<String> getUserSurname(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return doc['surname'] as String;
      } else {
        print("No user data found for the given user ID.");
        return '';
      }
    } catch (e) {
      print("Error fetching user surname: $e");
      return '';
    }
  }

  /// Add coffee to firestore
  /*Future<void> addDessertData() async {
    List<Map<String, dynamic>> coffeeList = [
      {
        'dessert_name': 'Chocolate Cake',
        'price': 7.0,
        'descriptions':
            'A slice of chocolate cake with a scoop of vanilla ice cream.',
      },
      {
        'dessert_name': 'Cheesecake',
        'price': 6.0,
        'descriptions': 'A slice of cheesecake with a strawberry topping.',
      },
      {
        'dessert_name': 'Tiramisu',
        'price': 8.0,
        'descriptions': 'A slice of tiramisu with a sprinkle of cocoa powder.',
      },
      {
        'dessert_name': 'Creme Brulee',
        'price': 7.0,
        'descriptions': 'A serving of creme brulee with a caramelized top.',
      },
      {
        'dessert_name': 'Panna Cotta',
        'price': 6.0,
        'descriptions': 'A serving of panna cotta with a berry compote.',
      },
      {
        'dessert_name': 'Apple Pie',
        'price': 7.0,
        'descriptions': 'A slice of apple pie with a scoop of vanilla ice cream.',
      },
      {
        'dessert_name': 'Brownie',
        'price': 5.0,
        'descriptions': 'A serving of brownie with a scoop of vanilla ice cream.',
      },
    ];

    try {
      final firestore = FirebaseFirestore.instance;

      for (var coffee in coffeeList) {
        await firestore.collection('desserts').add(coffee);
      }

      print('Coffee data added to Firestore');
    } catch (e) {
      print('Failed to add coffee data: $e');
    }
  }*/

  /// Get coffee data from firestore
  Future<List<Map<String, dynamic>>> getHotCoffeeData() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection('hot_coffees').get();
      List<Map<String, dynamic>> hotCoffeeList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return hotCoffeeList;
    } catch (e) {
      print('Failed to fetch hot coffee data: $e');
      return [];
    }
  }
  Future<List<Map<String, dynamic>>> getColdCoffeeData() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection('cold_coffees').get();
      List<Map<String, dynamic>> coldCoffeeList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return coldCoffeeList;
    } catch (e) {
      print('Failed to fetch hot coffee data: $e');
      return [];
    }
  }
  Future<List<Map<String, dynamic>>> getDessertData() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection('desserts').get();
      List<Map<String, dynamic>> dessertList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return dessertList;
    } catch (e) {
      print('Failed to fetch hot coffee data: $e');
      return [];
    }
  }
}
