class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> flavors;
  final List<String> sizes;
  final List<String> packs;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.flavors,
    required this.sizes,
    required this.packs,
  });

  // Mock data
  static List<Product> mockProducts = [
    Product(
      id: '1',
      name: 'Vanilla Delight',
      description: 'Classic vanilla ice cream made with fresh Madagascar vanilla beans.',
      price: 4.99,
      imageUrl: 'https://via.placeholder.com/300x200?text=Vanilla+Ice+Cream',
      flavors: ['Vanilla'],
      sizes: ['Small', 'Medium', 'Large'],
      packs: ['Single', 'Family Pack'],
    ),
    Product(
      id: '2',
      name: 'Chocolate Heaven',
      description: 'Rich Belgian chocolate ice cream with chocolate chunks.',
      price: 5.49,
      imageUrl: 'https://via.placeholder.com/300x200?text=Chocolate+Ice+Cream',
      flavors: ['Chocolate'],
      sizes: ['Small', 'Medium', 'Large'],
      packs: ['Single', 'Family Pack'],
    ),
    Product(
      id: '3',
      name: 'Strawberry Fields',
      description: 'Fresh strawberry ice cream made with real strawberries.',
      price: 4.99,
      imageUrl: 'https://via.placeholder.com/300x200?text=Strawberry+Ice+Cream',
      flavors: ['Strawberry'],
      sizes: ['Small', 'Medium', 'Large'],
      packs: ['Single', 'Family Pack'],
    ),
  ];
}