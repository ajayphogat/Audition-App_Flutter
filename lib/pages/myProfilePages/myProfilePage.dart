import 'package:first_app/common/common.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/myProfilePages/detailMenuPage.dart';
import 'package:first_app/pages/myProfilePages/mediaPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
                top: screenHeight * 0.10,
                left: screenWidth * 0.0636,
                right: screenWidth * 0.0636,
              ),
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
                        color: placeholderColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(
                            "Leslie Alexander",
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: fontFamily,
                            ),
                          ),
                          const Text(
                            "Your Profile Strength",
                            style: TextStyle(
                              color: placeholderTextColor,
                              fontFamily: fontFamily,
                            ),
                          ),
                          Container(
                            height: screenHeight * 0.035,
                            width: screenWidth * 0.50,
                            margin: const EdgeInsets.only(top: 20),
                            child: TabBar(
                              controller: _tabController,
                              labelStyle: const TextStyle(
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.w500,
                              ),
                              indicatorColor: thirdColor,
                              labelColor: thirdColor,
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
                  Positioned(
                    top: -screenHeight * 0.08,
                    left: (screenWidth / 2) - (screenHeight * 0.05) - 25,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: screenHeight * 0.05,
                          child: ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            borderRadius: BorderRadius.circular(100),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                  "asset/images/uiImages/girlFace.jpg",
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: screenWidth * 0.065,
                            height: screenWidth * 0.065,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              MyFlutterApp.camera_black,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: PopupMenuButton(
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset("asset/icons/vertical_menu.svg"),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            height: 25,
                            child: const Text("Report"),
                            onTap: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                newDialogBox(context, screenWidth, screenHeight,
                                    "Account Reported!", "GO BACK", false, "");
                              });
                            },
                          ),
                        ];
                      },
                      offset: Offset(0, screenHeight * 0.042),
                    ),
                  ),
                ],
              ),
            ),
            // Divider(
            //   color: Colors.grey.shade300,
            //   thickness: 10,
            // ),
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
