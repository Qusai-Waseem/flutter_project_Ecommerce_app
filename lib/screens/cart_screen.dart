import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/sh_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shopProvider = Provider.of<ShopProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: shopProvider.cartItems.isEmpty
                ? const Center(
                    child: Text('Cart Is Empty'),
                  )
                : ListView.builder(
                    itemCount: shopProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      final product = shopProvider.cartItems[index];

                      return ListTile(
                        leading: Image.network(
                          product.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(product.title),
                        subtitle: Text('\$${product.price}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            shopProvider.removeFromCart(product);
                          },
                        ),
                      );
                    },
                  ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Total: \$${shopProvider.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}