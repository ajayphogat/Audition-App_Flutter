import 'package:first_app/homePage/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    const HomePage(),
    const HomePage(),
    const HomePage(),
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
        backgroundColor: const Color(0xFFffffff),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.orange,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        currentIndex: _page,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "asset/icons/Home.svg",
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "asset/icons/Paper.svg",
            ),
            label: "My Applications",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "asset/icons/Message.svg",
            ),
            label: "Inbox",
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "asset/icons/Profile.svg",
            ),
            label: "My Profile",
          ),
        ],
      ),
    );
  }
}
