import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BasicInfoPage extends StatefulWidget {
  const BasicInfoPage({Key? key}) : super(key: key);

  static const String routeName = "/basicInfo-page";

  @override
  State<BasicInfoPage> createState() => _BasicInfoPageState();
}

class _BasicInfoPageState extends State<BasicInfoPage> {
  late TextEditingController _nameController;
  late TextEditingController _urlController;
  late TextEditingController _professionalController;

  bool profileVisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _urlController = TextEditingController();
    _professionalController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameController.dispose();
    _urlController.dispose();
    _professionalController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: profileAppBar(screenHeight, screenWidth, context, profileData[0]),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04, vertical: screenHeight * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Name",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              basicTextFormField(screenWidth, screenHeight, _nameController,
                  "Enter your name here"),
              SizedBox(height: screenHeight * 0.03),
              basicDropDown(screenHeight, "Preferred Pronoun",
                  "No preferred pronoun selected"),
              basicDropDown(screenHeight, "Gender", "Select"),
              basicDropDown(screenHeight, "Location", "Select"),
              const Text(
                "Profile URL",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              basicTextFormField(screenWidth, screenHeight, _nameController,
                  "Enter your URL here"),
              SizedBox(height: screenHeight * 0.03),
              const Text(
                "Professional/Working Title",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              basicTextFormField(screenWidth, screenHeight, _nameController,
                  "Enter your title here"),
              SizedBox(height: screenHeight * 0.03),
              const Text(
                "Profile Visibility",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Row(
                children: [
                  Transform.scale(
                    scale: 0.9,
                    child: CupertinoSwitch(
                      value: profileVisible,
                      onChanged: (bool value) {
                        setState(() {
                          profileVisible = !profileVisible;
                        });
                      },
                      activeColor: const Color(0xFF30319D),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  const Text(
                    "Public",
                    style: TextStyle(fontSize: 17),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
