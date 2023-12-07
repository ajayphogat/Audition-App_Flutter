import 'package:auto_size_text/auto_size_text.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/login/resetPassword.dart';
import 'package:first_app/login/verifiedPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../auth/auth_service.dart';

class VerifyMobile extends StatefulWidget {
  const VerifyMobile({Key? key}) : super(key: key);

  static const String routeName = "/verifyMobile-page";

  @override
  State<VerifyMobile> createState() => _VerifyMobileState();
}

class _VerifyMobileState extends State<VerifyMobile> {
  late TextEditingController _controller0;
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  late TextEditingController _controller3;

  late bool autofocus;

  AuthService authService = AuthService();

  Future<void> otpVerify(String number, String otp) async {
    await authService.verificationOTPForgot(
        context: context, number: number, otp: otp);
  }

  Future<void> otpVerifyStudio(String number, String otp) async {
    await authService.verificationOTPForgotStudio(
        context: context, number: number, otp: otp);
  }

  @override
  void initState() {
    super.initState();
    _controller0 = TextEditingController();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _controller0 = TextEditingController();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    _controller3 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    List<String> argument =
        ModalRoute.of(context)!.settings.arguments as List<String>;
    String userNumber = argument[0];
    String userType = argument[1];
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
              // SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              // AspectRatio(
              //   aspectRatio: 2.2,
              //   child: SvgPicture.asset(
              //       "asset/images/illustration/maintenance.svg"),
              // ),
              // const SizedBox(height: 30),
              // const Text(
              //   "Verify Your Mobile",
              //   style: TextStyle(
              //     fontSize: 35,
              //     fontFamily: fontFamily,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // const SizedBox(height: 10),
              // Text(
              //   "Please enter code",
              //   style: TextStyle(
              //     fontSize: 25,
              //     fontFamily: fontFamily,
              //     color: Colors.grey[400],
              //   ),
              // ),
              // const SizedBox(height: 60),

              SizedBox(height: screenHeight * 0.06),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                child: AutoSizeText(
                  "We have sent a 4 digit one time password to your registered mobile number, Please verify.",
                  maxFontSize: 14,
                  minFontSize: 12,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.06),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  circleNumber(
                    _controller0,
                    true,
                    screenWidth,
                    screenHeight,
                  ),
                  Container(
                    width: screenWidth * 0.03,
                    height: screenHeight * 0.004,
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff858585),
                    ),
                  ),
                  circleNumber(
                    _controller1,
                    false,
                    screenWidth,
                    screenHeight,
                  ),
                  Container(
                    width: screenWidth * 0.03,
                    height: screenHeight * 0.004,
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff858585),
                    ),
                  ),
                  circleNumber(
                    _controller2,
                    false,
                    screenWidth,
                    screenHeight,
                  ),
                  Container(
                    width: screenWidth * 0.03,
                    height: screenHeight * 0.004,
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color(0xff858585),
                    ),
                  ),
                  circleNumber(
                    _controller3,
                    false,
                    screenWidth,
                    screenHeight,
                  ),
                ],
              ),

              const SizedBox(height: 60),
              InkWell(
                onTap: () async {
                  circularProgressIndicatorNew(context);
                  if (userType == "audition") {
                    await otpVerify(userNumber,
                        "${_controller0.text}${_controller1.text}${_controller2.text}${_controller3.text}");
                  } else {
                    await otpVerifyStudio(userNumber,
                        "${_controller0.text}${_controller1.text}${_controller2.text}${_controller3.text}");
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  width: screenWidth * 0.59,
                  height: screenHeight * 0.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: greenColor,
                  ),
                  child: AutoSizeText(
                    "CONFIRM",
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
              // longBasicButton(context, ResetPassword.routeName, "Enter OTP"),
              // longBasicButton(context, VerifiedPage.routeName, "Enter OTP"),
            ],
          ),
        ),
      ),
    );
  }

  Container circleNumber(TextEditingController controller, bool autofocus,
      double width, double height) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      width: width * 0.18,
      height: height * 0.055,
      decoration: BoxDecoration(
        // shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xffDADADA),
        ),
        color: Colors.grey[50],
      ),
      child: TextFormField(
        scrollPadding: EdgeInsets.zero,
        textAlign: TextAlign.center,
        controller: controller,
        autofocus: autofocus,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: '',
        ),
        onChanged: (String value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
