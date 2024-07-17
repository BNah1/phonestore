import 'package:flutter/material.dart';
import 'package:onlineappstore/page/category/widget/category_body.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);
  static const routerName = '/category';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cac san pham ' + arg['name']),
      ),
      body: CategoryBody(),
    );
  }
}
