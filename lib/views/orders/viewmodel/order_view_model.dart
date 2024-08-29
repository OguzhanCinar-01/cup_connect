import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Order {
  Order({
    required this.productName,
    this.syrup = 'Classic',
    this.size,
    required this.price,
    this.orderID,
    this.orderDate,
    this.orderTime,
    this.orderStatus,
    this.quantity = 1,
    this.userId,
  });

  final String productName;
  final String? userId;
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
      notifyListeners();
    } catch (e) {
      rethrow;
    }

    // Update the status of the order
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
      String orderId, Map<String, dynamic> order) async {
    try {
      await _firestore.collection('completed_orders').doc(orderId).set(order);
    } catch (e) {
      print('Error adding to completedOrders: $e');
      rethrow;
    }
  }

  /// Get completedOrders
  Future<List<Map<String, dynamic>>> getCompletedOrders() {
    try {
      return _firestore.collection('completedOrders').get().then(
          (querySnapshot) =>
              querySnapshot.docs.map((doc) => doc.data()).toList());
    } catch (e) {
      rethrow;
    }
  }

  /// Delete order
  Future<void> deleteOrder(String orderID) async {
    try {
      await _firestore.collection('orders').doc(orderID).delete();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  // Fetch orders for a specific user
  Future<void> fetchOrdersByUserId(String userId) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('orders')
          .where('userId', isEqualTo: userId)
          .get();

      orders = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Order(
          productName: data['productName'],
          syrup: data['syrup'],
          size: data['size'],
          price: data['price'],
          orderID: data['orderID'],
          orderDate: DateFormat('dd/MM/yyyy').parse(data['orderDate']),
          orderTime: DateFormat('HH:mm').parse(data['orderTime']),
          orderStatus: data['orderStatus'],
          quantity: data['quantity'],
          userId: userId,
        );
      }).toList();
      notifyListeners();
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }



  /// Get userId from firestore
  Future<String?> getUserId(String email) async {
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user ID: $e');
      return null;
    }
  }
}
