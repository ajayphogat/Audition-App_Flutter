import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/pages/myProfilePages/detailPages/appearancePage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/basicInfoPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/createProfilePage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/creditsPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/membershipPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/skillsPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/socialMediaPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/subscriptionPage.dart';
import 'package:flutter/material.dart';

class DetailMenuPage extends StatefulWidget {
  const DetailMenuPage({Key? key}) : super(key: key);

  static const String routeName = "/detailMenu-page";

  @override
  State<DetailMenuPage> createState() => _DetailMenuPageState();
}

class _DetailMenuPageState extends State<DetailMenuPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: screenHeight * 0.54,
        child: Column(
          children: [
            detailsMenu(context, screenWidth, screenHeight, profileData[0],
                BasicInfoPage.routeName),
            detailsMenu(context, screenWidth, screenHeight, profileData[1],
                AppearancePage.routeName),
            detailsMenu(context, screenWidth, screenHeight, profileData[2],
                SocialMediaPage.routeName),
            detailsMenu(context, screenWidth, screenHeight, profileData[3],
                MembershipPage.routeName),
            detailsMenu(context, screenWidth, screenHeight, profileData[4],
                SkillsPage.routeName),
            detailsMenu(context, screenWidth, screenHeight, profileData[5],
                CreditsPage.routeName),
            detailsMenu(context, screenWidth, screenHeight, profileData[6],
                SubscriptionPage.routeName),
            detailsMenu(context, screenWidth, screenHeight, profileData[7],
                CreateProfilePage.routeName),
          ],
        ),
      ),
    );
  }
}
