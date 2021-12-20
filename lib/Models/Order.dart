import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:plant_app/Models/Cart.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> plantsToBeShipped;
  final String timing;
  OrderItem({this.id, this.amount, this.plantsToBeShipped, this.timing});
}

class Orders with ChangeNotifier {
  Orders(this.OrderToken, this.userId, this._orders);
  final String OrderToken;
  final String userId;

  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://shopappfirebase-50d2e-default-rtdb.firebaseio.com/orders/$userId.json?auth=$OrderToken';
    final response = await http.get(Uri.parse(url));
    final List<OrderItem> loadedOrders = [];

    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          timing: orderData['timing'],
          plantsToBeShipped: (orderData['Plants'] as List<dynamic>)
              .map((e) => CartItem(
                  id: e['id'],
                  title: e['title'],
                  quantity: e['quantity'],
                  price: e['price'],
                  ImageUrl: e['imageUrl']))
              .toList()));
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url =
        'https://shopappfirebase-50d2e-default-rtdb.firebaseio.com/orders/$userId.json?auth=$OrderToken';
    final timeStamp = DateTime.now();
    final response = await http.post(Uri.parse(url),
        body: json.encode({
          'amount': total,
          'timing': timeStamp.toIso8601String(),
          'Plants': cartProducts
              .map((plant) => {
                    'id': plant.id,
                    'title': plant.title,
                    'price': plant.price,
                    'quantity': plant.quantity,
                    'imageUrl': plant.ImageUrl
                  })
              .toList()
        }));
    // print(response.statusCode);
    // print(userId);
    // print(OrderToken);
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            plantsToBeShipped: cartProducts,
            timing: DateTime.now().toString()));
    notifyListeners();
  }
}
