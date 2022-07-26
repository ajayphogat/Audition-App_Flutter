import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({Key? key}) : super(key: key);

  static const String routeName = "/socialMedia-Page";

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: profileAppBar(screenHeight, screenWidth, context, profileData[2]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 2,
            child: SvgPicture.asset("asset/images/illustration/innovation.svg"),
          ),
          SizedBox(height: screenHeight * 0.03),
          const Text(
            "You don't have any links added yet",
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF979797),
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          const Text(
            "Add your personal website, social links, and\nmore.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF979797),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFFF9D422),
              ),
              child: const Text(
                "ADD LINK",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
