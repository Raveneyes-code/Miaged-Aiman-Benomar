import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:miagedv1/pages/cart/cart_item.dart';
import 'package:miagedv1/pages/cart/cart_provider.dart';
import 'package:miagedv1/pages/home_page.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final DocumentSnapshot product;

  const ProductDetailsPage(this.product);

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.product['name']),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.network(widget.product['image']),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Brand: ${widget.product['brand']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Price: ${widget.product['price']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Size: ${widget.product['sizes']}',
            ),
            const SizedBox(height: 10.0),
            Text(
              'Title: ${widget.product['Title']}',
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_quantity > 1) {
                        _quantity--;
                      }
                    });
                  },
                  icon: Icon(Icons.remove),
                ),
                const SizedBox(width: 10.0),
                Text(
                  '$_quantity',
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10.0),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _quantity++;
                    });
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  addToCart(widget.product, _quantity);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
                child: const Text('Add to Cart'),
              ),

            ),
          ],
        ),
      ),
    );
  }

  void addToCart(DocumentSnapshot product, int quantity) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final cartItem = CartItem(
      name: product['name'],
      image: product['image'],
      quantity: quantity,
      price: product['price'],
    );
    cartProvider.addItem(cartItem);
    debugPrint("added");
  }

}
