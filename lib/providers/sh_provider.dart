
  import 'package:flutter/material.dart';
import '../services/api_serv.dart';
import 'package:flutterhwnumber2/services/fav_storage.dart';
import '../models/product.dart';

class ShopProvider extends ChangeNotifier {
  ShopProvider(){
    fetchProducts();
    //loadFavoritesFromFile();
  }
  // All products loaded from dummy data
   List<Product> _products = [];
   bool _isLoading = false;
   bool get isLoading => _isLoading;

  // Products added to cart
  final List<Product> _cartItems = [];

  // Tracks quantity for each cart item. Key = product id, Value = quantity
  final Map<int, int> _cartQuantities = {};

  // --- Getters ---

  List<Product> get products => _products;

  List<Product> get cartItems => _cartItems;

  // Only return products where isFavorite is true
  List<Product> get favoriteItems =>
      _products.where((product) => product.isFavorite).toList();

  // Total number of items in cart (counts quantities too, useful for badge)
  int get cartItemCount {
    int count = 0;
    for (var qty in _cartQuantities.values) {
      count += qty;
    }
    return count;
  }

  // --- Favorites ---

  // Toggle favorite on/off
  void toggleFavorite(Product product) {
    product.isFavorite = !product.isFavorite;
    saveFavoritesToFile();
    notifyListeners();
  }

  // --- Cart ---

  // Add to cart. If already in cart, increase quantity instead of adding again
  void addToCart(Product product) {
    if (!_cartItems.contains(product)) {
      _cartItems.add(product);
      _cartQuantities[product.id] = 1;
    } else {
      _cartQuantities[product.id] = (_cartQuantities[product.id] ?? 1) + 1;
    }
    notifyListeners();
  }

  // Remove product completely from cart
  void removeFromCart(Product product) {
    _cartItems.remove(product);
    _cartQuantities.remove(product.id);
    notifyListeners();
  }

  // Increase quantity for a cart item
  void increaseQuantity(Product product) {
    _cartQuantities[product.id] = (_cartQuantities[product.id] ?? 1) + 1;
    notifyListeners();
  }

  // Decrease quantity. If it reaches 0, remove from cart automatically
  void decreaseQuantity(Product product) {
    final current = _cartQuantities[product.id] ?? 1;
    if (current <= 1) {
      removeFromCart(product);
    } else {
      _cartQuantities[product.id] = current - 1;
      notifyListeners();
    }
  }

  // Get quantity for a specific product in cart
  int getQuantity(Product product) {
    return _cartQuantities[product.id] ?? 1;
  }

  // Calculate total price (price * quantity for each item)
  double get totalPrice {
    double total = 0;
    for (var product in _cartItems) {
      total += product.price * (_cartQuantities[product.id] ?? 1);
    }
    return total;
  }

  Future<void> fetchProducts() async {
    try {
      _isLoading = true;
      notifyListeners();
      _products = await ApiService().fetchProducts();
      await loadFavoritesFromFile();

    
    } catch (e) {

      debugPrint('Error fetching products: $e.toString()');
    }finally {
      _isLoading = false;
      notifyListeners();
    }

    






  }
  Future<void> saveFavoritesToFile() async {
  final favorites =
      _products.where((product) => product.isFavorite).toList();

  await FavoritesStorage.saveFavorites(favorites);
}

Future<void> loadFavoritesFromFile() async {
  final savedFavorites = await FavoritesStorage.loadFavorites();

  for (var savedProduct in savedFavorites) {
    for (var product in _products) {
      if (product.id == savedProduct.id) {
        product.isFavorite = true;
      }
    }
  }

  notifyListeners();
  }

}
  



  
