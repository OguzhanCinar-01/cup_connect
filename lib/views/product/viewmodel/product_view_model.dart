import 'package:flutter/material.dart';

class Product {
  Product({
    required this.name,
    required this.description,
    required this.basePrice,
    required this.imagePath,
    required this.coffeeSize,
    required this.syrup,
    this.sizePrices = const {
      'Small': 0.0,
      'Medium': 2.0,
      'Large': 3.0,
    },
  });

  final String name;
  final String description;
  final double basePrice;
  final String imagePath;
  String coffeeSize;
  String syrup;
  final Map<String, double> sizePrices;

  double get price {
    return basePrice + (sizePrices[coffeeSize] ?? 0.0);
  }
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
