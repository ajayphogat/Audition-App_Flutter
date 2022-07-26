import 'package:first_app/common/common.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  static const String routeName = "/subscription-Page";

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  bool three = false;
  bool six = true;
  bool twelve = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                          color: Color(0xFF30319D),
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
              style: TextStyle(fontSize: 25),
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
                subscriptionPlan3Container(
                    screenWidth, screenHeight, "3 Months"),
                subscriptionPlan6Container(
                    screenWidth, screenHeight, "6 Months"),
                subscriptionPlan12Container(
                    screenWidth, screenHeight, "12 Months"),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.10),
          Container(
            width: screenWidth,
            height: screenHeight * 0.60,
            child: ListView.builder(
              itemCount: 2,
              itemBuilder: (context, index) {
                return Container(
                  width: screenWidth * 0.85,
                  height: screenHeight * 0.50,
                  color: Colors.orange,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget subscriptionPlan3Container(
      double screenWidth, double screenHeight, String text) {
    return InkWell(
      onTap: () {
        setState(() {
          three = true;
          six = false;
          twelve = false;
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
            color: three ? const Color(0xFFF9D422) : Colors.grey.shade300,
          ),
          child: Text(text),
        ),
      ),
    );
  }

  Widget subscriptionPlan6Container(
      double screenWidth, double screenHeight, String text) {
    return InkWell(
      onTap: () {
        setState(() {
          three = false;
          six = true;
          twelve = false;
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
            color: six ? const Color(0xFFF9D422) : Colors.grey.shade300,
          ),
          child: Text(text),
        ),
      ),
    );
  }

  Widget subscriptionPlan12Container(
      double screenWidth, double screenHeight, String text) {
    return InkWell(
      onTap: () {
        setState(() {
          three = false;
          six = false;
          twelve = true;
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
            color: twelve ? const Color(0xFFF9D422) : Colors.grey.shade300,
          ),
          child: Text(text),
        ),
      ),
    );
  }
}
