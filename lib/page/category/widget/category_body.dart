import 'package:flutter/material.dart';
import 'package:onlineappstore/page/product/product.dart';
import 'package:intl/intl.dart' as intl;
import 'package:onlineappstore/providers/category_provider.dart';
import 'package:provider/provider.dart';

class CategoryBody extends StatefulWidget {
  const CategoryBody({Key? key}) : super(key: key);

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  late Future productCategoryFuture;
  @override
  void didChangeDependencies() {
    final Map<String, dynamic> arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    productCategoryFuture =
        Provider.of<CategoryProvider>(context).getProDuctCategory(arg['id']);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: [],
      future: productCategoryFuture,
      builder: (BuildContext context, asyncData) {
        List data = [];
        if (asyncData.hasData) {
          data = asyncData.data as List;
        } else {
          return Container(
            child: Text('error'),
          );
        }
        return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3 / 4,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ProductPage.routerName,
                      arguments: {'data': data[index]});
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: GridTile(
                      child:
                          Image.network(data[index].image, fit: BoxFit.cover),
                      footer: GridTileBar(
                        backgroundColor: Colors.black26,
                        title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data[index].name,
                              ),
                              Text(
                                data[index].summary,
                              ),
                            ]),
                        subtitle: Text(
                          intl.NumberFormat.simpleCurrency(locale: 'vi',decimalDigits: 3).format(data[index].price),style: TextStyle(color: Colors.amberAccent),
                        ),
                        trailing: Icon(Icons.shopping_cart),
                      )),
                ),
              );
            });
      },
    );
  }
}
