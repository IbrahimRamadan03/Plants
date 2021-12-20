import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String ImageUrl;
  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
    @required this.ImageUrl,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get TotalAmount {
    double total = 0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void addItem(String plantId, double price, String title,String imageUrl) {
    if (_items.containsKey(plantId)) {
      _items.update(
          plantId,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              price: value.price,
              quantity: value.quantity + 1,
              ImageUrl:value.ImageUrl
              ));
    } else {
      _items.putIfAbsent(
          plantId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              quantity: 1,
              price: price,
              ImageUrl:imageUrl 
              ));
    }
    notifyListeners();
  }

  void deletedItem(String plantId) {
    _items.remove(plantId);
    notifyListeners();
  }

  void removeSingelItem(String plantId) {
    if (!_items.containsKey(plantId)) {
      return;
    }
    if (_items[plantId].quantity > 1) {
      _items.update(
          plantId,
          (value) => CartItem(
              id: value.id,
              title: value.title,
              quantity: (value.quantity) - 1,
              price: value.price,
              ImageUrl:value.ImageUrl 
              ));
    }
    else{
      _items.remove(plantId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
