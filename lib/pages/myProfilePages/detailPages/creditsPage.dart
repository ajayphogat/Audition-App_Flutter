import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:flutter/material.dart';

class CreditsPage extends StatefulWidget {
  const CreditsPage({Key? key}) : super(key: key);

  static const String routeName = "/credits-Page";

  @override
  State<CreditsPage> createState() => _CreditsPageState();
}

class _CreditsPageState extends State<CreditsPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: profileAppBar(screenHeight, screenWidth, context, profileData[5]),
      body: newColumn(
        screenHeight,
        screenWidth,
        "You don't have any credits added yet",
        "Add credits from your past performance and\njobs in the entertainment industry.",
        "ADD CREDIT",
      ),
    );
  }
}
