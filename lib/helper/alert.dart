import 'package:flutter/material.dart';

AlertDialog alertLoading = AlertDialog(
  content: Row(
    children: [
      CircularProgressIndicator(),
      Container(margin: EdgeInsets.only(left: 15),child: Text('Loading'),)
    ],
  ),
);

AlertDialog alertSuccess = AlertDialog(
  content: Row(
    children: [
      Icon(Icons.check,size: 45, color: Colors.green,),
      Container(margin: EdgeInsets.only(left: 15),child: Text('Bought!!'),)
    ],
  ),
);