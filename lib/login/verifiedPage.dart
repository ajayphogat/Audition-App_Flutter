import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/bottomNavigation/homePage.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifiedPage extends StatelessWidget {
  const VerifiedPage({Key? key}) : super(key: key);

  static const String routeName = "/verified-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.20),
              AspectRatio(
                aspectRatio: 2,
                child: SvgPicture.asset(
                    "asset/images/illustration/charm_circle-tick.svg"),
              ),
              const SizedBox(height: 60),
              const Text(
                "Your mobile number is\nsuccessfully verified.",
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              longBasicButton(
                  context, BottomNavigationPage.routeName, "Go Home"),
            ],
          ),
        ),
      ),
    );
  }
}
