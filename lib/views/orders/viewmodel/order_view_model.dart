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
      print('Error submitting order: $e');
    }
  }

  /// Get fetch orders
  /*Future<void> fetchOrders() async {
    final firestore = FirebaseFirestore.instance;

    try {
      QuerySnapshot snapshot = await firestore.collection('orders').get();

      orders = snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return Order(
          productName: data['productName'] ?? 'No product name found',
          syrup: data['syrup'] ?? 'No syrup found',
          size: data['size'] ?? 'No size found',
          price: data['price'] ?? 0.0,
          orderID: data['orderID'] ?? 'No order ID found',
          orderDate: data['orderDate'] ?? 'No order date found',
          orderTime: data['orderTime'] ?? 'No order time found',
          orderStatus: data['orderStatus'] ?? 'No order status found',
          quantity: data['quantity'] ?? 0,
        );
      }).toList();

      notifyListeners();
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }*/
}
