import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:flutter/material.dart';

class SHomePage extends StatefulWidget {
  const SHomePage({Key? key}) : super(key: key);

  static const String routeName = "/shome-page";

  @override
  State<SHomePage> createState() => _SHomePageState();
}

class _SHomePageState extends State<SHomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: screenHeight * 0.10,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(MyFlutterApp.bi_arrow_down, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Container(
                        height: screenHeight * 0.10,
                        alignment: Alignment.center,
                        child: const Text(
                          "Filter Area is under Construction",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  });
            },
            icon:
                const Icon(MyFlutterApp.filter, color: Colors.black, size: 30),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.01),
          child: Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.02),
            child: const Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.04,
                  top: screenHeight * 0.03,
                  bottom: screenHeight * 0.015),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.04,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      clipBehavior: Clip.hardEdge,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(
                          "asset/images/uiImages/girlFace.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  const Text(
                    "Name of Studio",
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
              ),
              child: Row(
                children: const [
                  Text(
                    "Hey! let's dive into\nthe details",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth,
              height: screenHeight,
              margin: EdgeInsets.only(
                top: screenHeight * 0.02,
              ),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 5,
                    offset: Offset(1, 0),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: secondoryColor,
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.04,
                            horizontal: screenWidth * 0.10),
                        child: Image.asset("asset/icons/graph.png"),
                      ),
                      Positioned(
                        top: screenHeight * 0.15,
                        left: screenWidth * 0.085,
                        child: const RotatedBox(
                          quarterTurns: -1,
                          child: Text(
                            "Pages",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: screenHeight * 0.345,
                        left: (screenWidth - 40) / 2,
                        child: const Text(
                          "Timeline",
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.05, bottom: screenHeight * 0.01),
                    child: Row(
                      children: const [
                        Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.18,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.01),
                      children: [
                        newVerticalContainer(screenWidth, screenHeight,
                            "Number of posted jobs", "45"),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        newVerticalContainer(screenWidth, screenHeight,
                            "Number of application received", "300"),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        newVerticalContainer(screenWidth, screenHeight,
                            "Number of application shortlisted", "37"),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        newVerticalContainer(screenWidth, screenHeight,
                            "Number of posted jobs", "45"),
                      ],
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

  Material newVerticalContainer(
      double screenWidth, double screenHeight, String text1, String text2) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 4,
      child: Container(
        width: screenWidth * 0.25,
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              text1,
              textAlign: TextAlign.center,
            ),
            Text(
              text2,
              style: const TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Widget gridContainer(String name) {
  //   return Material(
  //     borderRadius: BorderRadius.circular(10),
  //     elevation: 5,
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
  //       width: (MediaQuery.of(context).size.width - 40) / 3,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         color: const Color(0xFFFDF5F2),
  //       ),
  //       child: Column(
  //         children: [
  //           AspectRatio(
  //               aspectRatio: 0.89,
  //               child: Image.asset("asset/images/categoryImages/$name.png")),
  //           const SizedBox(height: 5),
  //           Text(
  //             name,
  //             style: const TextStyle(
  //               fontSize: 14,
  //               fontFamily: fontFamily,
  //             ),
  //           ),
  //           const SizedBox(height: 5),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
