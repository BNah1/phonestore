import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart' as intl;
import 'package:onlineappstore/page/product/product.dart';
import 'package:onlineappstore/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';

class PlaylistProduct extends StatelessWidget {
  const PlaylistProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 1 ,child: FutureBuilder(
      future: Provider.of<ProductProvider>(context).getProDuctSpecial( ),
      initialData: [],
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }
        var data = snapshot.data ! as List;
        return snapshot.hasData ? GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: 3 / 4,
        ),
            itemCount: data.length,
            itemBuilder: ((context , index){
              return SizedBox(
                child: GridTile(footer: GridTileBar(
                  backgroundColor: Colors.black26,
                  title: Text(data[index].name),
                  subtitle: Text(intl.NumberFormat.simpleCurrency(locale: 'vi',decimalDigits: 3).format(data[index].price),style: TextStyle(fontSize: 12),),
                  trailing: InkWell(
                      onTap: (){
                        Provider.of<CartProvider>(context, listen: false).addCart(data[index].id, data[index].image, data[index].name, data[index].price, 1, data[index].summary.toString());
                      },
                      child: Icon(Icons.add_shopping_cart)),
                )
                    ,
                    child: InkWell(onTap: (){
                  Navigator.pushNamed(context, ProductPage.routerName,
                  arguments: {'data': data[index]});
                    },
                        child: Image(image: NetworkImage(data[index].image), fit: BoxFit.scaleDown))),
              );
            })): Text('Product Empty');
      },
    ));}}

// ListView.separated(
// itemBuilder: ((context , index){
// return ListTile(title: Text('TenSANPHAM'),
// subtitle: Text('200000'),
// leading: Image(image: AssetImage('assets/images/logi.webp'),),
// trailing: Icon(Icons.add_shopping_cart),
// );
// }),
// separatorBuilder: ((context, index){
// return Divider(
// height: 1
// );
// }),
// itemCount: 10)