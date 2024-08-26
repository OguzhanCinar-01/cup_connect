import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Order {
  Order({
    required this.productName,
    this.syrup = 'None',
    this.size,
    required this.price,
    this.orderID,
    this.orderDate,
    this.orderTime,
    this.orderStatus,
    this.quantity = 1,
  });

  final String productName;
  String syrup;
  final String? size;
  final double price;

  final String? orderID;
  final DateTime? orderDate;
  final DateTime? orderTime;
  final String? orderStatus;
  int quantity;
}

class OrderViewModel extends ChangeNotifier {
  List<Order> orders = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Add order to the list
  void addOrder(Order order) {
    orders.add(order);
    notifyListeners();
  }

  /// Remove order from the list
  void removeOrder(Order order) {
    orders.remove(order);
    notifyListeners();
  }

  /// Calculate subtotal
  double calculateSubTotal() {
    double subTotal = 0;
    for (var order in orders) {
      subTotal += order.price * order.quantity;
    }
    return subTotal;
  }

  /// Calculate tax
  double calculateTax() {
    return calculateSubTotal() * 0.08;
  }

  /// Calculate total
  double calculateTotal() {
    return calculateSubTotal() + calculateTax();
  }

  ///Increase quantity
  void increaseQuantity(Order order) {
    order.quantity++;

    notifyListeners();
  }

  ///Decrease quantity
  void decreaseQuantity(Order order) {
    order.quantity--;
    if (order.quantity == 0) {
      removeOrder(order);
    }
    notifyListeners();
  }

  /// Submit order
  Future<void> submitOrder() async {
    final firestore = FirebaseFirestore.instance;

    /// Get the current date and time
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    String formattedTime = DateFormat('HH:mm').format(now);

    /// Generate a unique order ID
    var uuid = const Uuid();
    String orderID = uuid.v4();
    orderID = orderID.substring(0, 8);

    try {
      // Adding order to the database with the orderID in this way
      // allows us to easily query the order later
      if (orders.isNotEmpty) {
        await firestore.collection('orders').doc(orderID).set({
          'orderID': orderID,
          'orderDate': formattedDate,
          'orderTime': formattedTime,
          'orderStatus': 'Pending',
          'order_items': orders
              .map((order) => {
                    'productName': order.productName,
                    'syrup': order.syrup,
                    'size': order.size,
                    'price': order.price,
                    'quantity': order.quantity,
                  })
              .toList(),
        });

        // Clear the orders list
        orders.clear();
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Update order status
  Future<void> updateOrderStatus(String orderID, String newStatus) async {
    try {
      await _firestore.collection('orders').doc(orderID).update({
        'orderStatus': newStatus,
      });
      print('Order status updated to $newStatus');
    } catch (e) {
      rethrow;
    }

    // Update the status of the order
    notifyListeners();
  }

  /// Get order by ID
  Future<Map<String, dynamic>?> getOrderById(String orderID) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('orders').doc(orderID).get();

      if (snapshot.exists) {
        return snapshot.data() as Map<String, dynamic>?;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  /// Adding orders to completedOrders collection
  Future<void> completedOrders(
      String orderID, Map<String, dynamic> orderData) async {
    try {
      /// Deleting the order from the orders collection
      await _firestore.collection('orders').doc(orderID).delete();

      /// Adding the order to the completedOrders collection
      await _firestore
          .collection('completedOrders')
          .doc(orderID)
          .set(orderData);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  /// Get completedOrders
  Stream<List<Map<String, dynamic>>> getCompletedOrders() {
    return _firestore
        .collection('completedOrders')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }
}
