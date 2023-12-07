import 'package:auto_size_text/auto_size_text.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/login/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

import '../../static_data.dart';

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

  void _changePage() {
    if (_pageController.page == 2) {
      Navigator.pushNamed(context, LoginPage.routeName);
    }
    _pageController.nextPage(
        duration: const Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var width = mediaQuery.size.width;
    var height = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: height * 0.65,
              child: Stack(
                children: [
                  Container(
                    width: width,
                    child: Image.asset(
                      "asset/images/uiImages/splashScreen.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: width,
                      height: height * 0.53,
                      child: PageView.builder(
                        itemCount: 3,
                        onPageChanged: (value) {
                          setState(() {
                            _activePage = value;
                          });
                        },
                        controller: _pageController,
                        itemBuilder: (context, index) => PageViewItem(
                          width: width,
                          height: height,
                          index: index,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: width * (_activePage == 0 ? 0.08 : 0.05),
                  height: width * 0.03,
                  decoration: BoxDecoration(
                    color: _activePage == 0
                        ? const Color(0xff244330)
                        : const Color(0xffD6D6D6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(width: width * 0.025),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: width * (_activePage == 1 ? 0.08 : 0.05),
                  height: width * 0.03,
                  decoration: BoxDecoration(
                    color: _activePage == 1
                        ? const Color(0xff244330)
                        : const Color(0xffD6D6D6),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                SizedBox(width: width * 0.025),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: width * (_activePage == 2 ? 0.08 : 0.05),
                  height: width * 0.03,
                  decoration: BoxDecoration(
                    color: _activePage == 2
                        ? const Color(0xff244330)
                        : const Color(0xffD6D6D6),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 0.05),
            InkWell(
              onTap: () => _changePage(),
              child: Container(
                width: width * 0.7,
                height: height * 0.065,
                decoration: BoxDecoration(
                  color: Color(0xff244330),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: AutoSizeText(
                  "NEXT",
                  maxLines: 1,
                  maxFontSize: 20,
                  minFontSize: 16,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
            bottom: screenHeight * 0.05,
          ),
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

class PageViewItem extends StatelessWidget {
  final double width;
  final double height;
  const PageViewItem({
    super.key,
    required this.width,
    required this.height,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: width,
          height: height * 0.43,
          alignment: Alignment.center,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: SizedBox(
                  width: width,
                  height: height * 0.4,
                  child: Image.asset(
                    splashScreenData[index].values.toList()[0],
                    // "asset/images/illustration/screen1.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: width,
                  height: height * 0.05,
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    splashScreenData[index].values.toList()[1],
                    // "One Day or Day One",
                    maxLines: 1,
                    maxFontSize: 30,
                    minFontSize: 20,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: thirdColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: width,
          height: height * 0.1,
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          alignment: Alignment.center,
          child: AutoSizeText(
            splashScreenData[index].values.toList()[2],
            // "You can build your best pitch and\nlaunch a new chapter in your career.",
            textAlign: TextAlign.center,
            maxLines: 2,
            maxFontSize: 16,
            minFontSize: 12,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xff4F647A),
            ),
          ),
        ),
      ],
    );
  }
}
