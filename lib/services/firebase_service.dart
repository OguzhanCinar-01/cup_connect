import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get username from Firebase

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

  /// GetSurname method
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

  /// Get orderID from firestore
  Future<String> getOrderId() async {
    try {
      final DocumentReference docRef = _firestore.collection('orders').doc();
      return docRef.id;
    } catch (e) {
      print("Error fetching order ID: $e");
      return '';
    }
  }

  /// Get admin panel data from firestore
  Future<List<Map<String, dynamic>>> getAdminPanelData() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('orders').get();
      print('Admin panel data fetched successfully');
      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error fetching admin panel data: $e');
      return [];
    }
  }

  /// Get completed orders
  Future<List<Map<String, dynamic>>> getCompletedOrdersData() async {
    try {
      final QuerySnapshot querySnapshot =
          await _firestore.collection('completedOrders').get();
      print('Completed orders fetched successfully');
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Failed to fetch completed orders: $e');
      return [];
    }
  }

  /// Update order status
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await _firestore.collection('orders').doc(orderId).update({
        'orderStatus': newStatus,
      });
    } catch (e) {
      print('Error updating order status: $e');
      rethrow;
    }
  }

  /// Get Order ID from firestore
  Future<Map<String, dynamic>?> getOrderById(String orderId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('orders').doc(orderId).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print("Error getting order by ID: $e");
      rethrow;
    }
  }

  /// Get order by User ID
  Future<List<Map<String, dynamic>>> getOrderByUserId(String userId) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print('Error fetching order by user ID: $e');
      return [];
    }
  }
}
