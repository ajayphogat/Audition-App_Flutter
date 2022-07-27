import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/myProfilePages/myProfilePage.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  static const String routeName = "/myProfile";

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                              context, BottomNavigationPage.routeName);
                        },
                      ),
                      const Text(
                        "Actor Profile",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      IconButton(
                        icon: const Icon(MyFlutterApp.arrow_down_2,
                            color: Colors.black),
                        onPressed: () {
                          bottomPageUp(context, screenHeight, screenWidth);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: IconButton(
                    icon: const Icon(
                      MyFlutterApp.setting_black,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.03),
          child: Container(
            width: screenWidth,
            padding: const EdgeInsets.symmetric(vertical: 3),
            alignment: Alignment.center,
            color: const Color(0xFF30319D),
            child: const Text(
              "Gold Subscriber",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
      body: const MyProfilePage(),
    );
  }

  Future<dynamic> bottomPageUp(
      BuildContext context, double screenHeight, double screenWidth) {
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
                  children: const [
                    Text(
                      "Lorem ipsum studio",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.blue,
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Icon(MyFlutterApp.fluent_add_circle_24_filled),
                    SizedBox(width: 15),
                    Text("Add Account"),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
