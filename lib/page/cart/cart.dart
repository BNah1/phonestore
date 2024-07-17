import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  static const routerName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My cart'),
      ),
      body: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 100,
                color: Colors.amber,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Image(
                          image: AssetImage('assets/images/logi.webp'),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(flex: 1, child: Text('titile')),
                          Expanded(flex: 1, child: Text('gia tien')),
                          Expanded(flex: 2, child: Text('Tong tien')),
                        ],
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
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.center,
                                  ),
                                  child: Icon(Icons.add),
                                ),
                              ),
                              Padding(padding: EdgeInsets.symmetric(horizontal: 5,), child: Text('1'.padLeft(2,'0'),style: Theme.of(context).textTheme.headline6,)),
                              SizedBox(
                                height: 30,
                                width: 30,
                                child: OutlinedButton(
                                  onPressed: () {},
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
          itemCount: 10),
    );
  }
}
