import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlineappstore/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import '../../config/const.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);
  static const routerName = '/product';

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int num = 1;

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as Map;
    final product = data['data'];
    Size size = MediaQuery.of(context).size;
    return
   Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: size.height * 0.3),
                    padding: EdgeInsets.only(top: size.height *0.1,
                        left: kDefaultFontSize,
                        right: kDefaultFontSize),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Chi tiet san pham :', style: styleTile,),
                          ReadMoreText(
                            "Đánh giá iPhone 13 - Flagship được mong chờ năm 2021\n     Cuối năm 2020, bộ 4 iPhone 12 đã được ra mắt với nhiều cái tiến. Sau đó, mọi sự quan tâm lại đổ dồn vào sản phẩm tiếp theo – iPhone 13. Vậy iP 13 sẽ có những gì, hãy tìm hiểu ngay sau đây.\n                            Thiết kế với nhiều đột phá\n                            Về kích thước, iPhone 13 sẽ có 4 phiên bản khác nhau và kích thước không đổi so với series iPhone 12 hiện tại. Nếu iPhone 12 có sự thay đổi trong thiết kế từ góc cạnh bo tròn (Thiết kế được duy trì từ thời iPhone 6 đến iPhone 11 Pro Max) sang thiết kế vuông vắn (đã từng có mặt trên iPhone 4 đến iPhone 5S, SE).\n                            Thì trên điện thoại iPhone 13 vẫn được duy trì một thiết kế tương tự. Máy vẫn có phiên bản khung viền thép, một số phiên bản khung nhôm cùng mặt lưng kính. Tương tự năm ngoái, Apple cũng sẽ cho ra mắt 4 phiên bản là iPhone 13, 13 mini, 13 Pro và 13 Pro Max.",
                            trimMode: TrimMode.Line,
                            trimLines: 2,
                            colorClickableText: Colors.black,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                            lessStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 50,),
                          Row(children: [
                            InkWell(
                              onTap: (){
                                Provider.of<CartProvider>(context, listen: false).addCart(product.id, product.image, product.name, product.price, num, product.summary);
                              },
                              child: Container(
                                height: 50,
                                width: 58,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: Colors.black)
                                ),
                                child: Icon(Icons.shopping_cart),
                              ),
                            ),
                            SizedBox(width: 5,),
                            SizedBox(
                              height: 50,
                              width: 300,
                              child: FloatingActionButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                onPressed: (){},
                              child: Text('Buy Now'.toUpperCase(),style: styleTileItem,),),
                            )
                          ],)

                        ],
                      ),
                    ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Mo ta :', style: styleTile,),
                      Text(product.summary.toString()),
                      ratingIcon(product.rating, Icons.star),
                      Row(children: [
                        Column(children: [
                          Row(children: [Text('Gia :', style: styleTile,),
                            priceVND(price: product.price, weight: FontWeight.bold)],),
                          Row(
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        if (num > 1) {
                                          num--;
                                        }
                                      });
                                    },
                                    child: Icon(Icons.remove)),
                                Padding(padding: EdgeInsets.symmetric(horizontal: 5,), child: Text(num.toString().padLeft(2,'0'),style: Theme.of(context).textTheme.headline6,)),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      num++;
                                    });
                                  },
                                  child: Icon(Icons.add),
                                ),
                              ]
                          ),
                        ],),
                        SizedBox(width: 50,),
                        Expanded(child: Image.network(product.image,fit: BoxFit.fill,))
                      ],
                      )
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class Detail extends StatelessWidget {
  Detail({Key? key, required this.title, required this.text, this.icon})
      : super(key: key);

  String title;
  String text;
  final icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
        ),
        Text(title + ' : '),
        SizedBox(
          width: 10,
        ),
        Text(text),
        Icon(icon),
      ],
    );
  }
}

Widget ratingIcon(int number, IconData icon) {
  List<Widget> icons = [];

  // Tạo danh sách các biểu tượng sao dựa trên số `number`
  for (int i = 0; i < number; i++) {
    icons.add(Icon(icon));
  }

  // Trả về một hàng các biểu tượng sử dụng Widget Row
  return Row(
    children: icons,
  );
}




