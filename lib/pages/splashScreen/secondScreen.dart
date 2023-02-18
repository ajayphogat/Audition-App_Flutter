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
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.80,
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
            // SizedBox(
            //   height: screenHeight * 0.07,
            // ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List<Widget>.generate(3, (index) {
                      return Container(
                        margin: const EdgeInsets.all(3),
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _activePage == index
                              ? thirdColor
                              : const Color(0xFF30319D).withOpacity(0.5),
                        ),
                      );
                    }),
                  ),
                  InkWell(
                    onTap: () async {
                      _activePage = _activePage + 1;

                      if (_activePage > 2) {
                        // setState(() {
                        _activePage = 2;
                        Navigator.pushNamed(context, MainPage.routeName);
                        // });

                      } else {
                        await _pageController.nextPage(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.decelerate);
                        // await _pageController.animateToPage(_activePage,
                        //     duration: const Duration(milliseconds: 200),
                        //     curve: Curves.linear);
                      }
                    },
                    child: Container(
                      width: screenWidth * 0.14,
                      height: screenWidth * 0.14,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: thirdColor,
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
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

  Column screenContent(double screenWidth, double screenHeight, String text1,
      String text2, String image) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.08,
              right: screenWidth * 0.16,
              top: screenHeight * 0.15,
              bottom: screenHeight * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text1,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: thirdColor,
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
