import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/services/firebase_service.dart';
import 'package:flutter/material.dart';

class AdminPanelViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();

  List<Map<String, dynamic>> _orders = [];
  List<Map<String, dynamic>> _completedOrders = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get orders => _orders;
  List<Map<String, dynamic>> get completedOrders => _completedOrders;
  bool get isLoading => _isLoading;

  /// Fetch user data
  Future<void> fetchOrders() async {
    _isLoading = true;
    notifyListeners();
    _orders = await _firebaseService.getAdminPanelData();
    _isLoading = false;
    notifyListeners();
  }

  /// Fetch orders by ID
  Future<void> fetchOrdersById(String orderId) async {
    _isLoading = true;
    notifyListeners();
    _orders = await _firebaseService.getOrderByUserId(orderId);
    _isLoading = false;
    notifyListeners();
  }

  /// Fetch completed orders
  Future<void> fetchCompletedOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Firestore'dan completed_orders koleksiyonunu çekin
      final completedOrdersSnapshot = await FirebaseFirestore.instance
          .collection('completed_orders')
          .orderBy('orderDate', descending: true)
          .orderBy('orderTime', descending: true)
          .get();

      _completedOrders =
          completedOrdersSnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error fetching completed orders: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Update order status
  Future<void> setUpdateOrderStatus(String orderId, String newStatus) async {
    try {
      await _firebaseService.updateOrderStatus(orderId, newStatus);

      await fetchOrders();

      await fetchCompletedOrders();

      notifyListeners();
    } catch (e) {
      print('Error updating order status: $e');
      rethrow;
    }
  }

  /// Get timeline status based on order status
  String getTimelineStatus(String status) {
    switch (status) {
      case 'Pending':
        return 'Order has been received.';
      case 'Preparing':
        return 'Order is preparing.';
      case 'Completed':
        return 'Your order is completed! Meet us at the pickup area.';
      default:
        return 'Unknown status';
    }
  }

  /// Get orderID from firestore
  Future<Map<String, dynamic>?> getOrderById(String orderId) async {
    try {
      final orderData = await _firebaseService.getOrderById(orderId);
      notifyListeners();
      return orderData;
    } catch (e) {
      print("Error getting order by ID: $e");
      rethrow;
    }
  }

  /// Get completed order by UserID
  Future<void> fetchCompletedOrdersbyUserID(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final completedOrdersSnapshot = await FirebaseFirestore.instance
          .collection('completed_orders')
          .where('userId', isEqualTo: userId)
          .get();

      _completedOrders =
          completedOrdersSnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print('Error fetching completed orders: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
