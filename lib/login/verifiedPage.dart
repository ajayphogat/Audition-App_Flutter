import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifiedPage extends StatelessWidget {
  const VerifiedPage({Key? key}) : super(key: key);

  static const String routeName = "/verified-page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 2,
              child: SvgPicture.asset(
                  "asset/images/illustration/charm_circle-tick.svg"),
            ),
            const Text(
              "Your mobile number is\nsuccessfully verified.",
              style: TextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
