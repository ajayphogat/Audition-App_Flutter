import 'package:first_app/bottomNavigation/inbox.dart';
import 'package:first_app/bottomNavigation/myApplication.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/bottomNavigation/homePage.dart';
import 'package:first_app/pages/myProfilePages/mediaPage.dart';
import 'package:first_app/utils/showSnackbar.dart';
import 'package:flutter/material.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  static const String routeName = "/bottomNavigation-Page";

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  int _page = 0;
  final _key = GlobalKey();

  final List<Widget> pages = [
    const HomePage(),
    const MyApplicationPage(),
    const InboxPage(),
    // const MyProfilePage(),
    const MediaProfilePage()
  ];

  DateTime pre_backPress = DateTime.now();

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    pre_backPress = DateTime.now().subtract(const Duration(seconds: 2));

    return Scaffold(
      body: IndexedStack(
        index: _page,
        children: pages,
      ),
      bottomNavigationBar: Container(
        width: screenWidth,
        height: screenHeight * 0.065,
        margin: EdgeInsets.only(bottom: screenHeight * 0.01),
        // padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: const [
            BoxShadow(
              offset: Offset(3, 3),
              blurRadius: 5,
              spreadRadius: 2,
              color: Colors.black12,
            ),
          ],
          // color: Colors.red,
        ),
        clipBehavior: Clip.antiAlias,
        child: WillPopScope(
          onWillPop: () async {
            if (_page > 0) {
              Navigator.popAndPushNamed(
                  context, BottomNavigationPage.routeName);
              setState(() {
                _page = 0;
              });
              return false;
            } else if (_page == 0) {
              final timegap = DateTime.now().difference(pre_backPress);
              pre_backPress = DateTime.now();

              if (timegap >= const Duration(seconds: 2)) {
                showSnackBar(context, "Press Back button again to Exit");
                return false;
              } else {
                return true;
              }
            }
            return false;
          },
          child: BottomNavigationBar(
            key: _key,
            backgroundColor: primaryColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: thirdColor,
            unselectedItemColor: Colors.black,
            selectedIconTheme: const IconThemeData(color: thirdColor),
            unselectedIconTheme: const IconThemeData(color: Colors.black),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedLabelStyle: const TextStyle(fontFamily: fontFamily),
            unselectedLabelStyle: const TextStyle(fontFamily: fontFamily),
            selectedFontSize: 1,
            unselectedFontSize: 1,
            currentIndex: _page,
            onTap: updatePage,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(MyFlutterApp.home_outline),
                activeIcon: CircleAvatar(
                  radius: screenHeight * 0.02,
                  backgroundColor: greenColor,
                  child: const Icon(
                    MyFlutterApp.home,
                  ),
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: const Icon(MyFlutterApp.paper_outline),
                // icon: Icon(_page == 1
                //     ? MyFlutterApp.paper
                //     : MyFlutterApp.paper_outline),
                activeIcon: CircleAvatar(
                  radius: screenHeight * 0.02,
                  backgroundColor: greenColor,
                  child: const Icon(
                    MyFlutterApp.paper_outline,
                  ),
                ),
                label: "My Applications",
              ),
              BottomNavigationBarItem(
                icon: const Icon(MyFlutterApp.message_outline),
                // icon: Icon(_page == 2
                //     ? MyFlutterApp.message
                //     : MyFlutterApp.message_outline),
                activeIcon: CircleAvatar(
                  radius: screenHeight * 0.02,
                  backgroundColor: greenColor,
                  child: const Icon(
                    MyFlutterApp.message_outline,
                  ),
                ),
                label: "Inbox",
              ),
              BottomNavigationBarItem(
                icon: const Icon(MyFlutterApp.profile_outline),
                // : MyFlutterApp.profile_outline),
                activeIcon: CircleAvatar(
                  radius: screenHeight * 0.02,
                  backgroundColor: greenColor,
                  child: const Icon(
                    MyFlutterApp.profile_outline,
                  ),
                ),
                label: "My Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// Container(
//               height: screenHeight * 0.03,
//               width: screenHeight * 0.03,
//               decoration: BoxDecoration(
//                 border: Border(
//                   top: BorderSide(
//                     color: _page == 0
//                         ? const Color(0xFF30319D)
//                         : const Color(0xFFFFFFFF),
//                   ),
//                 ),
//               ),
//               child: 



