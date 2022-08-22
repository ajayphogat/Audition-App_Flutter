import 'package:first_app/studio_code/scommon/scommon.dart';
import 'package:first_app/studio_code/spages/sprofilePages/sprojectPage/ssubscriptionPages/ssubscriptionPage.dart';
import 'package:flutter/material.dart';

class SProjectPage extends StatelessWidget {
  const SProjectPage({Key? key}) : super(key: key);

  static const String routeName = "/project-page";

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: Column(
                children: [
                  const Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Risus non euismod maecenas ultrices tincidunt porttitor fringilla risus. Diam nec pulvinar quam vel dictum amet mauris. Vivamus bibendum eget a, amet facilisis eu neque pharetra eu. Quis in sagittis, pulvinar hac. Tincidunt feugiat aliquet duis facilisis mauris. Bibendum turpis mauris sit velit. Sodales mauris enim iaculis nibh consectetur nulla. Volutpat vestibulum sapien, at varius donec ut eu aliquam. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Risus non euismod maecenas ultrices tincidunt porttitor fringilla risus. Diam nec pulvinar quam vel dictum amet mauris. Vivamus bibendum eget a, amet facilisis eu neque pharetra eu. Quis in sagittis, pulvinar hac. Tincidunt feugiat aliquet duis facilisis mauris. Bibendum turpis mauris sit velit. Sodales mauris enim iaculis nibh consectetur nulla. Volutpat vestibulum sapien, at varius donec ut eu aliquam.",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  unOrderedListItem(context,
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare lacinia semper massa commodo, tempor malesuada eget vel. Malesuada leo, iaculis consectetur arcu urna cursus."),
                  unOrderedListItem(context,
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare lacinia semper massa commodo, tempor malesuada eget vel. Malesuada leo, iaculis consectetur arcu urna cursus."),
                  unOrderedListItem(context,
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare lacinia semper massa commodo, tempor malesuada eget vel. Malesuada leo, iaculis consectetur arcu urna cursus."),
                  unOrderedListItem(context,
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare lacinia semper massa commodo, tempor malesuada eget vel. Malesuada leo, iaculis consectetur arcu urna cursus."),
                  unOrderedListItem(context,
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare lacinia semper massa commodo, tempor malesuada eget vel. Malesuada leo, iaculis consectetur arcu urna cursus."),
                  unOrderedListItem(context,
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ornare lacinia semper massa commodo, tempor malesuada eget vel. Malesuada leo, iaculis consectetur arcu urna cursus."),
                ],
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, SSubscriptionPage.routeName);
              },
              child:
                  simpleArrowColumn(screenHeight, screenWidth, "Subscription"),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 10,
            ),
          ],
        ),
      ),
    );
  }
}
