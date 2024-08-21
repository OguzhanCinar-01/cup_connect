import 'package:flutter/material.dart';

class Order {
  Order({
    required this.productName,
    this.syrup,
    this.size,
    required this.price,

    this.orderID,
    this.orderDate,
    this.orderTime,
    this.orderStatus,
  });

  final String productName;
  final String? syrup;
  final String? size;
  final double price;

  final String? orderID;
  final DateTime? orderDate;
  final DateTime? orderTime;
  final String? orderStatus;
}

class OrderViewModel extends ChangeNotifier {
  List<Order> orders = [];

  void addOrder(Order order) {
    orders.add(order);
    notifyListeners();
  }

  void removeOrder(Order order) {
    orders.remove(order);
    notifyListeners();
  }
}
