import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/paymentPage/paymentPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  static const String routeName = "/subscription-Page";

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  bool _three = false;
  bool _six = true;
  bool _twelve = false;
  List<String> _plans = [];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(MyFlutterApp.bi_arrow_down, color: Colors.black),
        ),
        title: const Text(
          "Subscription Plan",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
            child: Image.asset("asset/images/subscription_banner/banner.png"),
          ),
          SizedBox(height: screenHeight * 0.01),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                subscriptionPlan3Container(
                    screenWidth, screenHeight, "3 Months"),
                subscriptionPlan6Container(
                    screenWidth, screenHeight, "6 Months"),
                subscriptionPlan12Container(
                    screenWidth, screenHeight, "12 Months"),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          SizedBox(
            height: screenHeight * 0.58,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.01),
              physics: const BouncingScrollPhysics(),
              itemCount: subscriptionPlans.length,
              itemBuilder: (context, index) {
                _plans = subscriptionPlans[index];
                return Container(
                  width: screenWidth,
                  height: screenHeight * 0.11,
                  margin: EdgeInsets.only(bottom: screenHeight * 0.02),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(3, 3),
                        blurRadius: 5,
                        spreadRadius: 2,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth * 0.25,
                        height: screenHeight * 0.12,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                          color: Color(0xFFFFD0D0),
                        ),
                        child: Image.asset("asset/images/uiImages/yygg.png"),
                      ),
                      Container(
                        width: screenWidth * 0.67,
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _plans[0],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _plans[1],
                              style: const TextStyle(
                                fontSize: 9,
                                color: placeholderTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget planDetails(
      double screenHeight, double screenWidth, String detailText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: screenHeight * 0.03,
            left: screenWidth * 0.04,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    right: screenWidth * 0.02, top: screenHeight * 0.0035),
                child: Icon(
                  Icons.circle,
                  color: const Color(0xFFF9D422),
                  size: screenWidth * 0.025,
                ),
              ),
              Text(
                detailText,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        // RichText(
        //   text: TextSpan(
        //     children: [
        //       WidgetSpan(
        //         alignment: PlaceholderAlignment.middle,
        //         child: Icon(
        //           Icons.circle,
        //           color: const Color(0xFFF9D422),
        //           size: screenWidth * 0.025,
        //         ),
        //       ),
        //       WidgetSpan(
        //         child: SizedBox(width: screenWidth * 0.02),
        //       ),
        //       TextSpan(
        //         text: detailText,
        //         style: const TextStyle(
        //           fontSize: 14,
        //           color: Colors.black,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }

  Widget subscriptionPlan3Container(
      double screenWidth, double screenHeight, String text) {
    return InkWell(
      onTap: () {
        setState(() {
          _three = true;
          _six = false;
          _twelve = false;
        });
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: screenWidth * 0.25,
          height: screenHeight * 0.04,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: _three ? secondoryColor : Colors.grey.shade100,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: fontFamily,
            ),
          ),
        ),
      ),
    );
  }

  Widget subscriptionPlan6Container(
      double screenWidth, double screenHeight, String text) {
    return InkWell(
      onTap: () {
        setState(() {
          _three = false;
          _six = true;
          _twelve = false;
        });
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: screenWidth * 0.25,
          height: screenHeight * 0.04,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: _six ? secondoryColor : Colors.grey.shade100,
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: fontFamily,
            ),
          ),
        ),
      ),
    );
  }

  Widget subscriptionPlan12Container(
      double screenWidth, double screenHeight, String text) {
    return InkWell(
      onTap: () {
        setState(() {
          _three = false;
          _six = false;
          _twelve = true;
        });
      },
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: screenWidth * 0.25,
          height: screenHeight * 0.04,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: _twelve ? const Color(0xFFF9D422) : Colors.grey.shade100,
          ),
          child: Text(text),
        ),
      ),
    );
  }
}



// ListTile(
//       minLeadingWidth: 0,
//       horizontalTitleGap: screenWidth * 0.02,
//       leading: Icon(
//         Icons.circle,
//         color: const Color(0xFFF9D422),
//         size: screenWidth * 0.025,
//       ),
//       title: Text(
//         detailText,
//         style: const TextStyle(
//           fontSize: 14,
//         ),
//       ),
//     );