import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/main.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({Key? key}) : super(key: key);

  static const String routeName = "/description-page";

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: descriptionAppBar(screenHeight, screenWidth, context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.167,
              child: Image.asset(
                "asset/images/uiImages/rr.png",
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: screenWidth * 0.25,
                    height: screenHeight * 0.03,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFF9D422),
                    ),
                    child: const Text("APPLY"),
                  ),
                  Row(
                    children: [
                      yellowCircleButton(screenHeight, MyFlutterApp.bookmark),
                      SizedBox(width: screenWidth * 0.08),
                      yellowCircleButton(screenHeight, MyFlutterApp.share_fill),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            const Divider(
              thickness: 1,
              height: 0,
              color: Colors.black,
            ),
            SizedBox(height: screenHeight * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth * 0.17,
                        height: screenWidth * 0.17,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Wade Warren",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "200 Applicants",
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFFF9D422),
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "Eleifend neque at",
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text(
                            "instagram.com/hdjdm",
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: screenWidth * 0.18,
                    height: screenHeight * 0.020,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: const Text(
                      "Follow",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.03,
                top: screenHeight * 0.022,
                right: screenWidth * 0.06,
                bottom: screenHeight * 0.022,
              ),
              child: ReadMoreText(
                descriptionData[0],
                trimMode: TrimMode.Length,
                trimCollapsedText: "\nREAD MORE",
                trimExpandedText: "\nSHOW LESS",
                trimLength: 413,
                style: const TextStyle(
                  fontSize: 13,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              height: 0,
              color: Colors.black,
            ),
            SizedBox(height: screenHeight * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Row(
                children: const [
                  Text(
                    "Production Details",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.03,
                top: screenHeight * 0.02,
                right: screenWidth * 0.06,
                bottom: screenHeight * 0.02,
              ),
              child: Text(
                descriptionData[1],
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            const Divider(
              thickness: 1,
              height: 0,
              color: Colors.black,
            ),
            SizedBox(height: screenHeight * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Row(
                children: const [
                  Text(
                    "Production Dates & Location",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            Container(
              width: screenWidth,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Color(0xFF979797),
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: "Date: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "Date of the production",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Color(0xFF979797),
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: "Location: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              "4517 Washington Ave.\nManchester, Kentucky 39495",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            const Divider(
              thickness: 1,
              height: 0,
              color: Colors.black,
            ),
            SizedBox(height: screenHeight * 0.025),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        //TODO: assign a function in this button
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(bottom: 5),
          width: 150,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFFF9D422),
          ),
          child: const Text(
            "APPLY",
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
