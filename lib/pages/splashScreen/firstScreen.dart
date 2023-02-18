import 'package:first_app/pages/splashScreen/secondScreen.dart';
import 'package:flutter/material.dart';

class FirstSplashScreen extends StatefulWidget {
  const FirstSplashScreen({Key? key}) : super(key: key);

  static const String routeName = "/firstSplashScreen-page";

  @override
  State<FirstSplashScreen> createState() => _FirstSplashScreenState();
}

class _FirstSplashScreenState extends State<FirstSplashScreen> {
  @override
  void initState() {
    navigateToNext();
    super.initState();
  }

  void navigateToNext() async {
    navToNext() =>
        Navigator.pushReplacementNamed(context, SecondSplashScreen.routeName);
    await Future.delayed(const Duration(milliseconds: 2000));
    navToNext();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.pushNamed(context, SecondSplashScreen.routeName);
        },
        child: Stack(
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
          ],
        ),
      ),
    );
  }
}
