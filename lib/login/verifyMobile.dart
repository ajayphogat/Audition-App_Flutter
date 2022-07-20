import 'package:first_app/homePage/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyMobile extends StatefulWidget {
  const VerifyMobile({Key? key}) : super(key: key);

  static const String routeName = "/verifyMobile-page";

  @override
  State<VerifyMobile> createState() => _VerifyMobileState();
}

class _VerifyMobileState extends State<VerifyMobile> {
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Please enter code",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  circleNumber(),
                  circleNumber(),
                  circleNumber(),
                  circleNumber(),
                ],
              ),
              const SizedBox(height: 60),
              InkWell(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomePage.routeName, (route) => false);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 160,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFF9D422)),
                  child: const Text(
                    "Enter OTP",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container circleNumber() {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[300],
      ),
      //TODO: Add widget for Single Number Code
    );
  }
}
