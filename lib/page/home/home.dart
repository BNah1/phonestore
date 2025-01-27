import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineappstore/page/auth/auth_page.dart';
import 'package:onlineappstore/page/cart/cart.dart';
import 'package:onlineappstore/page/home/widget/homecategory.dart';
import 'package:onlineappstore/page/product/playlistproduct.dart';
import 'package:onlineappstore/providers/auth_provider.dart';
import 'package:onlineappstore/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import '../../config/const.dart';
import '../order/list_order.dart';
import 'widget/homeslider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const routerName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    Provider.of<AuthProvider>(context).checkTimeExpires();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return auth.isAuth
            ? Home()
            : FutureBuilder(
                future: auth.autoLogin(),
                initialData: false,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return snapshot.data ? const Home() : AuthPage();
                },
              );
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping mall', style: styleTileAppbar,),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Consumer<CartProvider>(
              builder: (context , value , child){
                return badges.Badge(
                  badgeContent: Text('${value.items.length}'),
                  position: badges.BadgePosition.topEnd(top: -15, end: -7),
                  child: InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, CartPage.routerName);
                    },
                    child: Icon(Icons.shopping_cart),
                  ),
                );
              }
            )
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              HomeSlider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Danh muc san pham',
                      style: styleTileItem,
                    ),
                    Text('so luong (4)'),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              HomeCategory(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'San pham noi bat',
                      style: styleTileItem,
                    ),
                    Text('so luong (4)'),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              PlaylistProduct(),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          color: Colors.grey,
          child: Column(
            children: [
              Container(
                height: 80,
                width: 80,
                child: Image(
                  image: AssetImage('assets/images/logi.webp'),
                ),
              ),
              Text('xxx'),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.home),
                        title: Text('Home'),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: Icon(Icons.library_add_check),
                        title: Text('Don hang da mua'),
                        onTap: () {
                          Navigator.popAndPushNamed(context, ListOrder.routerName);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.logout),
                        title: Text('Logout'),
                        onTap: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .logout();
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
