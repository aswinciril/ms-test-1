import 'package:flutter/material.dart';

class CartCountProvider extends ChangeNotifier {
  int _cartCount = 0;

  int get cartCount => _cartCount;

  void increment() {
    _cartCount++;
    notifyListeners();
  }

  void decrement() {
    if (_cartCount > 0) {
      _cartCount--;
      notifyListeners();
    }
  }
}
