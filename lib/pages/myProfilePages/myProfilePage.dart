import 'package:first_app/common/data.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/myProfilePages/detailMenuPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/basicInfoPage.dart';
import 'package:first_app/pages/myProfilePages/mediaPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  static const String routeName = "/myProfile-page";

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: screenHeight * 0.10, left: 25, right: 25),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: screenWidth,
                      height: screenHeight * 0.15,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFFFDF5F2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Leslie Alexander",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const Text(
                            "Your Profile Strength",
                            style: TextStyle(color: Color(0xFF979797)),
                          ),
                          Container(
                            height: screenHeight * 0.035,
                            width: screenWidth * 0.50,
                            margin: const EdgeInsets.only(top: 20),
                            child: TabBar(
                              controller: _tabController,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                              indicatorColor: const Color(0xFF30319D),
                              labelColor: const Color(0xFF30319D),
                              unselectedLabelColor: Colors.black,
                              indicatorSize: TabBarIndicatorSize.label,
                              tabs: const [
                                Tab(
                                  text: "Details",
                                ),
                                Tab(
                                  text: "Media",
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.03, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(MyFlutterApp.camera_black),
                        Icon(MyFlutterApp.edit_black),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -screenHeight * 0.08,
                    left: (screenWidth / 2) - (screenHeight * 0.05) - 25,
                    child: CircleAvatar(
                      radius: screenHeight * 0.05,
                      child: ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.circular(100),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                                "asset/images/uiImages/girlFace.jpg",
                                fit: BoxFit.cover),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              height: screenHeight * 0.54,
              margin: const EdgeInsets.only(top: 15),
              child: TabBarView(
                controller: _tabController,
                children: const [
                  DetailMenuPage(),
                  MediaProfilePage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
