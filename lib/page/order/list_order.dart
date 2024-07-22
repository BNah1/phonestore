import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:onlineappstore/providers/order_provider.dart';
import 'package:onlineappstore/providers/product_provider.dart';
import 'package:provider/provider.dart';

import '../../model/product_model.dart';

class ListOrder extends StatefulWidget {
  const ListOrder({super.key});

  static const routerName = '/order';

  @override
  State<ListOrder> createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách đơn hàng'),
      ),
      body: FutureBuilder(
        future: Provider.of<OrderProvider>(context).getListOrderCart(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          var data = snapshot.data as List;
          return snapshot.hasData
              ? ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              var dataItem = data[index]['order_items'] as List;
              return ExpansionTile(
                  title: Text('Mã đơn hàng : ${data[index]['code']}'),
                  subtitle: Text(DateFormat('kk:mm - dd-MM-yyyy ')
                      .format(DateTime.parse(data[index]['created_at']))),
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dataItem.length,
                      itemBuilder: ((context, index) {
                        return FutureBuilder(
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: const CircularProgressIndicator());
                            }
                            var item = snapshot.data as Product;
                            return ListTile(
                              leading: Image.network(item.image),
                              title: Row(children: [Text(item.name),SizedBox(width: 20,) ]),
                            );
                          },
                          future: Provider.of<ProductProvider>(context,
                              listen: false)
                              .getProduct(
                              dataItem[index]['product_id']),
                        );
                      }),
                    ),
                  ]);
            },
          )
              : Container(
            child: SvgPicture.asset('assets/images/svg/no-data.svg'),
          );
        },
      ),
    );
  }
}
