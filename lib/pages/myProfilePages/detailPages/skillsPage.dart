import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:flutter/material.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({Key? key}) : super(key: key);

  static const String routeName = "/skills-Page";

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: profileAppBar(screenHeight, screenWidth, context, profileData[4]),
      body: newColumn(
          screenHeight,
          screenWidth,
          "You don't have any skills added yet",
          "Add your performance skills",
          "ADD SKILL"),
    );
  }
}
