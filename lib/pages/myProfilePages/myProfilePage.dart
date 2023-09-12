import 'dart:io';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/myProfilePages/detailPages/appearancePage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/basicInfoPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/creditsPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/membershipPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/skillsPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/socialMediaPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/subscriptionPage.dart';
import 'package:first_app/provider/studio_provider.dart';
import 'package:first_app/utils/bottom_gallary_up.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/user_provider.dart';

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
  File? profilePic;

  late TextEditingController _bioController;
  final AuthService authService = AuthService();

  final _firebaseStorage = FirebaseStorage.instance;

  Future<void> changeBio() async {
    await authService.changeBio(bio: _bioController.text, context: context);
  }

  Future<void> switchToStudio() async {
    await authService.switchToStudio(context: context);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _bioController = TextEditingController();
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
    var user = Provider.of<UserProvider>(context).user;
    var studioUser = Provider.of<StudioProvider>(context).user;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset("asset/images/uiImages/Home.png"),
                  Column(
                    children: [
                      Container(
                        width: screenWidth,
                        height: screenHeight * 0.0689,
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025),
                        decoration: const BoxDecoration(
                          // color: Colors.red,
                          image: DecorationImage(
                            image: AssetImage(
                              "asset/images/uiImages/media_appbar.png",
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_sharp,
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            AutoSizeText(
                              studioUser.id.isNotEmpty
                                  ? "Details"
                                  : "My Details",
                              maxFontSize: 22,
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025),
                        child: Column(
                          children: [
                            SizedBox(height: screenHeight * 0.02),
                            ListTile(
                              horizontalTitleGap: 0,
                              leading: user.profilePic.isEmpty
                                  ? InkWell(
                                      onTap: studioUser.id.isNotEmpty
                                          ? null
                                          : () {
                                              BottomMediaUp().showPicker(
                                                  context, user.id, "audition");
                                            },
                                      child: CircleAvatar(
                                        radius: screenWidth * 0.08,
                                        backgroundColor: Colors.black,
                                      ),
                                    )
                                  : InkWell(
                                      onTap: studioUser.id.isNotEmpty
                                          ? null
                                          : () {
                                              BottomMediaUp().showPicker(
                                                  context, user.id, "audition");
                                            },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: secondoryColor,
                                            width: 3,
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        padding: EdgeInsets.all(3),
                                        child: CircleAvatar(
                                          radius: screenWidth * 0.1,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                            user.profilePic,
                                          ),
                                        ),
                                      ),
                                    ),
                              title: AutoSizeText(
                                user.fname,
                                maxFontSize: 20,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: AutoSizeText(
                                user.bio.isEmpty ? "Empty" : user.bio,
                                maxFontSize: 12,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: user.bio.isEmpty
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                              trailing: studioUser.id.isNotEmpty
                                  ? null
                                  : InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, BasicInfoPage.routeName);
                                      },
                                      child: AutoSizeText(
                                        "Edit",
                                        maxFontSize: 12,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            Divider(
                              height: 0,
                              thickness: 1,
                              color: Colors.black12,
                              indent: screenWidth * 0.05,
                              endIndent: screenWidth * 0.05,
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        "Age",
                                        maxFontSize: 12,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black26,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      AutoSizeText(
                                        user.age.isEmpty
                                            ? "Empty"
                                            : "${user.age} years",
                                        maxFontSize: 16,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: user.age.isEmpty
                                              ? Colors.grey
                                              : Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        "Height",
                                        maxFontSize: 12,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black26,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      AutoSizeText(
                                        user.height.isEmpty
                                            ? "Empty"
                                            : user.height,
                                        maxFontSize: 16,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: user.height.isEmpty
                                              ? Colors.grey
                                              : Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AutoSizeText(
                                        "Weight",
                                        maxFontSize: 12,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black26,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      AutoSizeText(
                                        user.weight.isEmpty
                                            ? "Empty"
                                            : "${user.weight} KG",
                                        maxFontSize: 16,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: user.weight.isEmpty
                                              ? Colors.grey
                                              : Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.04),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      studioUser.id.isNotEmpty
                          ? Container()
                          : Card(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.025,
                                  vertical: screenHeight * 0.015,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      "Subscription",
                                      maxFontSize: 16,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    AutoSizeText(
                                      user.subscriptionName == "Free"
                                          ? "You are currently using the monthly ${user.subscriptionName} plan. Upgrade your subscription plan to continue using the app."
                                          : "You are currently using the monthly ${user.subscriptionName} plan.",
                                      maxFontSize: 12,
                                      minFontSize: 10,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                SubscriptionPage.routeName);
                                          },
                                          child: Container(
                                            width: screenWidth * 0.4,
                                            height: screenHeight * 0.04,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: greenColor,
                                            ),
                                            alignment: Alignment.center,
                                            child: AutoSizeText(
                                              "View plans",
                                              maxFontSize: 14,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      SizedBox(height: screenHeight * 0.015),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025,
                            vertical: screenHeight * 0.015,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeText(
                                    "About",
                                    maxFontSize: 16,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  studioUser.id.isNotEmpty
                                      ? Container()
                                      : AutoSizeText(
                                          "Edit",
                                          maxFontSize: 12,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              AutoSizeText(
                                "viverra elit. Dignissim tristique suspendisse proin vulputate ac. Viverra nunc erat adipiscing eget ultrices enim. Sit consectetur",
                                maxFontSize: 12,
                                minFontSize: 10,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      //TODO: document area is here
                      // Card(
                      //   child: Column(
                      //     children: [
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           AutoSizeText(
                      //             "Documents",
                      //             maxFontSize: 16,
                      //             style: TextStyle(
                      //               fontSize: 16,
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.bold,
                      //             ),
                      //           ),
                      //           Container(
                      //             width: screenWidth * 0.45,
                      //             height: screenHeight * 0.04,
                      //             decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(3),
                      //               border: Border.all(
                      //                 color: greenColor,
                      //                 width: 2,
                      //               ),
                      //             ),
                      //             child: Row(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 SizedBox(
                      //                   // color: Colors.red,
                      //                   width: screenWidth * 0.05,
                      //                   height: screenHeight * 0.02,
                      //                   child: FittedBox(
                      //                     child: Icon(
                      //                       Icons.add,
                      //                       color: greenColor,
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 AutoSizeText(
                      //                   "Add Documents",
                      //                   maxFontSize: 16,
                      //                   minFontSize: 14,
                      //                   style: TextStyle(
                      //                     fontSize: 16,
                      //                     color: greenColor,
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ],
                      //       ),
                      //       Row(),
                      //     ],
                      //   ),
                      // ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025,
                            vertical: screenHeight * 0.015,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeText(
                                    "Short bio",
                                    maxFontSize: 16,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  studioUser.id.isNotEmpty
                                      ? Container()
                                      : InkWell(
                                          onTap: () {
                                            _bioController.text = "";
                                            showBio(context, screenWidth,
                                                screenHeight);
                                          },
                                          child: AutoSizeText(
                                            "Edit",
                                            maxFontSize: 12,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              AutoSizeText(
                                user.bio.isEmpty ? "Empty" : user.bio,
                                maxFontSize: 12,
                                minFontSize: 10,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: user.bio.isEmpty
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025,
                            vertical: screenHeight * 0.015,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeText(
                                    "Info",
                                    maxFontSize: 16,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  studioUser.id.isNotEmpty
                                      ? Container()
                                      : InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                AppearancePage.routeName);
                                          },
                                          child: AutoSizeText(
                                            "Edit",
                                            maxFontSize: 12,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: screenWidth * 0.02,
                                    right: screenWidth * 0.4),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText(
                                          "Name",
                                          maxFontSize: 14,
                                          minFontSize: 10,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        AutoSizeText(
                                          user.fname,
                                          maxFontSize: 14,
                                          minFontSize: 10,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText(
                                          "Age",
                                          maxFontSize: 14,
                                          minFontSize: 10,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        AutoSizeText(
                                          user.age.isEmpty ? "Empty" : user.age,
                                          maxFontSize: 14,
                                          minFontSize: 10,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: user.age.isEmpty
                                                ? Colors.grey
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText(
                                          "Height",
                                          maxFontSize: 14,
                                          minFontSize: 10,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        AutoSizeText(
                                          user.height.isEmpty
                                              ? "Empty"
                                              : user.height,
                                          maxFontSize: 14,
                                          minFontSize: 10,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: user.height.isEmpty
                                                ? Colors.grey
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText(
                                          "Body type",
                                          maxFontSize: 14,
                                          minFontSize: 10,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        AutoSizeText(
                                          user.bodyType.isEmpty
                                              ? "Empty"
                                              : user.bodyType,
                                          maxFontSize: 14,
                                          minFontSize: 10,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: user.bodyType.isEmpty
                                                ? Colors.grey
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText(
                                          "Weight",
                                          maxFontSize: 14,
                                          minFontSize: 10,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        AutoSizeText(
                                          user.weight.isEmpty
                                              ? "Empty"
                                              : user.weight,
                                          maxFontSize: 14,
                                          minFontSize: 10,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: user.weight.isEmpty
                                                ? Colors.grey
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText(
                                          "Hair color",
                                          maxFontSize: 14,
                                          minFontSize: 10,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        AutoSizeText(
                                          user.hairColor.isEmpty
                                              ? "Empty"
                                              : user.hairColor,
                                          maxFontSize: 14,
                                          minFontSize: 10,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: user.hairColor.isEmpty
                                                ? Colors.grey
                                                : Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025,
                            vertical: screenHeight * 0.015,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const AutoSizeText(
                                    "Skills",
                                    maxFontSize: 16,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  studioUser.id.isNotEmpty
                                      ? Container()
                                      : InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, SkillsPage.routeName);
                                          },
                                          child: const AutoSizeText(
                                            "Edit",
                                            maxFontSize: 12,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Container(
                                width: screenWidth,
                                height: screenHeight * 0.035,
                                child: user.skills.length == 0
                                    ? AutoSizeText(
                                        "Empty",
                                        maxFontSize: 16,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: user.skills.length,
                                        itemBuilder: (context, index) =>
                                            Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.black38,
                                            ),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: screenWidth * 0.025),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.025),
                                          alignment: Alignment.center,
                                          child: AutoSizeText(
                                            user.skills[index],
                                            maxFontSize: 12,
                                            minFontSize: 10,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025,
                            vertical: screenHeight * 0.015,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const AutoSizeText(
                                    "Union Membership",
                                    maxFontSize: 16,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  studioUser.id.isNotEmpty
                                      ? Container()
                                      : InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                MembershipPage.routeName);
                                          },
                                          child: const AutoSizeText(
                                            "Edit",
                                            maxFontSize: 12,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              // Container(
                              //   width: screenWidth,
                              //   height: screenHeight * 0.035,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10),
                              //     border: Border.all(
                              //       color: Colors.black38,
                              //     ),
                              //   ),
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: screenWidth * 0.05),
                              //   alignment: Alignment.centerLeft,
                              //   child: AutoSizeText(
                              //     "https://www.abc.com",
                              //     maxFontSize: 12,
                              //     minFontSize: 10,
                              //     style: TextStyle(
                              //       fontSize: 12,
                              //       color: Colors.black,
                              //     ),
                              //   ),
                              // ),
                              Container(
                                width: screenWidth,
                                height: screenHeight * 0.035,
                                child: user.unionMembership.length == 0
                                    ? AutoSizeText(
                                        "Empty",
                                        maxFontSize: 16,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: user.unionMembership.length,
                                        itemBuilder: (context, index) =>
                                            Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.black38,
                                            ),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: screenWidth * 0.025),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.025),
                                          alignment: Alignment.center,
                                          child: AutoSizeText(
                                            user.unionMembership[index],
                                            maxFontSize: 12,
                                            minFontSize: 10,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                              SizedBox(height: screenHeight * 0.02),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025,
                            vertical: screenHeight * 0.015,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const AutoSizeText(
                                    "Social Media",
                                    maxFontSize: 16,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  studioUser.id.isNotEmpty
                                      ? Container()
                                      : InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                SocialMediaPage.routeName);
                                          },
                                          child: const AutoSizeText(
                                            "Edit",
                                            maxFontSize: 12,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Container(
                                width: screenWidth,
                                height: screenHeight * 0.035,
                                child: user.socialMedia.length == 0
                                    ? AutoSizeText(
                                        "Empty",
                                        maxFontSize: 16,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: user.socialMedia.length,
                                        itemBuilder: (context, index) =>
                                            Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.black38,
                                            ),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: screenWidth * 0.025),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.025),
                                          alignment: Alignment.center,
                                          child: AutoSizeText(
                                            user.socialMedia[index],
                                            maxFontSize: 12,
                                            minFontSize: 10,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                              // Container(
                              //   width: screenWidth,
                              //   height: screenHeight * 0.035,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10),
                              //     border: Border.all(
                              //       color: Colors.black38,
                              //     ),
                              //   ),
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: screenWidth * 0.05),
                              //   alignment: Alignment.centerLeft,
                              //   child: AutoSizeText(
                              //     "https://www.abc.com",
                              //     maxFontSize: 12,
                              //     minFontSize: 10,
                              //     style: TextStyle(
                              //       fontSize: 12,
                              //       color: Colors.black,
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(height: screenHeight * 0.01),
                              // Container(
                              //   width: screenWidth,
                              //   height: screenHeight * 0.035,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10),
                              //     border: Border.all(
                              //       color: Colors.black38,
                              //     ),
                              //   ),
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: screenWidth * 0.05),
                              //   alignment: Alignment.centerLeft,
                              //   child: AutoSizeText(
                              //     "https://www.abc.com",
                              //     maxFontSize: 12,
                              //     minFontSize: 10,
                              //     style: TextStyle(
                              //       fontSize: 12,
                              //       color: Colors.black,
                              //     ),
                              //   ),
                              // ),
                              SizedBox(height: screenHeight * 0.02),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025,
                            vertical: screenHeight * 0.015,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const AutoSizeText(
                                    "Credits",
                                    maxFontSize: 16,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  studioUser.id.isNotEmpty
                                      ? Container()
                                      : InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, CreditsPage.routeName);
                                          },
                                          child: const AutoSizeText(
                                            "Edit",
                                            maxFontSize: 12,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Container(
                                width: screenWidth,
                                height: screenHeight * 0.035,
                                child: user.credits.length == 0
                                    ? AutoSizeText(
                                        "Empty",
                                        maxFontSize: 16,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: user.credits.length,
                                        itemBuilder: (context, index) =>
                                            Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Colors.black38,
                                            ),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: screenWidth * 0.025),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.025),
                                          alignment: Alignment.center,
                                          child: AutoSizeText(
                                            user.credits[index],
                                            maxFontSize: 12,
                                            minFontSize: 10,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                              // AutoSizeText(
                              //   "viverra elit. Dignissim tristique suspendisse proin vulputate ac. Viverra nunc erat adipiscing eget ultrices enim. Sit consectetur",
                              //   maxFontSize: 12,
                              //   minFontSize: 10,
                              //   style: TextStyle(
                              //     fontSize: 12,
                              //     color: Colors.black,
                              //   ),
                              // ),
                              SizedBox(height: screenHeight * 0.02),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.015),
                      InkWell(
                        onTap: () async {
                          circularProgressIndicatorNew(context);
                          await AuthService().logoutUser(context);
                        },
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.025,
                              vertical: screenHeight * 0.015,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AutoSizeText(
                                  "Logout",
                                  maxFontSize: 16,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.logout,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Stack(children: [
                      //   Container(
                      //     width: screenWidth,
                      //     height: screenHeight * 0.55,
                      //     decoration: const BoxDecoration(
                      //       borderRadius: BorderRadius.only(
                      //         bottomLeft: Radius.circular(60),
                      //       ),
                      //     ),
                      //     child: ClipRRect(
                      //       borderRadius: const BorderRadius.only(
                      //         bottomLeft: Radius.circular(60),
                      //       ),
                      //       child: user.profilePic.isEmpty
                      //           ? Container(
                      //               color: Colors.black,
                      //             )
                      //           : Image.network(
                      //               user.profilePic,
                      //               fit: BoxFit.cover,
                      //             ),
                      //     ),
                      //   ),
                      //   Positioned(
                      //     right: 10,
                      //     top: screenHeight * 0.02,
                      //     child: InkWell(
                      //       onTap: () async {
                      //         BottomMediaUp().showPicker(context, user.id, "audition");
                      //       },
                      //       child: const Icon(
                      //         MyFlutterApp.camera_black,
                      //         color: placeholderTextColor,
                      //       ),
                      //     ),
                      //   )
                      // ]),

                      //FIXME: here is the code to integrate
                      // Container(
                      //   height: screenHeight * 0.03,
                      //   margin: EdgeInsets.only(
                      //       top: screenHeight * 0.02,
                      //       left: screenWidth * 0.20,
                      //       right: screenWidth * 0.20),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //     children: [
                      //       Container(
                      //         decoration: const BoxDecoration(
                      //           border: Border(
                      //             bottom: BorderSide(
                      //               color: Colors.black,
                      //             ),
                      //           ),
                      //         ),
                      //         child: const Text(
                      //           "Detail",
                      //           style: TextStyle(
                      //             fontSize: 16,
                      //           ),
                      //         ),
                      //       ),
                      //       InkWell(
                      //         onTap: () {
                      //           Navigator.pushNamed(
                      //               context, MediaProfilePage.routeName);
                      //         },
                      //         child: Container(
                      //           decoration: const BoxDecoration(
                      //             border: Border(
                      //               bottom: BorderSide(
                      //                 color: Colors.black,
                      //               ),
                      //             ),
                      //           ),
                      //           child: const Text(
                      //             "Media",
                      //             style: TextStyle(
                      //               fontSize: 16,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Column(
                      //   children: [
                      //     SizedBox(height: screenHeight * 0.02),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       children: [
                      //         // Row(
                      //         //   children: [
                      //         //     const Icon(
                      //         //       Icons.bookmark_border_rounded,
                      //         //       color: placeholderTextColor,
                      //         //       size: 30,
                      //         //     ),
                      //         //     SizedBox(
                      //         //       width: screenWidth * 0.01,
                      //         //     ),
                      //         //     const Text(
                      //         //       "Save",
                      //         //       style: TextStyle(
                      //         //         color: placeholderTextColor,
                      //         //         fontSize: 15,
                      //         //       ),
                      //         //     ),
                      //         //   ],
                      //         // ),
                      //         InkWell(
                      //           onTap: () async {
                      //             await Share.share(
                      //                 "Hey Check my Profile details: \n\nName: ${user.fname}\n\nWorking Title: ${user.category}\n\nLocation: ${user.location}\n\nProfileUrl: www.audition-example.com/${user.profileUrl}");
                      //           },
                      //           child: Row(
                      //             children: [
                      //               const Icon(
                      //                 Icons.file_upload_outlined,
                      //                 color: placeholderTextColor,
                      //                 size: 30,
                      //               ),
                      //               SizedBox(
                      //                 width: screenWidth * 0.01,
                      //               ),
                      //               const Text(
                      //                 "Share",
                      //                 style: TextStyle(
                      //                   color: placeholderTextColor,
                      //                   fontSize: 15,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         InkWell(
                      //           onTap: () async {
                      //             circularProgressIndicatorNew(context);
                      //             await switchToStudio();
                      //           },
                      //           child: Row(
                      //             children: [
                      //               SvgPicture.asset(
                      //                 "asset/icons/switchuser.svg",
                      //                 color: placeholderTextColor,
                      //               ),
                      //               SizedBox(
                      //                 width: screenWidth * 0.02,
                      //               ),
                      //               const Text(
                      //                 "Switch Account",
                      //                 style: TextStyle(
                      //                   color: placeholderTextColor,
                      //                   fontSize: 15,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     SizedBox(height: screenHeight * 0.03),
                      //     Padding(
                      //       padding:
                      //           EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.stretch,
                      //         children: [
                      //           Text(
                      //             user.fname,
                      //             textAlign: TextAlign.start,
                      //             style: const TextStyle(
                      //               fontSize: 18,
                      //             ),
                      //           ),
                      //           SizedBox(height: screenHeight * 0.005),
                      //           Text(
                      //             "(${user.category})",
                      //             style: const TextStyle(
                      //               color: placeholderTextColor,
                      //             ),
                      //           ),
                      //           SizedBox(height: screenHeight * 0.01),
                      //           user.bio.isEmpty
                      //               ? InkWell(
                      //                   onTap: () {
                      //                     _bioController.text = "";
                      //                     showBio(context, screenWidth, screenHeight);
                      //                   },
                      //                   child: SizedBox(
                      //                     height: screenHeight * 0.05,
                      //                     child: const Text(
                      //                       "Click to add Bio",
                      //                       textAlign: TextAlign.center,
                      //                       style: TextStyle(
                      //                         fontSize: 16,
                      //                         color: placeholderTextColor,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 )
                      //               : Padding(
                      //                   padding: const EdgeInsets.only(bottom: 10),
                      //                   child: Column(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.stretch,
                      //                     children: [
                      //                       Container(
                      //                         width: screenWidth,
                      //                         alignment: Alignment.topRight,
                      //                         child: InkWell(
                      //                           onTap: () {
                      //                             _bioController.text = user.bio;
                      //                             showBio(context, screenWidth,
                      //                                 screenHeight);
                      //                           },
                      //                           child: Icon(
                      //                             MyFlutterApp.edit_black,
                      //                             size: screenHeight * 0.02,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       Text(
                      //                         user.bio,
                      //                         style: const TextStyle(
                      //                           fontSize: 11,
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //         ],
                      //       ),
                      //     ),
                      //     Visibility(
                      //       visible: short,
                      //       child: InkWell(
                      //         onTap: () {
                      //           setState(() {
                      //             short = !short;
                      //           });
                      //         },
                      //         child: Container(
                      //           width: screenWidth,
                      //           height: screenHeight * 0.08,
                      //           color: Colors.white,
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: const [
                      //               Text(
                      //                 "Read More",
                      //                 style: TextStyle(fontSize: 18),
                      //               ),
                      //               Icon(
                      //                 MyFlutterApp.arrow_down_2,
                      //                 size: 28,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     Column(
                      //       children: short
                      //           ? []
                      //           : [
                      //               SizedBox(height: screenHeight * 0.01),
                      //               Divider(
                      //                 color: Colors.grey.shade300,
                      //                 thickness: 10,
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsets.only(
                      //                     top: screenHeight * 0.02,
                      //                     left: screenWidth * 0.0636,
                      //                     right: screenWidth * 0.0636),
                      //                 child: Column(
                      //                   children: [
                      //                     normalTitles(screenHeight, context,
                      //                         "Basic Info", BasicInfoPage.routeName),
                      //                     SizedBox(height: screenHeight * 0.008),
                      //                     smallSubTitles(screenWidth, screenHeight,
                      //                         "Name", user.fname),
                      //                     SizedBox(height: screenHeight * 0.005),
                      //                     smallSubTitles(screenWidth, screenHeight,
                      //                         "Gender", user.gender),
                      //                     SizedBox(height: screenHeight * 0.005),
                      //                     smallSubTitles(screenWidth, screenHeight,
                      //                         "Location", user.location),
                      //                     SizedBox(height: screenHeight * 0.005),
                      //                     // TODO: A way to give profile url
                      //                     smallSubTitles(screenWidth, screenHeight,
                      //                         "Profile URL", user.profileUrl),
                      //                     SizedBox(height: screenHeight * 0.005),
                      //                     smallSubTitles(screenWidth, screenHeight,
                      //                         "Working Title", user.category),
                      //                   ],
                      //                 ),
                      //               ),
                      //               SizedBox(height: screenHeight * 0.01),
                      //               Divider(
                      //                 color: Colors.grey.shade300,
                      //                 thickness: 10,
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsets.only(
                      //                     left: screenWidth * 0.0636,
                      //                     right: screenWidth * 0.0636),
                      //                 child: Column(
                      //                   children: [
                      //                     normalTitles(screenHeight, context,
                      //                         "Appearance", AppearancePage.routeName),
                      //                     SizedBox(height: screenHeight * 0.008),
                      //                     smallSubTitles(screenWidth, screenHeight,
                      //                         "Age", user.age),
                      //                     SizedBox(height: screenHeight * 0.005),
                      //                     smallSubTitles(screenWidth, screenHeight,
                      //                         "Height", user.height),
                      //                     SizedBox(height: screenHeight * 0.005),
                      //                     smallSubTitles(screenWidth, screenHeight,
                      //                         "Weight", "${user.weight} kg"),
                      //                     SizedBox(height: screenHeight * 0.005),
                      //                     smallSubTitles(screenWidth, screenHeight,
                      //                         "Body type", user.bodyType),
                      //                     SizedBox(height: screenHeight * 0.005),
                      //                     smallSubTitles(screenWidth, screenHeight,
                      //                         "Hair Color", user.hairColor),
                      //                     SizedBox(height: screenHeight * 0.005),
                      //                     smallSubTitles(screenWidth, screenHeight,
                      //                         "Eye Color", user.eyeColor),
                      //                   ],
                      //                 ),
                      //               ),
                      //               SizedBox(height: screenHeight * 0.01),
                      //               Divider(
                      //                 color: Colors.grey.shade300,
                      //                 thickness: 10,
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsets.only(
                      //                     left: screenWidth * 0.0636,
                      //                     right: screenWidth * 0.0636),
                      //                 child: Column(
                      //                   children: [
                      //                     normalTitles(
                      //                         screenHeight,
                      //                         context,
                      //                         "Website/Social Media",
                      //                         SocialMediaPage.routeName),
                      //                     SizedBox(height: screenHeight * 0.008),
                      //                     Column(
                      //                         crossAxisAlignment:
                      //                             CrossAxisAlignment.stretch,
                      //                         children: user.socialMedia.map((e) {
                      //                           return Text(e.toString());
                      //                         }).toList()
                      //                         // [

                      //                         // const Text(
                      //                         //   "http://clementina.info",
                      //                         //   style: TextStyle(
                      //                         //     fontSize: 16,
                      //                         //     color: Colors.blue,
                      //                         //   ),
                      //                         // ),
                      //                         // SizedBox(height: screenHeight * 0.005),
                      //                         // const Text(
                      //                         //   "https://axel.biz",
                      //                         //   style: TextStyle(
                      //                         //     fontSize: 16,
                      //                         //     color: Colors.blue,
                      //                         //   ),
                      //                         // ),
                      //                         // SizedBox(height: screenHeight * 0.005),
                      //                         // const Text(
                      //                         //   "https://elliot.name",
                      //                         //   style: TextStyle(
                      //                         //     fontSize: 16,
                      //                         //     color: Colors.blue,
                      //                         //   ),
                      //                         // ),
                      //                         // SizedBox(height: screenHeight * 0.005),
                      //                         // const Text(
                      //                         //   "https://esteil.name",
                      //                         //   style: TextStyle(
                      //                         //     fontSize: 16,
                      //                         //     color: Colors.blue,
                      //                         //   ),
                      //                         // ),
                      //                         // ],
                      //                         ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               SizedBox(height: screenHeight * 0.01),
                      //               Divider(
                      //                 color: Colors.grey.shade300,
                      //                 thickness: 10,
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsets.only(
                      //                     left: screenWidth * 0.0636,
                      //                     right: screenWidth * 0.0636),
                      //                 child: Column(
                      //                   children: [
                      //                     normalTitles(
                      //                         screenHeight,
                      //                         context,
                      //                         "Union Membership",
                      //                         MembershipPage.routeName),
                      //                     SizedBox(height: screenHeight * 0.008),
                      //                     Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.stretch,
                      //                       children: user.unionMembership.map((e) {
                      //                         return Text(e.toString());
                      //                       }).toList(),
                      //                       // children: const [
                      //                       //   Text("Equity (U.S.)", style: textStyle),
                      //                       // ],
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               SizedBox(height: screenHeight * 0.01),
                      //               Divider(
                      //                 color: Colors.grey.shade300,
                      //                 thickness: 10,
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsets.only(
                      //                     left: screenWidth * 0.0636,
                      //                     right: screenWidth * 0.0636),
                      //                 child: Column(
                      //                   children: [
                      //                     normalTitles(screenHeight, context, "Skills",
                      //                         SkillsPage.routeName),
                      //                     SizedBox(height: screenHeight * 0.008),
                      //                     Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.stretch,
                      //                       children: user.skills.map((e) {
                      //                         return Text(e.toString());
                      //                       }).toList(),
                      //                       // children: [
                      //                       //   const Text("Ability to take direction",
                      //                       //       style: textStyle),
                      //                       //   SizedBox(height: screenHeight * 0.005),
                      //                       //   const Text(
                      //                       //       "Ability to work as a team and also individually",
                      //                       //       style: textStyle),
                      //                       //   SizedBox(height: screenHeight * 0.005),
                      //                       //   const Text("Reliability",
                      //                       //       style: textStyle),
                      //                       //   SizedBox(height: screenHeight * 0.005),
                      //                       //   const Text("Good time keeping skills",
                      //                       //       style: textStyle),
                      //                       // ],
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               SizedBox(height: screenHeight * 0.01),
                      //               Divider(
                      //                 color: Colors.grey.shade300,
                      //                 thickness: 10,
                      //               ),
                      //               Padding(
                      //                 padding: EdgeInsets.only(
                      //                     left: screenWidth * 0.0636,
                      //                     right: screenWidth * 0.0636),
                      //                 child: Column(
                      //                   children: [
                      //                     normalTitles(screenHeight, context, "Credits",
                      //                         CreditsPage.routeName),
                      //                     SizedBox(height: screenHeight * 0.008),
                      //                     Column(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.stretch,
                      //                       children: user.credits.map((e) {
                      //                         return Text(e.toString());
                      //                       }).toList(),
                      //                     )
                      //                     // const SizedBox(
                      //                     //   child: Text(
                      //                     //       "Add credits from your past performance and jobs in the entertainment industry.",
                      //                     //       style: textStyle),
                      //                     // ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               SizedBox(height: screenHeight * 0.01),
                      //               Divider(
                      //                 color: Colors.grey.shade300,
                      //                 thickness: 10,
                      //               ),
                      //               InkWell(
                      //                 onTap: () {
                      //                   Navigator.pushNamed(
                      //                       context, SubscriptionPage.routeName);
                      //                 },
                      //                 child: simpleArrowColumn(
                      //                     screenHeight, screenWidth, "Subscription"),
                      //               ),
                      //               Divider(
                      //                 color: Colors.grey.shade300,
                      //                 thickness: 10,
                      //               ),
                      //               InkWell(
                      //                 onTap: () async {
                      //                   circularProgressIndicatorNew(context);
                      //                   await AuthService().logoutUser(context);
                      //                 },
                      //                 child: simpleArrowColumn(
                      //                     screenHeight, screenWidth, "Log Out"),
                      //               ),
                      //               Divider(
                      //                 color: Colors.grey.shade300,
                      //                 thickness: 10,
                      //               ),
                      //               InkWell(
                      //                 onTap: () {
                      //                   setState(() {
                      //                     short = !short;
                      //                   });
                      //                 },
                      //                 child: Container(
                      //                   width: screenWidth,
                      //                   height: screenHeight * 0.08,
                      //                   color: Colors.white,
                      //                   child: Row(
                      //                     mainAxisAlignment: MainAxisAlignment.center,
                      //                     children: const [
                      //                       Text(
                      //                         "Read Less",
                      //                         style: TextStyle(fontSize: 18),
                      //                       ),
                      //                       Icon(
                      //                         Icons.keyboard_arrow_up_outlined,
                      //                         size: 28,
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ],
                      //     ),
                      //   ],
                      // ),
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

  Future<dynamic> showBio(
      BuildContext context, double screenWidth, double screenHeight) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Container(
            width: screenWidth * 0.80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  width: screenWidth * 0.60,
                  height: screenHeight * 0.30,
                  // color: Colors.yellow[50],
                  decoration: BoxDecoration(
                      color: Colors.yellow[100],
                      border: Border.all(
                        color: secondoryColor,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: TextField(
                    controller: _bioController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none,
                      hintText: "Write your bio here...",
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        navigatePop() => Navigator.pop(context);
                        circularProgressIndicatorNew(context);
                        await changeBio();
                        navigatePop();
                        navigatePop();
                      },
                      child: const Text(
                        "Add",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
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
