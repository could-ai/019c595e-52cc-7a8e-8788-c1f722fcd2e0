import 'package:flutter/material.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    String selectedFlavor = product.flavors[0];
    String selectedSize = product.sizes[0];
    String selectedPack = product.packs[0];

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(product.description),
            const SizedBox(height: 16),
            Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, color: Colors.green)),
            const SizedBox(height: 16),
            // Flavor selection
            const Text('Flavor:', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedFlavor,
              items: product.flavors.map((flavor) {
                return DropdownMenuItem(value: flavor, child: Text(flavor));
              }).toList(),
              onChanged: (value) => selectedFlavor = value!,
            ),
            // Size selection
            const Text('Size:', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedSize,
              items: product.sizes.map((size) {
                return DropdownMenuItem(value: size, child: Text(size));
              }).toList(),
              onChanged: (value) => selectedSize = value!,
            ),
            // Pack selection
            const Text('Pack:', style: TextStyle(fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedPack,
              items: product.packs.map((pack) {
                return DropdownMenuItem(value: pack, child: Text(pack));
              }).toList(),
              onChanged: (value) => selectedPack = value!,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                final cartItem = CartItem(
                  product: product,
                  selectedFlavor: selectedFlavor,
                  selectedSize: selectedSize,
                  selectedPack: selectedPack,
                );
                context.read<CartProvider>().addToCart(cartItem);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to cart!')),
                );
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}