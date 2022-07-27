import 'package:first_app/bottomNavigation/inbox.dart';
import 'package:first_app/bottomNavigation/myApplication.dart';
import 'package:first_app/bottomNavigation/myProfile.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/bottomNavigation/homePage.dart';
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
    const MyProfile(),
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
          backgroundColor: const Color(0xFFFFFFFF),
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF30319D),
          unselectedItemColor: Colors.black,
          selectedIconTheme: const IconThemeData(color: Color(0xFF30319D)),
          unselectedIconTheme: const IconThemeData(color: Colors.black),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
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



