import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppearancePage extends StatefulWidget {
  const AppearancePage({Key? key}) : super(key: key);

  static const String routeName = "/appearance-Page";

  @override
  State<AppearancePage> createState() => _AppearancePageState();
}

class _AppearancePageState extends State<AppearancePage> {
  late TextEditingController _ageController;
  late TextEditingController _ethController;
  late TextEditingController _heightController;
  late TextEditingController _weightController;
  late TextEditingController _bodyTypeController;
  late TextEditingController _hairColorController;
  late TextEditingController _eyeColorController;

  final AuthService authService = AuthService();

  Future<void> updateAppearance() async {
    await authService.updateAppearance(
      context: context,
      age: _ageController.text,
      ethnicity: _ethController.text,
      height: _heightController.text,
      weight: _weightController.text,
      bodyType: _bodyTypeController.text,
      hairColor: _hairColorController.text,
      eyeColor: _eyeColorController.text,
    );
  }

  @override
  void initState() {
    _ageController = TextEditingController();
    _ethController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _bodyTypeController = TextEditingController();
    _hairColorController = TextEditingController();
    _eyeColorController = TextEditingController();
    var user = Provider.of<UserProvider>(context, listen: false).user;
    _ageController.text = user.age;
    _ethController.text = user.ethnicity;
    _heightController.text = user.height;
    _weightController.text = user.weight;
    _bodyTypeController.text = user.bodyType;
    _hairColorController.text = user.hairColor;
    _eyeColorController.text = user.eyeColor;
    super.initState();
  }

  @override
  void dispose() {
    _ageController.dispose();
    _ethController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _bodyTypeController.dispose();
    _hairColorController.dispose();
    _eyeColorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: profileAppBar1(
          screenHeight, screenWidth, context, profileData[1], updateAppearance),
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04, vertical: screenHeight * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Age",
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              basicTextFormField(
                  screenWidth,
                  screenHeight,
                  _ageController,
                  _ageController.text.isEmpty
                      ? "Enter you age here"
                      : _ageController.text),
              SizedBox(height: screenHeight * 0.03),
              // basicDropDown(screenHeight, "Age", "Select"),
              InkWell(
                onTap: () {
                  showPopup(context, screenWidth, screenHeight, ethnicitiesData,
                      _ethController);
                },
                child: basicDropDown(
                    screenHeight,
                    "Ethnicities",
                    _ethController.text.isEmpty
                        ? "Select"
                        : _ethController.text),
              ),
              InkWell(
                onTap: () {
                  showPopup(context, screenWidth, screenHeight, heightData,
                      _heightController);
                },
                child: basicDropDown(
                    screenHeight,
                    "Height",
                    _heightController.text.isEmpty
                        ? "Select"
                        : _heightController.text),
              ),
              const Text(
                "Weight",
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              basicTextFormField(
                  screenWidth,
                  screenHeight,
                  _weightController,
                  _weightController.text.isEmpty
                      //FIXME: ask sir about it
                      ? "Enter you weight in KG"
                      : _weightController.text),
              SizedBox(height: screenHeight * 0.03),
              InkWell(
                onTap: () {
                  showPopup(context, screenWidth, screenHeight, bodyTypeData,
                      _bodyTypeController);
                },
                child: basicDropDown(
                    screenHeight,
                    "Body Type",
                    _bodyTypeController.text.isEmpty
                        ? "Select"
                        : _bodyTypeController.text),
              ),
              InkWell(
                onTap: () {
                  showPopup(context, screenWidth, screenHeight, hairColorData,
                      _hairColorController);
                },
                child: basicDropDown(
                    screenHeight,
                    "Hair Color",
                    _hairColorController.text.isEmpty
                        ? "Select"
                        : _hairColorController.text),
              ),
              InkWell(
                onTap: () {
                  showPopup(context, screenWidth, screenHeight, eyeColorData,
                      _eyeColorController);
                },
                child: basicDropDown(
                    screenHeight,
                    "Eye Color",
                    _eyeColorController.text.isEmpty
                        ? "Select"
                        : _eyeColorController.text),
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
