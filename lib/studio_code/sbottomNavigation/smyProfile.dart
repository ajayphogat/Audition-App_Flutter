import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/provider/studio_provider.dart';
import 'package:first_app/studio_code/sbottomNavigation/sbottomNavigationBar.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:first_app/studio_code/spages/sprofilePages/smyProfilePage.dart';
import 'package:first_app/studio_code/spages/sprofilePages/ssettingsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SMyProfile extends StatefulWidget {
  const SMyProfile({Key? key}) : super(key: key);

  static const String routeName = "/smyProfile";

  @override
  State<SMyProfile> createState() => _SMyProfileState();
}

class _SMyProfileState extends State<SMyProfile> {
  final AuthService authService = AuthService();

  Future<void> switchToAudition() async {
    await authService.switchToAudition(context: context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var sUser = Provider.of<StudioProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          SizedBox(
            width: screenWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(MyFlutterApp.bi_arrow_down,
                            color: Colors.black),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, SBottomNavigationPage.routeName);
                        },
                      ),
                      const Text(
                        "Profile",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: fontFamily,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(MyFlutterApp.arrow_down_2,
                            color: Colors.black),
                        onPressed: () {
                          bottomPageUp(
                            context,
                            screenHeight,
                            screenWidth,
                            sUser.fname,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   child: Row(
                //     children: [
                //       IconButton(
                //         icon: const Icon(
                //           MyFlutterApp.setting_black,
                //           color: Colors.black,
                //         ),
                //         onPressed: () {
                //           Navigator.pushNamed(context, SSettingsPage.routeName);
                //         },
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
      body: const SMyProfilePage(),
    );
  }

  Future<dynamic> bottomPageUp(BuildContext context, double screenHeight,
      double screenWidth, String text) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        builder: (BuildContext contxt) {
          return Container(
            height: screenHeight * 0.15,
            width: screenWidth,
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Color(0xFFFDF5F2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: screenWidth,
                  height: 2,
                  margin: EdgeInsets.only(
                      top: 10,
                      left: (screenWidth / 2.5),
                      right: (screenWidth / 2.5),
                      bottom: screenHeight * 0.045),
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Icon(
                      Icons.check,
                      color: Colors.blue,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    navPop() => Navigator.pop(context);
                    circularProgressIndicatorNew(context);
                    await switchToAudition();
                    navPop();

                    // Navigator.pushNamedAndRemoveUntil(context,
                    //     BottomNavigationPage.routeName, (route) => false);
                  },
                  child: Row(
                    children: const [
                      Icon(MyFlutterApp.switchuser),
                      SizedBox(width: 15),
                      Text("Switch Account"),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
