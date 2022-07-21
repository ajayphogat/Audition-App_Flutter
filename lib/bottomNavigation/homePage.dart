import 'package:first_app/common/data.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
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
                            fontSize: 35,
                          ),
                        ),
                        const Text(
                          "Welcome.........",
                          style: TextStyle(
                            color: Color(0xFF979797),
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
                                  color: Color(0xFF979797),
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: screenHeight * 0.30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: screenWidth * 0.40,
                            height: screenHeight * 0.23,
                            color: Colors.orange,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Ac rhoncus, sit aenean",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            "Rutrum ut vulputate nulla",
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Actor",
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("Hello"),
          ],
        ),
      ),
    );
  }

  Widget gridContainer(String name) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 5,
      child: Container(
        width: (MediaQuery.of(context).size.width - 40) / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFDF5F2),
        ),
        child: Column(
          children: [
            AspectRatio(
                aspectRatio: 1,
                child: Image.asset("asset/images/categoryImages/$name.png")),
            Text(name),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
