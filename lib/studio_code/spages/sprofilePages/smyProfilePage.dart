import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/auth/other_services.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/login/mainPage.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:first_app/studio_code/spages/sprofilePages/followersPage.dart';
import 'package:first_app/studio_code/spages/sprofilePages/sinviteFriends.dart';
import 'package:first_app/studio_code/spages/sprofilePages/sprojectPage/sAboutPage.dart';
import 'package:first_app/studio_code/spages/sprofilePages/sprojectPage/sprojectPage.dart';
import 'package:first_app/utils/bottom_gallary_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../provider/studio_provider.dart';

class SMyProfilePage extends StatefulWidget {
  const SMyProfilePage({Key? key}) : super(key: key);

  static const String routeName = "/smyProfile-page";

  @override
  State<SMyProfilePage> createState() => _SMyProfilePageState();
}

class _SMyProfilePageState extends State<SMyProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  late TextEditingController _studioNameController;
  late TextEditingController _locationController;
  final AuthService authService = AuthService();

  Future<void> updateNameLoc() async {
    await authService.updateNameLoc(
      context: context,
      fname: _studioNameController.text,
      location: _locationController.text,
    );
  }

  Future<void> getFollowers() async {
    await OtherService().getFollowers(context: context);
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    var user = Provider.of<StudioProvider>(context, listen: false).user;
    _studioNameController = TextEditingController();
    _locationController = TextEditingController();
    _studioNameController.text = user.fname;
    _locationController.text = user.location;
    super.initState();
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
    var sUser = Provider.of<StudioProvider>(context).user;
    print(sUser.followers);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.05),
            // Padding(
            //   padding: EdgeInsets.only(
            //       left: screenWidth * 0.05,
            //       right: screenWidth * 0.05,
            //       top: screenHeight * 0.01),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       InkWell(
            //         onTap: () {
            //           Navigator.pushNamed(
            //               context, SInviteFriendsPage.routeName);
            //         },
            //         child: Container(
            //           width: screenWidth * 0.22,
            //           height: screenHeight * 0.03,
            //           alignment: Alignment.center,
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(6),
            //             color: secondoryColor,
            //           ),
            //           child: const Text(
            //             "INVITE FRIENDS",
            //             style: TextStyle(
            //               fontSize: 8,
            //             ),
            //           ),
            //         ),
            //       ),
            //       // PopupMenuButton(
            //       //   padding: EdgeInsets.zero,
            //       //   icon: SvgPicture.asset(
            //       //     "asset/icons/v3.svg",
            //       //     color: Colors.black,
            //       //   ),
            //       //   offset: Offset(0, screenHeight * 0.042),
            //       //   itemBuilder: (context) {
            //       //     return [
            //       //       PopupMenuItem(
            //       //         height: screenHeight * 0.03,
            //       //         child: const Text(
            //       //           "Report",
            //       //           style: TextStyle(
            //       //             fontSize: 14,
            //       //           ),
            //       //         ),
            //       //         onTap: () async {
            //       //           circularProgressIndicatorNew(context);
            //       //           navigatorPop() => Navigator.pop(context);
            //       //           navigatorPush() =>
            //       //               Navigator.pushNamedAndRemoveUntil(context,
            //       //                   MainPage.routeName, (route) => false);
            //       //           SharedPreferences prefs =
            //       //               await SharedPreferences.getInstance();
            //       //           prefs.setString("x-auth-token", "");
            //       //           prefs.setString("x-studio-token", "");
            //       //           await FirebaseAuth.instance.signOut();
            //       //           navigatorPop();
            //       //           navigatorPush();
            //       //           // WidgetsBinding.instance.addPostFrameCallback((_) {
            //       //           //   newDialogBox1(context, screenWidth, screenHeight,
            //       //           //       "Account Reported!", "GO BACK", false, "");
            //       //           // }
            //       //           // );
            //       //         },
            //       //       ),
            //       //     ];
            //       //   },
            //       // ),
            //     ],
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.06,
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
                      height: screenHeight * 0.20,
                      padding: EdgeInsets.only(top: screenHeight * 0.03),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: placeholderColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                sUser.fname,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: fontFamily,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              const Icon(
                                Icons.check_circle,
                                size: 20,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                          Text(
                            _locationController.text.isEmpty
                                ? "Add Location of Company"
                                : _locationController.text.trim(),
                            style: const TextStyle(
                              color: placeholderTextColor,
                              fontFamily: fontFamily,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.12,
                                vertical: screenHeight * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    navigatePop() => Navigator.pop(context);
                                    navigatePush() => Navigator.pushNamed(
                                        context, FollowersPage.routeName);
                                    circularProgressIndicatorNew(context);
                                    await getFollowers();
                                    navigatePop();
                                    navigatePush();
                                  },
                                  child: Column(
                                    children: [
                                      const Text(
                                        "Followers",
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.005),
                                      Text(
                                        "${sUser.followers.length}",
                                        style: const TextStyle(
                                          color: placeholderTextColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    const Text(
                                      "Views",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.005),
                                    Text(
                                      "${sUser.views}",
                                      style: const TextStyle(
                                        color: placeholderTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          //
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: -5,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(
                        MyFlutterApp.edit_black,
                        size: 18,
                      ),
                      onPressed: () async {
                        await editArea(context, screenWidth, screenHeight);
                      },
                    ),
                  ),
                  Positioned(
                    top: -screenHeight * 0.08,
                    left: (screenWidth / 2) - (screenHeight * 0.05) - 25,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: screenHeight * 0.05,
                          child: sUser.profilePic.isEmpty
                              ? Container(
                                  width: screenHeight * 0.05,
                                  height: screenHeight * 0.05,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.black,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: screenHeight * 0.048,
                                  backgroundImage:
                                      NetworkImage(sUser.profilePic),
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                            onTap: () {
                              BottomMediaUp()
                                  .showPicker(context, sUser.id, "studio");
                            },
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TabBar(
                  controller: _tabController,
                  isScrollable: true,
                  indicatorColor: thirdColor,
                  labelColor: thirdColor,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.label,
                  padding:
                      EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
                  labelPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                  ),
                  labelStyle: const TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 16,
                  ),
                  tabs: const [
                    Tab(
                      text: "Projects",
                    ),
                    Tab(
                      text: "About",
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.419,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  SProjectPage(),
                  SAboutPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> editArea(
      BuildContext context, double screenWidth, double screenHeight) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: SizedBox(
              width: screenWidth * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Studio Name",
                    textAlign: TextAlign.start,
                  ),
                  studioPopText(screenHeight, screenWidth,
                      "Enter studio name here...", _studioNameController),
                  SizedBox(height: screenHeight * 0.02),
                  const Text(
                    "Location of Company",
                    textAlign: TextAlign.start,
                  ),
                  studioPopText(screenHeight, screenWidth,
                      "Enter location of company", _locationController),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          navigatePop() => Navigator.pop(context);
                          circularProgressIndicatorNew(context);
                          await updateNameLoc();

                          navigatePop();
                          navigatePop();
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Container studioPopText(double screenHeight, double screenWidth,
      String hintText, TextEditingController controller) {
    return Container(
      height: screenHeight * 0.05,
      margin: EdgeInsets.only(
        top: screenHeight * 0.01,
      ),
      padding: EdgeInsets.only(left: screenWidth * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: secondoryColor),
        color: secondoryColor.withOpacity(0.2),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
        ),
      ),
    );
  }
}
