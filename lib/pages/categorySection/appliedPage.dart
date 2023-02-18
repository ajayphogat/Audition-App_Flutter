import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppliedPage extends StatelessWidget {
  const AppliedPage({Key? key}) : super(key: key);

  static const String routeName = "/applied-page";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenWidth,
            child: Transform.scale(
              scale: 0.7,
              child:
                  SvgPicture.asset("asset/images/illustration/appliedPage.svg"),
            ),
          ),
          const Text(
            "Applied Successfully",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, BottomNavigationPage.routeName, (route) => false);
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 50),
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFFF9D422),
              ),
              child: const Text(
                "GO HOME",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
