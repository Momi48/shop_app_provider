import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<Map<String, dynamic>> cart = [];
  List<Map<String, dynamic>> favourite = [];

  void addCartProducts(Map<String, dynamic> product) {
    cart.add(product);
    notifyListeners();
  }

  void removeCartProducts(Map<String, dynamic> product) {
    cart.remove(product);
    notifyListeners();
  }

  void addFavoriteProduct(Map<String, dynamic> product) {
    favourite.add(product);

    notifyListeners();
  }

  void removeFavoriteProduct(Map<String, dynamic> product) {
    favourite.removeWhere((item) => item['title'] == product['title']);
    notifyListeners();
  }

  bool isFavorite(String title) {
    return favourite.any((item) => item['title'] == title);
  }
}
