import 'package:first_app/bottomNavigation/homePage.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/login/verifiedPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              AspectRatio(
                aspectRatio: 2.2,
                child: SvgPicture.asset(
                    "asset/images/illustration/maintenance.svg"),
              ),
              const SizedBox(height: 30),
              const Text(
                "Verify Your Mobile",
                style: TextStyle(
                  fontSize: 35,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Please enter code",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: fontFamily,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  circleNumber(_controller0, true),
                  circleNumber(_controller1, false),
                  circleNumber(_controller2, false),
                  circleNumber(_controller3, false),
                ],
              ),
              const SizedBox(height: 60),
              longBasicButton(context, VerifiedPage.routeName, "Enter OTP"),
            ],
          ),
        ),
      ),
    );
  }

  Container circleNumber(TextEditingController controller, bool autofocus) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
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
