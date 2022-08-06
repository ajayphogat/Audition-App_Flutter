import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/bottomNavigation/homePage.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/login/mainPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SecondSplashScreen extends StatefulWidget {
  const SecondSplashScreen({Key? key}) : super(key: key);

  static const String routeName = "/secondSplashScreen-page";

  @override
  State<SecondSplashScreen> createState() => _SecondSplashScreenState();
}

class _SecondSplashScreenState extends State<SecondSplashScreen> {
  late PageController _pageController;
  int _activePage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _activePage, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: _activePage == 3
            ? () {
                Navigator.pushNamed(context, BottomNavigationPage.routeName);
              }
            : () {
                setState(() {
                  _activePage = _activePage + 1;
                  _pageController.animateToPage(_activePage,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.linear);
                });
              },
        child: Stack(
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
                      fontFamily: fontFamily,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: screenHeight,
                  height: screenWidth,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.05,
                        right: screenWidth * 0.05,
                        top: screenHeight * 0.173),
                    child: PageView(
                      controller: _pageController,
                      pageSnapping: true,
                      children: [
                        welcomeMessage(screenHeight),
                        discoverMessage(screenHeight),
                        saveMessage(screenHeight),
                        applyMessage(screenHeight),
                        const Text("swipe right"),
                      ],
                      onPageChanged: (value) {
                        value > 3
                            ? Navigator.pushNamed(
                                context, BottomNavigationPage.routeName)
                            : setState(() {
                                _activePage = value;
                              });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: screenHeight * 0.105,
              left: (screenWidth - 70) / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(4, (index) {
                  return Container(
                      margin: const EdgeInsets.all(3),
                      width: _activePage == index ? 30 : 8,
                      height: 8,
                      decoration: _activePage == index
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black,
                            )
                          : BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade700,
                            ));
                }),
              ),
            ),
            // Positioned(
            //   top: screenHeight * 0.04,
            //   right: 0,
            //   child: TextButton(
            //     onPressed: () {
            //       Navigator.pushNamedAndRemoveUntil(
            //           context, MainPage.routeName, (route) => false);
            //     },
            //     style: TextButton.styleFrom(
            //       primary: Colors.black,
            //       textStyle: const TextStyle(fontSize: 18),
            //     ),
            //     child: const Text(
            //       "Skip >>",
            //       style: TextStyle(
            //         fontFamily: fontFamily,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Column welcomeMessage(double screenHeight) {
    return Column(
      children: [
        const Text(
          "Welcome",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontFamily: fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        const Text(
          "Sapien sapien ut integer at risus. Dis dignissim habitasse mattis aliquam maecenas ut vel metus.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Column discoverMessage(double screenHeight) {
    return Column(
      children: [
        const Text(
          "Discover",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        const Text(
          "Sapien sapien ut integer at risus. Dis dignissim habitasse mattis aliquam maecenas ut vel metus.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Column saveMessage(double screenHeight) {
    return Column(
      children: [
        const Text(
          "Save",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontFamily: fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        const Text(
          "Sapien sapien ut integer at risus. Dis dignissim habitasse mattis aliquam maecenas ut vel metus.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Column applyMessage(double screenHeight) {
    return Column(
      children: [
        const Text(
          "Apply",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: screenHeight * 0.03),
        const Text(
          "Sapien sapien ut integer at risus. Dis dignissim habitasse mattis aliquam maecenas ut vel metus.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
