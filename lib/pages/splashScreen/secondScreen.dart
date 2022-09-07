import 'package:first_app/constants.dart';
import 'package:first_app/login/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

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
    super.initState();
    _pageController = PageController(initialPage: _activePage, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _activePage = _activePage + 1;
                      if (_activePage > 2) {
                        Navigator.pushNamed(context, MainPage.routeName);
                        _activePage = 2;
                        // Future.delayed(const Duration(seconds: 1));
                        // _activePage = 0;
                        // _pageController.jumpToPage(_activePage);
                      } else {
                        _pageController.animateToPage(_activePage,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.linear);
                      }
                    });
                  },
                  child: SizedBox(
                    child: Row(
                      children: const [
                        Text(
                          "Next ",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        Icon(Icons.keyboard_double_arrow_right),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.75,
              child: PageView(
                controller: _pageController,
                pageSnapping: true,
                onPageChanged: (value) {
                  setState(() {
                    _activePage = value;
                  });
                },
                children: [
                  screenContent(
                      screenWidth,
                      screenHeight,
                      "One Day or Day One",
                      "You can build your best pitch and launch a new chapter in your career.",
                      "asset/images/illustration/blog.svg"),
                  screenContent(
                    screenWidth,
                    screenHeight,
                    "Finding your way",
                    "We take you further than you've ever been by connecting you to the Artistic world",
                    "asset/images/illustration/fg.png",
                  ),
                  screenContent(
                    screenWidth,
                    screenHeight,
                    "The Big Break",
                    "Taking you closer than ever to your dream job",
                    "asset/images/illustration/d.svg",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.07,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.all(3),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _activePage == index
                        ? secondoryColor
                        : const Color(0xFFF9D422).withOpacity(0.5),
                  ),
                );
              }),
            ),
          ],
        ),
      ),

      // body: GestureDetector(
      // onTap: _activePage == 3
      //     ? () {
      //         Navigator.pushNamed(context, MainPage.routeName);
      //       }
      //     : () {
      //         setState(() {
      //           _activePage = _activePage + 1;
      //           _pageController.animateToPage(_activePage,
      //               duration: const Duration(milliseconds: 500),
      //               curve: Curves.linear);
      //         });
      //       },
      //   child: Stack(
      //     children: [
      //       SizedBox(
      //         width: screenWidth,
      //         height: screenHeight,
      //         child: Image.asset("asset/images/uiImages/splashScreen2.png",
      //             fit: BoxFit.cover),
      //       ),
      //       Container(
      //         width: screenWidth,
      //         height: screenHeight,
      //         color: Colors.black26,
      //       ),
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         crossAxisAlignment: CrossAxisAlignment.stretch,
      //         children: [
      //           Padding(
      //             padding: EdgeInsets.only(top: screenHeight * 0.10),
      //             child: const Text(
      //               "Audition Portal",
      //               textAlign: TextAlign.center,
      //               style: TextStyle(
      //                 fontSize: 45,
      //                 fontFamily: fontFamily,
      //                 color: Colors.white,
      //               ),
      //             ),
      //           ),
      //           SizedBox(
      //             width: screenHeight,
      //             height: screenWidth,
      //             child: Padding(
      //               padding: EdgeInsets.only(
      //                   left: screenWidth * 0.05,
      //                   right: screenWidth * 0.05,
      //                   top: screenHeight * 0.173),
      //               child: PageView(
      //                 controller: _pageController,
      //                 pageSnapping: true,
      //                 children: [
      //                   welcomeMessage(screenHeight),
      //                   discoverMessage(screenHeight),
      //                   saveMessage(screenHeight),
      //                   applyMessage(screenHeight),
      //                   const Text(""),
      //                 ],
      //                 onPageChanged: (value) {
      //                   value > 3
      //                       ? Navigator.pushNamed(context, MainPage.routeName)
      //                       : setState(() {
      //                           _activePage = value;
      //                         });
      //                 },
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //       Positioned(
      //         bottom: screenHeight * 0.105,
      //         left: (screenWidth - 70) / 2,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: List<Widget>.generate(4, (index) {
      //             return Container(
      //                 margin: const EdgeInsets.all(3),
      //                 width: _activePage == index ? 30 : 8,
      //                 height: 8,
      //                 decoration: _activePage == index
      //                     ? BoxDecoration(
      //                         borderRadius: BorderRadius.circular(10),
      //                         color: Colors.black,
      //                       )
      //                     : BoxDecoration(
      //                         shape: BoxShape.circle,
      //                         color: Colors.grey.shade700,
      //                       ));
      //           }),
      //         ),
      //       ),
      //       // Positioned(
      //       //   top: screenHeight * 0.04,
      //       //   right: 0,
      //       //   child: TextButton(
      //       //     onPressed: () {
      //       //       Navigator.pushNamedAndRemoveUntil(
      //       //           context, MainPage.routeName, (route) => false);
      //       //     },
      //       //     style: TextButton.styleFrom(
      //       //       primary: Colors.black,
      //       //       textStyle: const TextStyle(fontSize: 18),
      //       //     ),
      //       //     child: const Text(
      //       //       "Skip >>",
      //       //       style: TextStyle(
      //       //         fontFamily: fontFamily,
      //       //       ),
      //       //     ),
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // ),
    );
  }

  Column screenContent(double screenWidth, double screenHeight, String text1,
      String text2, String image) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.12, vertical: screenHeight * 0.07),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Text(
                text2,
                style: const TextStyle(
                  fontSize: 15,
                  color: placeholderTextColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: screenWidth,
          height: screenWidth,
          child: image == "asset/images/illustration/fg.png"
              ? Transform.scale(
                  scale: 1.2,
                  child: Image.asset("asset/images/illustration/abcd.png"),
                )
              : Transform.scale(scale: 1, child: SvgPicture.asset(image)),
        ),
      ],
    );
  }
}
