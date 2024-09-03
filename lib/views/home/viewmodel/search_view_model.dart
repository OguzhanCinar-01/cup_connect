import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier{
  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  set searchQuery(String value){
    _searchQuery = value;
    notifyListeners();
  }

}