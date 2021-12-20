import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:plant_app/Models/Plants.dart';

//Data Model
class Plant with ChangeNotifier {
  final String title;
  final String id;
  final double price;
  final String description;
  final String imageUrl;

  bool isFavourite = false;
  Plant(
      {this.title,
      this.id,
      this.price,
      this.description,
      this.imageUrl,
      this.isFavourite});
  void toggleFavourite(String id) {
    isFavourite = !isFavourite;
  
    final url =
        'https://shopappfirebase-50d2e-default-rtdb.firebaseio.com/products/$id.json';
    http.patch(Uri.parse(url), body: json.encode({'isFavourite': isFavourite}));
    
    notifyListeners();
    
  }

  Future<void> getFavData(String id) async {
    final url =
        'https://shopappfirebase-50d2e-default-rtdb.firebaseio.com/products/$id.json';
    final response = await http.get(Uri.parse(url));
    final extractedFav = json.decode(response.body) as Map<String, dynamic>;
    print(extractedFav);
    final result=extractedFav['isFavourite'];
    isFavourite=result;
  }
}
