class CartItem {
  final String name;
  final String image;
  final int quantity;
  final String price;

  CartItem({
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
  });

  CartItem copyWith({
    String? name,
    String? image,
    int? quantity,
    String? price,
  }) {
    return CartItem(
      name: name ?? this.name,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  // Define a getter for productName
  String get productName => name;
}
