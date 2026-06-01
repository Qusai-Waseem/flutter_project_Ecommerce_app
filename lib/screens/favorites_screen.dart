import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/sh_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shopProvider = Provider.of<ShopProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: shopProvider.favoriteItems.isEmpty
          ? const Center(
              child: Text('No Favorite Products'),
            )
          : ListView.builder(
              itemCount: shopProvider.favoriteItems.length,
              itemBuilder: (context, index) {
                final product = shopProvider.favoriteItems[index];

                return ListTile(
                  leading: Image.asset(
                    product.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.title),
                  subtitle: Text('\$${product.price}'),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      shopProvider.toggleFavorite(product);
                    },
                  ),
                );
              },
            ),
    );
  }
}