import 'package:flutter/material.dart';
import '../models/product.dart';

class CartItem {
  final Product product;
  final String selectedFlavor;
  final String selectedSize;
  final String selectedPack;
  final int quantity;

  CartItem({
    required this.product,
    required this.selectedFlavor,
    required this.selectedSize,
    required this.selectedPack,
    this.quantity = 1,
  });

  double get totalPrice => product.price * quantity;
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalPrice => _items.fold(0, (sum, item) => sum + item.totalPrice);

  void addToCart(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeFromCart(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}