import 'package:flutter/material.dart';

class Product {
  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.coffeeSize,
  });

  final String name;
  final String description;
  final double price;
  final String imagePath;
  final String coffeeSize;
}

class ProductViewModel with ChangeNotifier {
  Product? _selectedProduct;

  Product? get selectedProduct => _selectedProduct;

  void selectProduct(Product product) {
    _selectedProduct = product;
    notifyListeners();
  }
}
