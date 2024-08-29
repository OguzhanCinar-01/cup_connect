import 'package:coffee_shop/services/firebase_service.dart';
import 'package:flutter/material.dart';

class AdminPanelViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();

  List<Map<String, dynamic>> _orders = [];
  final List<Map<String, dynamic>> _completedOrders = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get orders => _orders;
  List<Map<String, dynamic>> get completedOrders => _completedOrders;
  bool get isLoading => _isLoading;

  /// Fetch user data
  Future<void> fetchOrders() async {
    _isLoading = true;
    notifyListeners();
    _orders = await FirebaseService().getAdminPanelData();
    _isLoading = false;
    notifyListeners();
  }

  /// Fetch completed orders
  Future<void> fetchCompletedOrders() async {
    _isLoading = true;
    notifyListeners();

    _completedOrders.clear();
    _completedOrders.addAll(await FirebaseService().getCompletedOrdersData());
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
}
