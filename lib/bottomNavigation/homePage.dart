import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/pages/categorySection/categoryDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

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
      body: SafeArea(
        child: SingleChildScrollView(
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
                          top: screenHeight * 0.085,
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
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10),
              //       child: InkWell(
              //         onTap: () {
              //           Navigator.pushNamed(context, CategoryDetailPage.routeName,
              //               arguments: 0);
              //         },
              //         child: gridContainer(categoryData[0]),
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10),
              //       child: InkWell(
              //           onTap: () {
              //             Navigator.pushNamed(
              //                 context, CategoryDetailPage.routeName,
              //                 arguments: 1);
              //           },
              //           child: gridContainer(categoryData[1])),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10),
              //       child: InkWell(
              //           onTap: () {
              //             Navigator.pushNamed(
              //                 context, CategoryDetailPage.routeName,
              //                 arguments: 2);
              //           },
              //           child: gridContainer(categoryData[2])),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 20),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10),
              //       child: InkWell(
              //           onTap: () {
              //             Navigator.pushNamed(
              //                 context, CategoryDetailPage.routeName,
              //                 arguments: 3);
              //           },
              //           child: gridContainer(categoryData[3])),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10),
              //       child: InkWell(
              //           onTap: () {
              //             Navigator.pushNamed(
              //                 context, CategoryDetailPage.routeName,
              //                 arguments: 4);
              //           },
              //           child: gridContainer(categoryData[4])),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.only(left: 10),
              //       child: InkWell(
              //           onTap: () {
              //             Navigator.pushNamed(
              //                 context, CategoryDetailPage.routeName,
              //                 arguments: 5);
              //           },
              //           child: gridContainer(categoryData[5])),
              //     ),
              //   ],
              // ),
              SizedBox(height: screenHeight * 0.01),
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.628,
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.01),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: screenWidth * 0.02,
                    mainAxisSpacing: screenHeight * 0.03,
                    mainAxisExtent: screenHeight * 0.18,
                  ),
                  itemCount: categoryData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, CategoryDetailPage.routeName,
                            arguments: index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: placeholderColor,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(2, 2),
                              blurRadius: 5,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.01,
                          right: screenWidth * 0.01,
                          top: screenHeight * 0.01,
                        ),
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                  "asset/images/categoryImages/${categoryData[index]}.png"),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(categoryData[index]),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: screenHeight * 0.04),
              // SizedBox(
              //   width: screenWidth,
              //   height: screenWidth * 0.15,
              //   // color: Colors.orange,
              //   child: Stack(
              //     fit: StackFit.loose,
              //     alignment: Alignment.center,
              //     children: [
              //       const Divider(
              //         color: Colors.grey,
              //         thickness: 2,
              //       ),
              //       Container(
              //         width: screenWidth * 0.13,
              //         height: 3,
              //         decoration: const BoxDecoration(
              //           shape: BoxShape.rectangle,
              //           color: Colors.white,
              //         ),
              //       ),
              //       Container(
              //         width: screenWidth * 0.09,
              //         height: screenWidth * 0.09,
              //         decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           border: Border.all(
              //             color: Colors.grey,
              //           ),
              //           color: Colors.white,
              //         ),
              //       ),
              //       Lottie.asset(
              //         "asset/lottie/down-arrow.json",
              //         width: screenWidth * 0.15,
              //         height: screenWidth * 0.15,
              //       )
              //     ],
              //   ),
              // ),
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
              seeAllContainer(screenWidth, screenHeight),
              SizedBox(
                height: screenHeight * 0.365,
                child: ListView(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
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
                    textContainer(
                        screenWidth,
                        screenHeight,
                        "Tincidunt dui elit eu",
                        "Venenatis sed pell",
                        "Dancer",
                        "black_dance"),
                    textContainer(
                        screenWidth,
                        screenHeight,
                        "Ac rhoncus, sit aenean",
                        "Rutrum ut vulputate nulla",
                        "Actor",
                        "black_band"),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              Container(
                padding: EdgeInsets.only(left: screenWidth * 0.04),
                width: screenWidth,
                height: screenHeight * 0.035,
                child: const Text(
                  "More",
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              seeAllContainer(screenWidth, screenHeight),
              SizedBox(
                height: screenHeight * 0.365,
                child: ListView(
                  padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [
                    textContainer(
                        screenWidth,
                        screenHeight,
                        "Tincidunt commodo",
                        "Tristique ac sit bibendum",
                        "Musician",
                        "red_shooting"),
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
      ),
    );
  }

  Container seeAllContainer(double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.only(
          right: screenWidth * 0.07, bottom: screenHeight * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          Text(
            "See All",
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: thirdColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget gridContainer(String name) {
    return Material(
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
    );
  }
}
