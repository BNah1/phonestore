import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> productSpecial = [];


  Future<List<Product>> getProDuctSpecial() async {
    final url =
        'https://apiforlearning.zendvn.com/api/mobile/products?offset=0&sortBy=id&order=asc&special=true';
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);
      List<Product> data = List<Product>.from(
          jsonData.map((pro) => Product.fromJson(jsonEncode((pro))))).toList();
      productSpecial = data;
      return productSpecial;
    } catch (e) {
      return Future.error(Exception('NoData'));
    }
  }

  Future<Product> getProduct(String id) async {
    final url =
        'https://apiforlearning.zendvn.com/api/mobile/products/$id';
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);
      Product product = Product.fromJson(jsonEncode(jsonData));
      return product;
    } catch (e) {
      return Future.error(Exception('NoData'));
    }
  }


}