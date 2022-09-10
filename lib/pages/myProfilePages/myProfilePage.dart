import 'package:first_app/common/common.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/myProfilePages/detailPages/appearancePage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/basicInfoPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/createProfilePage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/creditsPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/membershipPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/skillsPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/socialMediaPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/subscriptionPage.dart';
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
  bool short = true;

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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight * 0.55,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                  ),
                  child: Image.asset(
                    "asset/images/uiImages/actor.jpg",
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.03,
                margin: EdgeInsets.only(
                    top: screenHeight * 0.02,
                    left: screenWidth * 0.20,
                    right: screenWidth * 0.20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: const Text(
                        "Details",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, MediaProfilePage.routeName);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        child: const Text(
                          "Media",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.bookmark_border_rounded,
                            color: placeholderTextColor,
                            size: 30,
                          ),
                          SizedBox(
                            width: screenWidth * 0.01,
                          ),
                          const Text(
                            "Save",
                            style: TextStyle(
                              color: placeholderTextColor,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.file_upload_outlined,
                            color: placeholderTextColor,
                            size: 30,
                          ),
                          SizedBox(
                            width: screenWidth * 0.01,
                          ),
                          const Text(
                            "Share",
                            style: TextStyle(
                              color: placeholderTextColor,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                            "asset/icons/switchuser.svg",
                            color: placeholderTextColor,
                          ),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          const Text(
                            "Switch Account",
                            style: TextStyle(
                              color: placeholderTextColor,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "Leslie Alexander",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        const Text(
                          "(Actor)",
                          style: TextStyle(
                            color: placeholderTextColor,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        const Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam diam sapien, elementum ut lectus quis, dignissim pretium ex. Duis gravida enim a ultricies vestibulum. Quisque dignissim posuere rutrum. Integer et neque sit amet sapien viverra lobortis ac vitae lacus.",
                          style: TextStyle(
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: short,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          short = !short;
                        });
                      },
                      child: Container(
                        width: screenWidth,
                        height: screenHeight * 0.08,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Read More",
                              style: TextStyle(fontSize: 18),
                            ),
                            Icon(
                              MyFlutterApp.arrow_down_2,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: short
                        ? []
                        : [
                            SizedBox(height: screenHeight * 0.01),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight * 0.02,
                                  left: screenWidth * 0.0636,
                                  right: screenWidth * 0.0636),
                              child: Column(
                                children: [
                                  normalTitles(screenHeight, context,
                                      "Basic Info", BasicInfoPage.routeName),
                                  SizedBox(height: screenHeight * 0.008),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Name", "Leslie Alexander"),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Gender", "Female"),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Location", "4866 Durgan Manor"),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Profile URL", "https://kira.name"),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Working Title", "Actor"),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.0636,
                                  right: screenWidth * 0.0636),
                              child: Column(
                                children: [
                                  normalTitles(screenHeight, context,
                                      "Appearance", AppearancePage.routeName),
                                  SizedBox(height: screenHeight * 0.008),
                                  smallSubTitles(
                                      screenWidth, screenHeight, "Age", "25"),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Height", "5.4\""),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Weight", "45"),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Body type", "Diamond"),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Hair Color", "Brown"),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Eye Color", "Brown"),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.0636,
                                  right: screenWidth * 0.0636),
                              child: Column(
                                children: [
                                  normalTitles(
                                      screenHeight,
                                      context,
                                      "Website/Social Media",
                                      SocialMediaPage.routeName),
                                  SizedBox(height: screenHeight * 0.008),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const Text(
                                        "http://clementina.info",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.005),
                                      const Text(
                                        "https://axel.biz",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.005),
                                      const Text(
                                        "https://elliot.name",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.005),
                                      const Text(
                                        "https://esteil.name",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.0636,
                                  right: screenWidth * 0.0636),
                              child: Column(
                                children: [
                                  normalTitles(
                                      screenHeight,
                                      context,
                                      "Union Membership",
                                      MembershipPage.routeName),
                                  SizedBox(height: screenHeight * 0.008),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Text("Equity (U.S.)", style: textStyle),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.0636,
                                  right: screenWidth * 0.0636),
                              child: Column(
                                children: [
                                  normalTitles(screenHeight, context, "Skills",
                                      SkillsPage.routeName),
                                  SizedBox(height: screenHeight * 0.008),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const Text("Ability to take direction",
                                          style: textStyle),
                                      SizedBox(height: screenHeight * 0.005),
                                      const Text(
                                          "Ability to work as a team and also individually",
                                          style: textStyle),
                                      SizedBox(height: screenHeight * 0.005),
                                      const Text("Reliability",
                                          style: textStyle),
                                      SizedBox(height: screenHeight * 0.005),
                                      const Text("Good time keeping skills",
                                          style: textStyle),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.0636,
                                  right: screenWidth * 0.0636),
                              child: Column(
                                children: [
                                  normalTitles(screenHeight, context, "Credits",
                                      CreditsPage.routeName),
                                  SizedBox(height: screenHeight * 0.008),
                                  const SizedBox(
                                    child: Text(
                                        "Add credits from your past performance and jobs in the entertainment industry.",
                                        style: textStyle),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, SubscriptionPage.routeName);
                                },
                                child: simpleArrowColumn(
                                    screenHeight, screenWidth, "Subscription")),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, CreateProfilePage.routeName);
                              },
                              child: simpleArrowColumn(screenHeight,
                                  screenWidth, "Create Another Profile"),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  short = !short;
                                });
                              },
                              child: Container(
                                width: screenWidth,
                                height: screenHeight * 0.08,
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Read Less",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_up_outlined,
                                      size: 28,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column simpleArrowColumn(
      double screenHeight, double screenWidth, String text) {
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.01),
        Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.0636, right: screenWidth * 0.0636),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: screenHeight * 0.0235),
              ),
              const Icon(MyFlutterApp.arrow_right_2),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
      ],
    );
  }

  Row smallSubTitles(
      double screenWidth, double screenHeight, String text1, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: ((screenWidth - ((screenWidth * 0.0636) * 2)) / 2) -
              screenWidth * 0.0636,
          alignment: Alignment.centerLeft,
          child: Text(text1, style: textStyle),
        ),
        Container(
          width: ((screenWidth - ((screenWidth * 0.0636) * 2)) / 2) +
              screenWidth * 0.0636,
          alignment: Alignment.centerLeft,
          child: Text(text2, style: textStyle),
        ),
      ],
    );
  }

  Row normalTitles(double screenHeight, BuildContext context, String text,
      String routeName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: screenHeight * 0.0235),
        ),
        IconButton(
          icon: Icon(MyFlutterApp.edit_black, size: screenHeight * 0.02),
          onPressed: () {
            Navigator.pushNamed(context, routeName);
          },
        ),
      ],
    );
  }
}
