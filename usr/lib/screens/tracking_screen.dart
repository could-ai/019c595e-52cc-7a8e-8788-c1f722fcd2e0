import 'package:flutter/material.dart';
import '../providers/order_provider.dart';
import 'package:provider/provider.dart';

class TrackingScreen extends StatelessWidget {
  const TrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = context.watch<OrderProvider>();
    final order = orderProvider.currentOrder;

    if (order == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Delivery Tracking')),
        body: const Center(child: Text('No active order to track')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Delivery Tracking')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order #${order.id}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Tracking ID: ${order.trackingId}'),
            const SizedBox(height: 16),
            const Text('Status:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(order.status.toString().split('.').last.toUpperCase()),
            const SizedBox(height: 16),
            const Text('Delivery Timeline:', style: TextStyle(fontWeight: FontWeight.bold)),
            _buildStatusTimeline(order.status),
            const SizedBox(height: 32),
            const Text('Live Tracking Map', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Container(
              height: 200,
              color: Colors.grey[300],
              child: const Center(child: Text('Map Placeholder - Driver Location & Route')),
            ),
            const SizedBox(height: 16),
            const Text('ETA Countdown', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.blue[50],
              child: const Text('Estimated Time: 2 hours 15 minutes', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTimeline(OrderStatus status) {
    final statuses = [
      'Order Placed',
      'Confirmed',
      'Preparing',
      'Out for Delivery',
      'Delivered',
    ];
    final currentIndex = status.index;

    return Column(
      children: statuses.asMap().entries.map((entry) {
        final index = entry.key;
        final statusText = entry.value;
        return Row(
          children: [
            Icon(
              index <= currentIndex ? Icons.check_circle : Icons.circle_outlined,
              color: index <= currentIndex ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(statusText),
          ],
        );
      }).toList(),
    );
  }
}