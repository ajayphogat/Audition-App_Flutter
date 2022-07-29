import 'package:flutter/material.dart';

class SecondSplashScreen extends StatelessWidget {
  const SecondSplashScreen({Key? key}) : super(key: key);

  static const String routeName = "/secondSplashScreen-page";

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
            child: Image.asset("asset/images/uiImages/splashScreen2.png",
                fit: BoxFit.cover),
          ),
          Container(
            width: screenWidth,
            height: screenHeight,
            color: Colors.black26,
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
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.19),
                child: Column(
                  children: const [
                    Text(
                      "Welcome",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Sapien sapien ut integer at risus. Dis dignissim habitasse mattis aliquam maecenas ut vel metus.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
