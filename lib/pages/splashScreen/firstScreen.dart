import 'package:first_app/pages/splashScreen/secondScreen.dart';
import 'package:flutter/material.dart';

class FirstSplashScreen extends StatelessWidget {
  const FirstSplashScreen({Key? key}) : super(key: key);

  static const String routeName = "/firstSplashScreen-page";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: Image.asset("asset/images/uiImages/splashScreen1.png",
                fit: BoxFit.cover),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.10),
                child: const Text(
                  "Audition Portal",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45,
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, SecondSplashScreen.routeName);
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 40,
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.20,
                      vertical: screenHeight * 0.115),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFF9D422)),
                  child: const Text(
                    "Get started",
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
