import 'package:flutter/material.dart';

class Product {
  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.coffeeSize,
    required this.syrup,
  });

  final String name;
  final String description;
  final double price;
  final String imagePath;
  String coffeeSize;
  String syrup;
}

class ProductViewModel with ChangeNotifier {
  Product? _selectedProduct;

  Product? get selectedProduct => _selectedProduct;

  void selectProduct(Product product) {
    _selectedProduct = product;
    notifyListeners();
  }

  /// Update the product size
  void updateProductSize(String size) {
    if (_selectedProduct != null) {
      _selectedProduct!.coffeeSize = size;
      notifyListeners();
    }
  }

  /// Update the product syrup
  void updateProductSyrup(String syrup) {
    if (_selectedProduct != null) {
      _selectedProduct!.syrup = syrup;
      notifyListeners();
    }
  }
}
