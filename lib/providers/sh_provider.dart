
  import 'package:flutter/material.dart';
import '../services/api_serv.dart';
import 'package:flutterhwnumber2/services/fav_storage.dart';
import '../models/product.dart';

class ShopProvider extends ChangeNotifier {
  ShopProvider(){
    fetchProducts();
    //loadFavoritesFromFile();
  }
  // All products 

   List<Product> _products = [];
   bool _isLoading = false;
   bool get isLoading => _isLoading;

  //  added to cart
  final List<Product> _cartItems = [];

  // Tracks quantity 
  final Map<int, int> _cartQuantities = {};

  // Getters 

  List<Product> get products => _products;

  List<Product> get cartItems => _cartItems;

  
  List<Product> get favoriteItems =>
      _products.where((product) => product.isFavorite).toList();

  // Total number of items 
  int get cartItemCount {
    int count = 0;
    for (var qty in _cartQuantities.values) {
      count += qty;
    }
    return count;
  }

  // favorites

  // toggle favorite on and off
  void toggleFavorite(Product product) {
    product.isFavorite = !product.isFavorite;
    saveFavoritesToFile();
    notifyListeners();
  }

  // Cart

  // add to cart
  void addToCart(Product product) {
    if (!_cartItems.contains(product)) {
      _cartItems.add(product);
      _cartQuantities[product.id] = 1;
    } else {
      _cartQuantities[product.id] = (_cartQuantities[product.id] ?? 1) + 1;
    }
    notifyListeners();
  }

  // remove from cart
  void removeFromCart(Product product) {
    _cartItems.remove(product);
    _cartQuantities.remove(product.id);
    notifyListeners();
  }

  // increase quantity
  void increaseQuantity(Product product) {
    _cartQuantities[product.id] = (_cartQuantities[product.id] ?? 1) + 1;
    notifyListeners();
  }

  // decrease quantity
  void decreaseQuantity(Product product) {
    final current = _cartQuantities[product.id] ?? 1;
    if (current <= 1) {
      removeFromCart(product);
    } else {
      _cartQuantities[product.id] = current - 1;
      notifyListeners();
    }
  }

  // get quantity 
  int getQuantity(Product product) {
    return _cartQuantities[product.id] ?? 1;
  }

  // calculate price 
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
  //favorites storage to save in flie
  //
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
  



  
