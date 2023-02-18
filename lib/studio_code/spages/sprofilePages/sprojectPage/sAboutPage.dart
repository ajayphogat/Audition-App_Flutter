import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/studio_code/scommon/scommon.dart';
import 'package:first_app/studio_code/spages/sprofilePages/sprojectPage/ssubscriptionPages/ssubscriptionPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/studio_provider.dart';

class SAboutPage extends StatefulWidget {
  const SAboutPage({Key? key}) : super(key: key);

  static const String routeName = "/about-page";

  @override
  State<SAboutPage> createState() => _SAboutPageState();
}

class _SAboutPageState extends State<SAboutPage> {
  late TextEditingController _aboutDesc;

  final AuthService authService = AuthService();

  Future<void> updateAboutDesc() async {
    await authService.updateAboutDesc(
      context: context,
      aboutDesc: _aboutDesc.text,
    );
  }

  @override
  void initState() {
    _aboutDesc = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _aboutDesc.dispose();
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
            user.aboutDesc.isEmpty
                ? InkWell(
                    onTap: () async {
                      _aboutDesc.text = user.aboutDesc;
                      await aboutDescPopup(
                          context, screenWidth, screenHeight, _aboutDesc);
                    },
                    child: Container(
                      width: screenWidth,
                      height: screenHeight * 0.10,
                      alignment: Alignment.center,
                      child: const Text(
                        "Click to wirte about your studio",
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
                            _aboutDesc.text = user.aboutDesc;
                            await aboutDescPopup(
                                context, screenWidth, screenHeight, _aboutDesc);
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
                          user.aboutDesc,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
            // Divider(
            //   color: Colors.grey.shade300,
            //   thickness: 10,
            // ),
            // InkWell(
            //   onTap: () {
            //     Navigator.pushNamed(context, SSubscriptionPage.routeName);
            //   },
            //   child:
            //       simpleArrowColumn(screenHeight, screenWidth, "Subscription"),
            // ),
            // Divider(
            //   color: Colors.grey.shade300,
            //   thickness: 10,
            // ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> aboutDescPopup(BuildContext context, double screenWidth,
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
                    hintText: "About your studio...",
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
                      await updateAboutDesc();
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
