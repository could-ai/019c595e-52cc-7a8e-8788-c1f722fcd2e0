import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay selectedTime = const TimeOfDay(hour: 10, minute: 0);
  String paymentMethod = 'Online Payment';

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final orderProvider = context.read<OrderProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Schedule Delivery', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text('Date: ${DateFormat.yMMMd().format(selectedDate)}'),
                ),
                TextButton(
                  onPressed: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                    );
                    if (date != null) setState(() => selectedDate = date);
                  },
                  child: const Text('Select Date'),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text('Time: ${selectedTime.format(context)}'),
                ),
                TextButton(
                  onPressed: () async {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: selectedTime,
                    );
                    if (time != null) setState(() => selectedTime = time);
                  },
                  child: const Text('Select Time'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text('Payment Method', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: paymentMethod,
              items: ['Online Payment', 'Cash on Delivery'].map((method) {
                return DropdownMenuItem(value: method, child: Text(method));
              }).toList(),
              onChanged: (value) => setState(() => paymentMethod = value!),
            ),
            const SizedBox(height: 32),
            const Text('Order Summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...cart.items.map((item) => ListTile(
              title: Text(item.product.name),
              subtitle: Text('${item.selectedFlavor} - ${item.selectedSize} - ${item.selectedPack}'),
              trailing: Text('\$${item.totalPrice.toStringAsFixed(2)}'),
            )),
            const Divider(),
            Text('Total: \$${cart.totalPrice.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final orderDateTime = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
                final order = Order(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  items: List.from(cart.items),
                  deliveryDateTime: orderDateTime,
                  paymentMethod: paymentMethod,
                  trackingId: 'TRK${DateTime.now().millisecondsSinceEpoch}',
                );
                orderProvider.addOrder(order);
                cart.clearCart();
                Navigator.pushNamed(context, '/tracking');
              },
              child: const Text('Place Order'),
            ),
          ],
        ),
      ),
    );
  }
}