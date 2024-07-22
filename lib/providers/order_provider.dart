import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderProvider extends ChangeNotifier {
  Future<bool> buy(Map<int, dynamic> items) async {
    const url = 'https://apiforlearning.zendvn.com/api/mobile/orders/save';
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonDecode(prefs.getString('userData') ?? '');
    final token = userData['token'];

    var data = [];
    items.forEach((key, value) {
      data.add({"product_id": key, "quantity": value.quantity});
    });

    try {
      final respone = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'bearer $token',
          },
          body: jsonEncode({'data': data}));
      if(respone.statusCode != 201){
        return false;
      }
      else{
        return true;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List> getListOrderCart() async {
    const url = 'https://apiforlearning.zendvn.com/api/mobile/orders';
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonDecode(prefs.getString('userData') ?? '');
    final token = userData['token'];

    try {
      final respone = await http.get(Uri.parse(url),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'bearer $token',
          },);
      if(respone.statusCode == 200){
        return jsonDecode(respone.body);
      }
      return [];
    } catch (e) {
      return Future.error(e);
    }
  }
}
