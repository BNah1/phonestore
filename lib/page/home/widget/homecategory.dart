import 'package:flutter/material.dart';
import 'package:onlineappstore/page/category/category.dart';
import 'package:onlineappstore/providers/category_provider.dart';
import 'package:provider/provider.dart';

class HomeCategory extends StatefulWidget {
  const HomeCategory({Key? key}) : super(key: key);

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  late Future categoryFuture;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    categoryFuture = Provider.of<CategoryProvider>(context).getCategory();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: categoryFuture,
      initialData: [],
      builder: (context, asyncData) {
        var categoryData = [];
        if (asyncData.hasData) {
          categoryData = asyncData.data! as List;
        } else {
          Container(child: const Text('nodata'));
        }
        return SizedBox(
          height: 140,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, CategoryPage.routerName,
                      arguments: {
                        'id': categoryData[index].id,
                        'name': categoryData[index].name,
                      });
                },
                child: Column(children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        boxShadow: const [],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey,
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(categoryData[index].image))),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(categoryData[index].name)
                ]),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 10,
              );
            },
            itemCount: categoryData.length,
            scrollDirection: Axis.horizontal,
          ),
        );
      },
    );
  }
}
