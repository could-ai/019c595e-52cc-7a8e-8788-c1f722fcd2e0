import 'package:flutter/material.dart';
import '../models/product.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  outForDelivery,
  delivered,
}

class Order {
  final String id;
  final List<CartItem> items;
  final DateTime deliveryDateTime;
  final String paymentMethod;
  final OrderStatus status;
  final String trackingId;

  Order({
    required this.id,
    required this.items,
    required this.deliveryDateTime,
    required this.paymentMethod,
    this.status = OrderStatus.pending,
    required this.trackingId,
  });

  double get totalPrice => items.fold(0, (sum, item) => sum + item.totalPrice);
}

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  // Mock current order for tracking
  Order? get currentOrder => _orders.isNotEmpty ? _orders.last : null;

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  void updateOrderStatus(String orderId, OrderStatus status) {
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      _orders[index] = Order(
        id: _orders[index].id,
        items: _orders[index].items,
        deliveryDateTime: _orders[index].deliveryDateTime,
        paymentMethod: _orders[index].paymentMethod,
        status: status,
        trackingId: _orders[index].trackingId,
      );
      notifyListeners();
    }
  }
}