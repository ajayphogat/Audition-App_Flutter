import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  static const String routeName = "/myProfile-page";

  @override
  State<MyProfilePage> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("My Profile Page"),
      ),
    );
  }
}
