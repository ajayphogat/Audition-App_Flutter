import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/common/common.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: screenHeight * 0.1015,
        actions: [
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.08,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: screenWidth * 0.02,
                      right: screenWidth * 0.02,
                      top: screenHeight * 0.02,
                      bottom: screenHeight * 0.005),
                  height: screenHeight * 0.02,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(MyFlutterApp.bi_arrow_down,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      appBarTextButton("Cancel"),
                      const Text(
                        "Basic Info",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      appBarTextButton("Save"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
              basicDropDown(screenHeight, "Preferred Pronoun",
                  "No preferred pronoun selected"),
              basicDropDown(screenHeight, "Gender", "Select"),
              basicDropDown(screenHeight, "Location", "Select"),
              SizedBox(height: screenHeight * 0.03),
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
