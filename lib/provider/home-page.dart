import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
  });
}

class Products with ChangeNotifier {
  final String authToken;
  final String userId;

  Products(this.authToken, this.userId, this._items);
  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }
}
