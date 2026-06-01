import 'package:flutter/material.dart';

import '../data/dummyproducts.dart';
import '../models/product.dart';

class ShopProvider extends ChangeNotifier {
  // جميع المنتجات
  final List<Product> _products = dummyProducts;

  // منتجات السلة
  final List<Product> _cartItems = [];

  // Getter للمنتجات
  List<Product> get products => _products;

  // Getter للسلة
  List<Product> get cartItems => _cartItems;

  // Getter للمفضلة
  List<Product> get favoriteItems =>
      _products.where((product) => product.isFavorite).toList();

  // إضافة أو إزالة من المفضلة
  void toggleFavorite(Product product) {
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }

  // إضافة للسلة
  void addToCart(Product product) {
    if (!_cartItems.contains(product)) {
      _cartItems.add(product);
      notifyListeners();
    }
  }

  // حذف من السلة
  void removeFromCart(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  // حساب السعر الإجمالي
  double get totalPrice {
    double total = 0;

    for (var product in _cartItems) {
      total += product.price;
    }

    return total;
  }
}