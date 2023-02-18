import 'package:first_app/constants.dart';
import 'package:first_app/login/loginPage.dart';
import 'package:first_app/login/signUpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  static const String routeName = "/main-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child:
                    SvgPicture.asset("asset/images/illustration/mainPage.svg"),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, LoginPage.routeName);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 80),
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: secondoryColor,
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: fontFamily,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, SignupPage.routeName);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 80),
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: const Color(0xFFF9D422),
                  ),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: fontFamily,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: -15,
            right: -15,
            child: SvgPicture.asset("asset/images/illustration/Vector.svg"),
          ),
        ],
      ),
    );
  }
}
