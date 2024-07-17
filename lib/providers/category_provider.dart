import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/category_model.dart';
import '../model/product_model.dart';

class CategoryProvider extends ChangeNotifier {
  Future<List<Category>> getCategory() async {
    final url = 'https://apiforlearning.zendvn.com/api/mobile/categories';
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);
      List<Category> data = List<Category>.from(
              jsonData.map((cate) => Category.fromJson(jsonEncode((cate)))))
          .toList();
      return data;
    } catch (e) {
      return Future.error(Exception('NoData'));
    }
  }

  Future<List<Product>> getProDuctCategory(int id) async {
    final url =
        'https://apiforlearning.zendvn.com/api/mobile/categories/$id/products';
    try {
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);
      List<Product> data = List<Product>.from(
          jsonData.map((pro) => Product.fromJson(jsonEncode((pro))))).toList();
      return data;
    } catch (e) {
      return Future.error(Exception('NoData'));
    }
  }
}
