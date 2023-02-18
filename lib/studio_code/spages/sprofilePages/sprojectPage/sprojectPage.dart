import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/login/mainPage.dart';
import 'package:first_app/provider/studio_provider.dart';
import 'package:first_app/studio_code/scommon/scommon.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:first_app/studio_code/spages/sprofilePages/sprojectPage/ssubscriptionPages/ssubscriptionPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../customize/my_flutter_app_icons.dart';

class SProjectPage extends StatefulWidget {
  const SProjectPage({Key? key}) : super(key: key);

  static const String routeName = "/project-page";

  @override
  State<SProjectPage> createState() => _SProjectPageState();
}

class _SProjectPageState extends State<SProjectPage> {
  late TextEditingController _projectDesc;

  final AuthService authService = AuthService();

  Future<void> updateProjectDesc() async {
    await authService.updateProjectDesc(
      context: context,
      projectDesc: _projectDesc.text,
    );
  }

  @override
  void initState() {
    _projectDesc = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _projectDesc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var user = Provider.of<StudioProvider>(context).user;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            user.projectDesc.isEmpty
                ? InkWell(
                    onTap: () async {
                      _projectDesc.text = user.projectDesc;
                      await projectDescPopup(
                          context, screenWidth, screenHeight, _projectDesc);
                    },
                    child: Container(
                      width: screenWidth,
                      height: screenHeight * 0.10,
                      alignment: Alignment.center,
                      child: const Text(
                        "Click to add Project Description",
                        style: TextStyle(
                          color: placeholderTextColor,
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        width: screenWidth,
                        alignment: Alignment.topRight,
                        padding: EdgeInsets.only(right: screenWidth * 0.05),
                        margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                        child: InkWell(
                          onTap: () async {
                            _projectDesc.text = user.projectDesc;
                            await projectDescPopup(context, screenWidth,
                                screenHeight, _projectDesc);
                          },
                          child: const Icon(
                            MyFlutterApp.edit_black,
                            size: 18,
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth,
                        // height: screenHeight * 0.30,
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.05,
                          right: screenWidth * 0.05,
                          bottom: screenHeight * 0.02,
                        ),
                        child: Text(
                          user.projectDesc,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, SSubscriptionPage.routeName);
              },
              child:
                  simpleArrowColumn(screenHeight, screenWidth, "Subscription"),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 10,
            ),
            InkWell(
              onTap: () async {
                circularProgressIndicatorNew(context);
                navigatorPop() => Navigator.pop(context);
                navigatorPush() => Navigator.pushNamedAndRemoveUntil(
                    context, MainPage.routeName, (route) => false);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString("x-auth-token", "");
                prefs.setString("x-studio-token", "");
                await FirebaseAuth.instance.signOut();
                navigatorPop();
                navigatorPush();
                // WidgetsBinding.instance.addPostFrameCallback((_) {
                //   newDialogBox1(context, screenWidth, screenHeight,
                //       "Account Reported!", "GO BACK", false, "");
                // }
                // );
              },
              child: simpleArrowColumn(screenHeight, screenWidth, "Log Out"),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> projectDescPopup(BuildContext context, double screenWidth,
      double screenHeight, TextEditingController controller) {
    return showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Column(
            children: [
              Container(
                width: screenWidth * 0.80,
                height: screenHeight * 0.30,
                padding: EdgeInsets.only(left: screenWidth * 0.02),
                decoration: BoxDecoration(
                  border: Border.all(color: secondoryColor),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: controller,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Your Project Description...",
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () async {
                      navigatePop() => Navigator.pop(context);
                      circularProgressIndicatorNew(context);
                      await updateProjectDesc();
                      navigatePop();
                      navigatePop();
                    },
                    child: const Text("Add"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
