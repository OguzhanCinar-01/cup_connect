import 'package:flutter/material.dart';

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

  /// Set syrup for the order
  void setSyrup(Order order, String syrup) {
    order.syrup = syrup;
    notifyListeners();
  }
}
