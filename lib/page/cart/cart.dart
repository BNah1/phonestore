import 'package:intl/intl.dart' as intl;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:onlineappstore/config/const.dart';
import 'package:onlineappstore/providers/cart_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  static const routerName = '/cart';

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My cart'),
      ),
      body: Stack(children: [
         Consumer<CartProvider>(
           builder: (context, value , child){
             var data = value.items.values.toList();
             return ListView.separated(
                 itemBuilder: (BuildContext context, int index) {
                   return Container(
                       height: 100,
                       color: Colors.black12,
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Expanded(
                             flex: 2,
                             child: Container(
                               padding: EdgeInsets.all(5),
                               child: Image(
                                 image: NetworkImage(data[index].image),
                               ),
                             ),
                           ),
                           Expanded(
                             flex: 3,
                             child: Padding(
                               padding: EdgeInsets.only(top: 5),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(data[index].name, style: TextStyle(
                                     color: Colors.black,
                                     fontSize: 17,
                                     fontWeight: FontWeight.bold,
                                   )),
                                   Text(data[index].summary.toString()),
                                   SizedBox(height: 10,),
                                   Text('Tổng giá tiền', style: styleTileItem,),
                                   Expanded(flex: 2, child: Text(intl.NumberFormat.simpleCurrency(locale: 'vi',decimalDigits: 3).format(data[index].price * data[index].quantity),style: TextStyle(fontSize: 15),)),
                                 ],
                               ),
                             ),
                           ),
                           Expanded(
                               flex: 2,
                               child: Center(
                                 child: Row(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     SizedBox(
                                       height: 30,
                                       width: 30,
                                       child: OutlinedButton(
                                         onPressed: () {
                                          Provider.of<CartProvider>(context, listen: false).increase(data[index].id);
                                         },
                                         style: OutlinedButton.styleFrom(
                                           padding: EdgeInsets.zero,
                                           alignment: Alignment.center,
                                         ),
                                         child: Icon(Icons.add),
                                       ),
                                     ),
                                     Padding(padding: EdgeInsets.symmetric(horizontal: 5,), child: Text('${data[index].quantity}'.padLeft(2,'0'),style: Theme.of(context).textTheme.headline6,)),
                                     SizedBox(
                                       height: 30,
                                       width: 30,
                                       child: OutlinedButton(
                                         onPressed: () {
                                           Provider.of<CartProvider>(context, listen: false).decrease(data[index].id);
                                         },
                                         style: OutlinedButton.styleFrom(
                                           padding: EdgeInsets.zero,
                                           alignment: Alignment.center,
                                         ),
                                         child: Icon(Icons.remove),
                                       ),
                                     ),
                                   ],
                                 ),
                               ))
                         ],
                       ));
                 },
                 separatorBuilder: (BuildContext context, int index) {
                   return SizedBox(
                     height: 5,
                   );
                 },
                 itemCount: value.items.length);
           }
         ),
        Positioned(
          bottom: 0,
          child: SizedBox(
            height: 60,
            width: MediaQuery.of(context).size.width,
            child: FloatingActionButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              onPressed: () {},
              child: Text(
                'Buy Now'.toUpperCase(),
                style: styleTileItem,
              ),
            ),
          ),
        ),
      ]
      ),
    );
  }
}
