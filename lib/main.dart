import 'package:flutter/material.dart';
import 'package:onlineappstore/page/auth/auth_page.dart';
import 'package:onlineappstore/page/cart/cart.dart';
import 'package:onlineappstore/page/category/category.dart';
import 'package:onlineappstore/page/home/home.dart';
import 'package:onlineappstore/page/order/list_order.dart';
import 'package:onlineappstore/page/product/product.dart';
import 'package:onlineappstore/providers/auth_provider.dart';
import 'package:onlineappstore/providers/cart_provider.dart';
import 'package:onlineappstore/providers/category_provider.dart';
import 'package:onlineappstore/providers/order_provider.dart';
import 'package:onlineappstore/providers/product_provider.dart';
import 'package:onlineappstore/providers/slider_provider.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SliderProvider()),
          ChangeNotifierProvider(create: (_) => CategoryProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => OrderProvider()),
        ],
        child: Consumer<AuthProvider>(
          builder: (context, auth, child) {
            print(auth.isAuth);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: HomePage.routerName,
              routes: {
                HomePage.routerName: (context) => const HomePage(),
                CategoryPage.routerName: (context) => const CategoryPage(),
                ProductPage.routerName: (context) => const ProductPage(),
                AuthPage.routerName: (context) => AuthPage(),
                CartPage.routerName: (context) => CartPage(),
                ListOrder.routerName: (context) => ListOrder(),
              },
            );
          },
        )),
  );
}
