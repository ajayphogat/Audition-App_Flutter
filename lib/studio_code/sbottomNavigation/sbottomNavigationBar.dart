import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/studio_code/sbottomNavigation/shomePage.dart';
import 'package:first_app/studio_code/sbottomNavigation/sinbox.dart';
import 'package:first_app/studio_code/sbottomNavigation/smyApplication.dart';
import 'package:first_app/studio_code/sbottomNavigation/smyProfile.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:first_app/utils/showSnackbar.dart';
import 'package:flutter/material.dart';

class SBottomNavigationPage extends StatefulWidget {
  const SBottomNavigationPage({Key? key}) : super(key: key);

  static const String routeName = "/sbottomNavigation-Page";

  @override
  State<SBottomNavigationPage> createState() => _SBottomNavigationPageState();
}

class _SBottomNavigationPageState extends State<SBottomNavigationPage> {
  int _page = 0;
  final _key = GlobalKey();

  DateTime pre_backPress = DateTime.now();

  final List<Widget> pages = [
    const SHomePage(),
    const SMyApplicationPage(),
    const SInboxPage(),
    const SMyProfile(),
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
    pre_backPress = DateTime.now().subtract(const Duration(seconds: 2));
    return Scaffold(
      body: IndexedStack(
        index: _page,
        children: pages,
      ),
      bottomNavigationBar: SizedBox(
        height: screenHeight * 0.065,
        child: WillPopScope(
          onWillPop: () async {
            if (_page > 0) {
              Navigator.popAndPushNamed(
                  context, SBottomNavigationPage.routeName);
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
                icon: Icon(_page == 1
                    ? MyFlutterApp.paper
                    : MyFlutterApp.paper_outline),
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
      ),
    );
  }
}
