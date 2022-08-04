import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/pages/categorySection/categoryDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = "/home-page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: SvgPicture.asset(
                        "asset/images/illustration/homePage_top_yellow.svg"),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.05,
                        right: screenWidth * 0.05,
                        top: screenHeight * 0.093,
                        bottom: screenHeight * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hi, John!",
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 35,
                          ),
                        ),
                        const Text(
                          "Welcome.........",
                          style: TextStyle(
                            fontFamily: fontFamily,
                            color: placeholderTextColor,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Search here....",
                                hintStyle: const TextStyle(
                                  fontSize: 18,
                                  color: placeholderTextColor,
                                ),
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 15),
                                  child: SvgPicture.asset(
                                      "asset/images/illustration/bytesize_search.svg"),
                                ),
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
            SizedBox(height: screenHeight * 0.02),
            Container(
              padding: EdgeInsets.only(left: screenWidth * 0.04),
              width: screenWidth,
              child: const Text(
                "Popular",
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: gridContainer(categoryData[0]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: gridContainer(categoryData[1]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: gridContainer(categoryData[2]),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: gridContainer(categoryData[3]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: gridContainer(categoryData[4]),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: gridContainer(categoryData[5]),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: (screenWidth / 2) - 25,
                  height: 2,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SvgPicture.asset("asset/icons/down_arrow.svg",
                        color: Colors.grey),
                  ],
                ),
                Container(
                  width: (screenWidth / 2) - 25,
                  height: 2,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: screenWidth * 0.04),
              width: screenWidth,
              child: const Text(
                "Recently",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: screenHeight * 0.263,
              child: ListView(
                //FIXME: implement screenWidth and screenHeight here in padding.
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  textContainer(
                      screenWidth,
                      screenHeight,
                      "Ac rhoncus, sit aenean",
                      "Rutrum ut vulputate nulla",
                      "Actor",
                      "green_work"),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: textContainer(
                        screenWidth,
                        screenHeight,
                        "Tincidunt dui elit eu",
                        "Venenatis sed pell",
                        "Dancer",
                        "black_dance"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: textContainer(
                        screenWidth,
                        screenHeight,
                        "Ac rhoncus, sit aenean",
                        "Rutrum ut vulputate nulla",
                        "Actor",
                        "black_band"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.only(left: screenWidth * 0.04),
              width: screenWidth,
              child: const Text(
                "More",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: screenHeight * 0.263,
              child: ListView(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  textContainer(screenWidth, screenHeight, "Tincidunt commodo",
                      "Tristique ac sit bibendum", "Musician", "red_shooting"),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: textContainer(
                        screenWidth,
                        screenHeight,
                        "Lesi a imperdiet",
                        "Magna egpulvinar eget",
                        "Dancer",
                        "white_dress_dance"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: textContainer(
                        screenWidth,
                        screenHeight,
                        "Ac rhoncus aenean",
                        "Diam enim, lacus, amet",
                        "Musician",
                        "colorfull_band"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget gridContainer(String name) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CategoryDetailPage.routeName);
      },
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 5,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          width: (MediaQuery.of(context).size.width - 40) / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFFDF5F2),
          ),
          child: Column(
            children: [
              AspectRatio(
                  aspectRatio: 0.89,
                  child: Image.asset("asset/images/categoryImages/$name.png")),
              const SizedBox(height: 5),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: fontFamily,
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
