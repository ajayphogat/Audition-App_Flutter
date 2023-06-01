import 'package:auto_size_text/auto_size_text.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/login/verifyMobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../auth/auth_service.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);

  static const String routeName = "/forgot-password";

  final TextEditingController _phone = TextEditingController();

  AuthService authService = AuthService();

  Future<void> forgotPassword(BuildContext context, String number) async {
    await authService.forgotPassword(context: context, number: number);
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    // String argument = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.25,
              // color: Colors.grey,
              child: Stack(
                children: [
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight * 0.25,
                    child: Image.asset(
                      "asset/images/uiImages/sscreen.png",
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                  Positioned(
                    bottom: screenHeight * 0.02,
                    left: screenWidth * 0.025,
                    child: SizedBox(
                      width: screenWidth,
                      height: screenHeight * 0.05,
                      // color: Colors.blue,
                      child: const AutoSizeText(
                        "Forgot Password",
                        maxLines: 1,
                        maxFontSize: 30,
                        minFontSize: 20,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // AspectRatio(
            //   aspectRatio: 2.4,
            //   child: SvgPicture.asset(
            //       "asset/images/illustration/forgot_password.svg"),
            // ),
            // const SizedBox(height: 30),
            // const Text(
            //   "Forgot Password",
            //   style: TextStyle(
            //     fontSize: 37,
            //     fontFamily: fontFamily,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // const SizedBox(height: 10),
            // const Text(
            //   "Message sent on registered mobile\nnumber.",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     color: Color(0xFF979797),
            //     fontFamily: fontFamily,
            //     fontSize: 18,
            //   ),
            // ),
            SizedBox(height: screenHeight * 0.08),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: AutoSizeText(
                "Enter your registered phone number to receive an OTP",
                maxFontSize: 16,
                minFontSize: 12,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            Container(
              // height: screenHeight * 0.05,
              width: screenWidth,
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xffDADADA),
                ),
              ),
              child: TextFormField(
                controller: _phone,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please fill this";
                  } else {
                    return null;
                  }
                },
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: fontFamily,
                ),
                obscureText: false,
                decoration: InputDecoration(
                  hintText: "Enter your registered phone number",
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: fontFamily,
                    color: placeholderTextColor,
                  ),
                  errorStyle: const TextStyle(
                    fontFamily: fontFamily,
                    height: 0.1,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Container(
                    width: screenWidth * 0.025,
                    height: screenHeight * 0.025,
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      "asset/icons/call.svg",
                      color: Colors.black,
                    ),
                  ),
                  // prefixIcon: Padding(
                  //   padding: const EdgeInsets.only(left: 20, right: 5, bottom: 0),
                  //   child: Icon(icon,
                  //       color: Color(0xff0A4C7E),
                  //       size: icon == MyFlutterApp.message ? 28 : 35),
                  // ),
                ),
              ),
            ),
            // commonTextField(screenWidth, screenHeight, context, _phone,
            //     "Phone No.", "asset/icons/phone_icon.svg", false),
            // commonTextField(screenWidth, screenHeight, context, _phone,
            //     "Phone No.", MyFlutterApp.call, false),
            const SizedBox(height: 60),
            // longBasicButton(context, VerifyMobile.routeName, "SEND OTP"),
            InkWell(
              onTap: _phone.text.length < 10
                  ? () {}
                  : () async {
                      print("phone text => ${_phone.text}");
                      circularProgressIndicatorNew(context);
                      await forgotPassword(context, (_phone.text).trim());
                    },
              child: Container(
                alignment: Alignment.center,
                width: screenWidth * 0.59,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: greenColor,
                ),
                child: AutoSizeText(
                  "SEND OTP",
                  maxLines: 1,
                  maxFontSize: 15,
                  minFontSize: 10,
                  style: const TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
