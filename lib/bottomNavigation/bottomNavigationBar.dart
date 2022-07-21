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
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
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
          BottomNavigationBarItem(
            icon: Icon(
                _page == 0 ? MyFlutterApp.home : MyFlutterApp.home_outline),
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
    );
  }
}
