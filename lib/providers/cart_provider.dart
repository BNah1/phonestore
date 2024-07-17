import 'package:flutter/foundation.dart';

class CartItem {
  final int id;
  final String image;
  final String name;
  final int price;
  int quantity;
  String summary;

  CartItem(
      {required this.id,
      required this.image,
      required this.name,
      required this.price,
      required this.quantity,
      required this.summary});
}

class CartProvider extends ChangeNotifier {
  Map<int, CartItem> items = {};

  void addCart(
      int productId, String image, String name, int price, int quantity, String summary) {
    if (items.containsKey(productId)) // da ton tai san pham
    {
      items.update(
          productId,
          (value) => CartItem(
              id: value.id,
              image: value.image,
              name: value.name,
              price: value.price,
              quantity: value.quantity + quantity,
              summary: value.summary));
      notifyListeners();
    } else {
      items.putIfAbsent(
          productId,
          () => CartItem(
              id: productId,
              image: image,
              name: name,
              price: price,
              quantity: quantity,
              summary: summary));
      notifyListeners();
    }
  }
}