import 'package:flutter/material.dart';

class Data {
  final int id;
  final String name;
  final double y;
  final Color color;

  const Data({
    required this.id,
    required this.name,
    required this.y,
    required this.color,
  });
}

class BarData {
  static int interval = 5;

  static List<Data> barData = const [
    Data(
      id: 0,
      name: 'Jan',
      y: 15,
      color: Colors.orange,
    ),
    Data(
      id: 0,
      name: 'Jan',
      y: 20,
      color: Colors.orange,
    ),
    // Data(
    //   id: 1,
    //   name: 'Feb',
    //   y: 10,
    //   color: Colors.orange,
    // ),
    // Data(
    //   id: 2,
    //   name: 'Mar',
    //   y: 12,
    //   color: Colors.orange,
    // ),
    // Data(
    //   id: 3,
    //   name: 'Apr',
    //   y: 18,
    //   color: Colors.orange,
    // ),
  ];
}
