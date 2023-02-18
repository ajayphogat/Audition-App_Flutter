import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  late TextEditingController _pronounText;
  late TextEditingController _genderText;
  late TextEditingController _locationText;

  final AuthService authService = AuthService();

  bool profileVisible = false;

  Future<void> updateBasicInfo() async {
    await authService.updateBasicInfo(
      context: context,
      fname: _nameController.text,
      pronoun: _pronounText.text,
      gender: _genderText.text,
      location: _locationText.text,
      profileUrl: _urlController.text,
      category: _professionalController.text,
      visibility: profileVisible == true ? "public" : "private",
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _urlController = TextEditingController();
    _professionalController = TextEditingController();
    _pronounText = TextEditingController();
    _genderText = TextEditingController();
    _locationText = TextEditingController();
    var user = Provider.of<UserProvider>(context, listen: false).user;
    _nameController.text = user.fname;
    _pronounText.text = user.pronoun;
    _genderText.text = user.gender;
    _locationText.text = user.location;
    _professionalController.text = user.category;
    _urlController.text = user.profileUrl;
    profileVisible = user.visibility == "public" ? true : false;
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _urlController.dispose();
    _professionalController.dispose();
    _pronounText.dispose();
    _genderText.dispose();
    _locationText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: profileAppBar1(
        screenHeight,
        screenWidth,
        context,
        profileData[0],
        updateBasicInfo,
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
                  fontFamily: fontFamily,
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              basicTextFormField(screenWidth, screenHeight, _nameController,
                  "Enter your name here"),
              SizedBox(height: screenHeight * 0.03),
              InkWell(
                onTap: () {
                  showPopup(context, screenWidth, screenHeight, pronounData,
                      _pronounText);
                },
                child: basicDropDown(
                    screenHeight,
                    "Preferred Pronoun",
                    _pronounText.text.isEmpty
                        ? "No preferred pronoun selected"
                        : _pronounText.text),
              ),
              InkWell(
                onTap: () {
                  showPopup(context, screenWidth, screenHeight, genderData,
                      _genderText);
                },
                child: basicDropDown(screenHeight, "Gender",
                    _genderText.text.isEmpty ? "Select" : _genderText.text),
              ),
              InkWell(
                onTap: () {
                  showPopup1(
                    context,
                    screenWidth,
                    screenHeight,
                    locationData,
                    _locationText,
                  );
                },
                child: basicDropDown(screenHeight, "Location",
                    _locationText.text.isEmpty ? "Select" : _locationText.text),
              ),
              const Text(
                "Profile URL",
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              basicTextFormField(screenWidth, screenHeight, _urlController,
                  "Enter your URL here"),
              SizedBox(height: screenHeight * 0.03),
              InkWell(
                onTap: () {
                  showPopup(
                    context,
                    screenWidth,
                    screenHeight,
                    categoryData,
                    _professionalController,
                  );
                },
                child: basicDropDown(
                    screenHeight,
                    "Professional/Working Title",
                    _professionalController.text.isEmpty
                        ? "Select"
                        : _professionalController.text),
              ),
              SizedBox(height: screenHeight * 0.03),
              const Text(
                "Profile Visibility",
                style: TextStyle(
                  fontFamily: fontFamily,
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
                    style: TextStyle(fontSize: 17, fontFamily: fontFamily),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showPopup(BuildContext context, double screenWidth,
      double screenHeight, List<String> data, TextEditingController dataText) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Container(
              alignment: Alignment.centerLeft,
              width: screenWidth * 0.80,
              height: screenHeight * 0.30,
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Radio(
                      value: data[index],
                      groupValue: dataText.text,
                      onChanged: (String? value) {
                        setState(() {
                          dataText.text = value!;
                          Navigator.pop(context);
                        });
                      },
                    ),
                    title: Text(data[index]),
                  );
                },
              ),
            ),
          );
        });
  }

  Future<dynamic> showPopup1(
    BuildContext context,
    double screenWidth,
    double screenHeight,
    List<String> data,
    TextEditingController dataText,
  ) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Container(
              alignment: Alignment.centerLeft,
              width: screenWidth * 0.80,
              child: Column(
                children: [
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: screenWidth * 0.60,
                      height: screenHeight * 0.05,
                      decoration: BoxDecoration(
                        color: placeholderColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "Search here...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    height: screenHeight * 0.50,
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Radio(
                              value: data[index],
                              groupValue: dataText.text,
                              onChanged: (String? value) {
                                setState(() {
                                  dataText.text = value!;
                                  Navigator.pop(context);
                                });
                              }),
                          title: Text(data[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
