import 'package:flutter/material.dart';
import 'package:miagedv1/pages/cart/cart_item.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0.0;
    _items.forEach((item) {
      final itemPrice = double.parse(item.price.replaceAll(RegExp(r'[^0-9.,]'), '').replaceAll(',', '.').replaceAll('\$', ''));
      total += itemPrice * item.quantity;
    });
    return total;
  }


  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(String name) {
    _items.removeWhere((item) => item.name == name);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
