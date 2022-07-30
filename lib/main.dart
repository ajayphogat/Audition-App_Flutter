import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/bottomNavigation/homePage.dart';
import 'package:first_app/bottomNavigation/inbox.dart';
import 'package:first_app/bottomNavigation/myApplication.dart';
import 'package:first_app/bottomNavigation/myProfile.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/login/forgotPassword.dart';
import 'package:first_app/login/loginPage.dart';
import 'package:first_app/login/mainPage.dart';
import 'package:first_app/login/signUpPage.dart';
import 'package:first_app/login/verifiedPage.dart';
import 'package:first_app/login/verifyMobile.dart';
import 'package:first_app/pages/categorySection/appliedPage.dart';
import 'package:first_app/pages/categorySection/categoryDetailPage.dart';
import 'package:first_app/pages/categorySection/categoryPageGrid.dart';
import 'package:first_app/pages/categorySection/descriptionPage.dart';
import 'package:first_app/pages/inboxPages/inboxPage.dart';
import 'package:first_app/pages/myApplicationPages/myApplicationPage.dart';
import 'package:first_app/pages/myProfilePages/detailMenuPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/appearancePage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/basicInfoPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/createProfilePage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/creditsPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/membershipPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/skillsPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/socialMediaPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/subscriptionPage.dart';
import 'package:first_app/pages/myProfilePages/mediaPage.dart';
import 'package:first_app/pages/myProfilePages/myProfilePage.dart';
import 'package:first_app/pages/splashScreen/firstScreen.dart';
import 'package:first_app/pages/splashScreen/secondScreen.dart';
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
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: primaryColor,
          fontFamily: fontFamily,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) =>
              const FirstSplashScreen(), //FIXME: Change this Starting Screen

          SecondSplashScreen.routeName: (context) => const SecondSplashScreen(),

          // Authentication Page Section
          MainPage.routeName: (context) => const MainPage(),
          LoginPage.routeName: (context) => const LoginPage(),
          SignupPage.routeName: (context) => const SignupPage(),
          VerifyMobile.routeName: (context) => const VerifyMobile(),
          VerifiedPage.routeName: (context) => const VerifiedPage(),
          ForgotPassword.routeName: (context) => ForgotPassword(),

          // Home Page Section
          HomePage.routeName: (context) => const HomePage(),
          // Home Page - Category Pages
          CategoryDetailPage.routeName: (context) => const CategoryDetailPage(),
          CategoryGirdPage.routeName: (context) => const CategoryGirdPage(),

          // Description Page
          DescriptionPage.routeName: (context) => const DescriptionPage(),
          AppliedPage.routeName: (context) => const AppliedPage(),

          // My Application Page Section
          MyApplicationPage.routeName: (context) => const MyApplicationPage(),
          MyApplicationAppliedPage.routeName: (context) =>
              const MyApplicationAppliedPage(),

          // Inbox Page Section
          InboxPage.routeName: (context) => const InboxPage(),
          InboxMessagePage.routeName: (context) => const InboxMessagePage(),

          // My Profile Page Section
          MyProfile.routeName: (context) => const MyProfile(),
          MyProfilePage.routeName: (context) => const MyProfilePage(),
          DetailMenuPage.routeName: (context) => const DetailMenuPage(),
          MediaProfilePage.routeName: (context) => const MediaProfilePage(),
          // My Profile Page - Basic Page
          BasicInfoPage.routeName: (context) => const BasicInfoPage(),
          // My Profile Page - Appearance Page
          AppearancePage.routeName: (context) => const AppearancePage(),
          // My Profile Page - Social Media Page
          SocialMediaPage.routeName: (context) => const SocialMediaPage(),
          // My Profile Page - Membership Page
          MembershipPage.routeName: (context) => const MembershipPage(),
          // My Profile Page - Skills Page
          SkillsPage.routeName: (context) => const SkillsPage(),
          // My Profile Page - Credits Page
          CreditsPage.routeName: (context) => const CreditsPage(),
          // My Profile Page - Subscription Page
          SubscriptionPage.routeName: (context) => const SubscriptionPage(),
          // My Profile Page - Create Profile Page
          CreateProfilePage.routeName: (context) => const CreateProfilePage(),

          // Bottom Navigation Bar
          BottomNavigationPage.routeName: (context) =>
              const BottomNavigationPage(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
