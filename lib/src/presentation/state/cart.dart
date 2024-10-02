import 'package:flutter/material.dart';
import 'package:shopping_cart/src/domain/domain.dart';

class Cart extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;

  void addItem(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void removeItem(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  bool isProductInCart(Product product) {
    return _items.contains(product);
  }

  void toggleProduct(Product product) {
    if (isProductInCart(product)) {
      _items.remove(product);
    } else {
      _items.add(product);
    }
    notifyListeners();
  }

  double calculateTotal() {
    return _items.fold(0.0, (total, product) => total + product.price);
  }
}
