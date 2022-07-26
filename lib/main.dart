import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/bottomNavigation/homePage.dart';
import 'package:first_app/bottomNavigation/inbox.dart';
import 'package:first_app/bottomNavigation/myApplication.dart';
import 'package:first_app/bottomNavigation/myProfile.dart';
import 'package:first_app/login/forgotPassword.dart';
import 'package:first_app/login/loginPage.dart';
import 'package:first_app/login/mainPage.dart';
import 'package:first_app/login/signUpPage.dart';
import 'package:first_app/login/verifiedPage.dart';
import 'package:first_app/login/verifyMobile.dart';
import 'package:first_app/pages/categoryDetailPage.dart';
import 'package:first_app/pages/categoryPageGrid.dart';
import 'package:first_app/pages/inboxPages/inboxPage.dart';
import 'package:first_app/pages/myApplicationPages/myApplicationPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/basicInfoPage.dart';
import 'package:first_app/pages/myProfilePages/mediaPage.dart';
import 'package:first_app/pages/myProfilePages/myProfilePage.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyAPP());

class MyAPP extends StatelessWidget {
  const MyAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (context) =>
              const BasicInfoPage(), //FIXME: Change this Starting Screen
          LoginPage.routeName: (context) => const LoginPage(),
          SignupPage.routeName: (context) => const SignupPage(),
          VerifyMobile.routeName: (context) => const VerifyMobile(),
          VerifiedPage.routeName: (context) => const VerifiedPage(),
          ForgotPassword.routeName: (context) => ForgotPassword(),
          HomePage.routeName: (context) => const HomePage(),
          MyApplicationPage.routeName: (context) => const MyApplicationPage(),
          InboxPage.routeName: (context) => const InboxPage(),
          MyProfile.routeName: (context) => const MyProfile(),
          CategoryDetailPage.routeName: (context) => const CategoryDetailPage(),
          CategoryGirdPage.routeName: (context) => const CategoryGirdPage(),
          MyApplicationAppliedPage.routeName: (context) =>
              const MyApplicationAppliedPage(),
          InboxMessagePage.routeName: (context) => const InboxMessagePage(),
          MyProfilePage.routeName: (context) => const MyProfilePage(),
          MediaProfilePage.routeName: (context) => const MediaProfilePage(),
          BasicInfoPage.routeName: (context) => const BasicInfoPage(),
          BottomNavigationPage.routeName: (context) =>
              const BottomNavigationPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
