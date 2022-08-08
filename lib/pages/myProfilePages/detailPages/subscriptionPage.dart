import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/paymentPage/paymentPage.dart';
import 'package:flutter/material.dart';

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
        backgroundColor: Colors.white,
        toolbarHeight: screenHeight * 0.1015,
        actions: [
          SizedBox(
            width: screenWidth,
            height: screenHeight * 0.08,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: screenWidth * 0.02,
                      right: screenWidth * 0.02,
                      top: screenHeight * 0.02,
                      bottom: screenHeight * 0.005),
                  height: screenHeight * 0.02,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.centerLeft,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(MyFlutterApp.bi_arrow_down,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Subscription Plan",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: fontFamily,
                          color: thirdColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.04, top: screenHeight * 0.02),
            child: const Text(
              "Plans",
              style: TextStyle(fontSize: 25, fontFamily: fontFamily),
            ),
          ),
          const Divider(
            thickness: 1,
            color: Colors.black,
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //TODO: Seperate Pages for all the subscription plan(right now only for 6 Month Plan is done)
                subscriptionPlan3Container(
                    screenWidth, screenHeight, "3 Months"),
                subscriptionPlan6Container(
                    screenWidth, screenHeight, "6 Months"),
                subscriptionPlan12Container(
                    screenWidth, screenHeight, "12 Months"),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.06),
          SizedBox(
            height: screenHeight * 0.50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.10,
                  vertical: screenHeight * 0.03),
              physics: const BouncingScrollPhysics(),
              itemCount: subscriptionPlans.length,
              itemBuilder: (context, index) {
                _plans = subscriptionPlans[index];
                return Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.04),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: screenWidth * 0.78,
                      height: screenHeight * 0.50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade100,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: screenHeight * 0.03,
                                left: screenWidth * 0.05,
                                right: screenWidth * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _plans[0],
                                  style: const TextStyle(fontSize: 22),
                                ),
                                Text(
                                  _plans[1],
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                          planDetails(screenHeight, screenWidth, _plans[2]),
                          planDetails(screenHeight, screenWidth, _plans[3]),
                          planDetails(screenHeight, screenWidth, _plans[4]),
                          SizedBox(height: screenHeight * 0.04),
                          Divider(
                            thickness: 1,
                            color: Colors.black,
                            indent: screenWidth * 0.03,
                            endIndent: screenWidth * 0.03,
                          ),
                          SizedBox(height: screenHeight * 0.04),
                          InkWell(
                            //TODO: Assign a function to perform with this buttom
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PaymentPage.routeName);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: const Color(0xFFF9D422),
                              ),
                              child: const Text(
                                "PAY NOW",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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