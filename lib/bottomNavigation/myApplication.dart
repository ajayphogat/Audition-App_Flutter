import 'package:flutter/material.dart';

class MyApplicationPage extends StatefulWidget {
  const MyApplicationPage({Key? key}) : super(key: key);

  static const String routeName = "/myApplication-page";

  @override
  State<MyApplicationPage> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplicationPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("My Application Page"),
      ),
    );
  }
}
