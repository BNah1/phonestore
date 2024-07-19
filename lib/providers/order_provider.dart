import 'package:flutter/cupertino.dart';

class OrderProvider extends ChangeNotifier {

  Future<void> buy (Map<int,dynamic> items) async {
    print(items);
  }

}