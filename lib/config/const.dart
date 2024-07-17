import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

const dColorMain = Color(0xff0EAF89);
const dColorIconButton = Colors.blue;
const sizeIconButton = 24.0;
const dColorFooterImage = Colors.white60;

final styleTileItem = TextStyle(
  color: Colors.black,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

final styleTile = TextStyle(
  color: Colors.black,
  fontSize: 17,
  fontWeight: FontWeight.bold,
);

final styleTileIcon = TextStyle(
  color: Colors.black,
  fontSize: 15,
  fontWeight: FontWeight.bold,
);

const image1 =
    'https://plus.unsplash.com/premium_photo-1695084221958-079096c96e05?q=80&w=3461&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

const textTest =
    '100 bài tập lập trình có lời giải với nhiều cấp độ từ dễ đến khó và dàn trải hầu hết kiến thức nền tảng lập trình cần phải thành thạo đối với lập trình viên. Bạn sẽ được thực hành nhiều dạng bài tập thuộc các chủ đề: thao tác số và toán học, câu điều kiện, vòng lặp, array, kỹ thuật xử lý chuỗi, kỹ thuật chuyển đổi qua lại giữa các kiểu dữ liệu và các tình huống khó trong thực tế. ';

class priceVND extends StatelessWidget {
    priceVND({super.key , required this.price , this.size , this.weight});
  var price;
  var size;
  var weight;
  @override
  Widget build(BuildContext context) {
    return Text(intl.NumberFormat.simpleCurrency(locale: 'vi').format(price),style: TextStyle(color: Colors.black, fontSize: 23, fontWeight: weight));
  }
}
