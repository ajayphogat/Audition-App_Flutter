import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:flutter/material.dart';

class AppearancePage extends StatefulWidget {
  const AppearancePage({Key? key}) : super(key: key);

  static const String routeName = "/appearance-Page";

  @override
  State<AppearancePage> createState() => _AppearancePageState();
}

class _AppearancePageState extends State<AppearancePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: profileAppBar(screenHeight, screenWidth, context, profileData[1]),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04, vertical: screenHeight * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              basicDropDown(screenHeight, "Age Range", "Select"),
              basicDropDown(screenHeight, "Ethnicities", "Select"),
              basicDropDown(screenHeight, "Height", "Select"),
              basicDropDown(screenHeight, "Weight", "Select"),
              basicDropDown(screenHeight, "Body Type", "Select"),
              basicDropDown(screenHeight, "Hair Color", "Select"),
              basicDropDown(screenHeight, "Eye Color", "Select"),
            ],
          ),
        ),
      ),
    );
  }
}
