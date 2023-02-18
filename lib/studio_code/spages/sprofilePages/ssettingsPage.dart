import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

class SSettingsPage extends StatelessWidget {
  const SSettingsPage({Key? key}) : super(key: key);

  static const String routeName = "/setting-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            MyFlutterApp.bi_arrow_down,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          "Welcome to Settings Page",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
