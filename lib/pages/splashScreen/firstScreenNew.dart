import 'package:flutter/material.dart';

class FirstSplashScreenNew extends StatefulWidget {
  const FirstSplashScreenNew({Key? key}) : super(key: key);

  static const String routeName = "/firstSplashScreenNew-page";

  @override
  State<FirstSplashScreenNew> createState() => _FirstSplashScreenNewState();
}

class _FirstSplashScreenNewState extends State<FirstSplashScreenNew> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: screenWidth,
            height: screenHeight,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
            child: Image.asset("asset/images/illustration/find.png"),
          ),
          Positioned(
            bottom: screenHeight * 0.20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Made to be Found",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF979797).withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          const Center(
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
