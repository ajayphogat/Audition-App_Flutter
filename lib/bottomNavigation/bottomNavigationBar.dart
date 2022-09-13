import 'package:first_app/bottomNavigation/inbox.dart';
import 'package:first_app/bottomNavigation/myApplication.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/bottomNavigation/homePage.dart';
import 'package:first_app/pages/myProfilePages/myProfilePage.dart';
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
    const MyProfilePage(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: SizedBox(
        height: screenHeight * 0.065,
        child: BottomNavigationBar(
          key: _key,
          backgroundColor: primaryColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: thirdColor,
          unselectedItemColor: Colors.black,
          selectedIconTheme: const IconThemeData(color: thirdColor),
          unselectedIconTheme: const IconThemeData(color: Colors.black),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontFamily: fontFamily),
          unselectedLabelStyle: const TextStyle(fontFamily: fontFamily),
          selectedFontSize: 11.5,
          unselectedFontSize: 11.5,
          currentIndex: _page,
          onTap: updatePage,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(MyFlutterApp.home_outline),
              activeIcon: Icon(
                MyFlutterApp.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  _page == 1 ? MyFlutterApp.paper : MyFlutterApp.paper_outline),
              label: "My Applications",
            ),
            BottomNavigationBarItem(
              icon: Icon(_page == 2
                  ? MyFlutterApp.message
                  : MyFlutterApp.message_outline),
              label: "Inbox",
            ),
            BottomNavigationBarItem(
              icon: Icon(_page == 3
                  ? MyFlutterApp.profile
                  : MyFlutterApp.profile_outline),
              label: "My Profile",
            ),
          ],
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



