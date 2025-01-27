import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String _token = '';
  int _expires = 0;
  late Timer timer;
  bool get isAuth {
    return _token.isNotEmpty;
  }

  Future<void> _authentication(
      String email, String password, String type) async {
    const url = 'https://apiforlearning.zendvn.com/api/auth/login';

    try {
      final respone = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {"email": email, "password": password},
        ),
      );

      final responeData = jsonDecode(respone.body);
      _token = responeData['access_token'];
      // get time for token
      _expires = responeData['expires_in'];
      DateTime timeNow = DateTime.now();
      DateTime timeExpires = timeNow.add(Duration(seconds: _expires));
      startTokenTimer(timeExpires);
      notifyListeners();
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();
      final userData = jsonEncode({'token': _token , 'expires': timeExpires.toIso8601String()});
      await prefs.setString('userData', userData);
    } catch (e) {
      print(e);
    }
  }

  void login(String email, String password) {
    _authentication(email, password, 'login');
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final data = jsonDecode(prefs.getString('userData') ?? '');
    DateTime expires = DateTime.parse(data['expires']);
    startTokenTimer(expires);
    return true;
  }

  void logout() async {
    _token = '';
    _expires = 0;
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    notifyListeners();
    stopTokenTimer();
  }

  Future<void> checkTimeExpires() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonDecode(prefs.getString('userData') ?? '');
    DateTime expires = DateTime.parse(data['expires']);
    if (DateTime.now().isAfter(expires)) {
      // het thoi han
      logout();
    }
  }

  void startTokenTimer(DateTime timeExpires){
    var timeUntil = timeExpires.difference(DateTime.now());
    timer = Timer(timeUntil,checkTimeExpires);
  }

  void stopTokenTimer(){
    timer.cancel();
  }
}
