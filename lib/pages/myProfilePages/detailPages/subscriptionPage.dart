import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/utils/showSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

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
  final AuthService authService = AuthService();

  Future<void> updateSubscription(
      String subscriptionName, String subscriptionPrice) async {
    await authService.buySubscription(
      context: context,
      subscriptionName: subscriptionName,
      subscriptionPrice: subscriptionPrice,
    );
  }

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
          Container(
            width: screenWidth,
            height: screenHeight * 0.30,
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
                  height: screenHeight * 0.30,
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
                  width: screenWidth * 0.70,
                  padding: EdgeInsets.only(
                      right: screenWidth * 0.02, left: screenWidth * 0.02),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _three
                                ? "Silver"
                                : _six
                                    ? "Gold"
                                    : _twelve
                                        ? "Platinum"
                                        : "",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      planDetails(
                          screenHeight,
                          screenWidth,
                          _three
                              ? "Studio can post 30 Jobs/Month"
                              : _six
                                  ? "Studio can post 70 Jobs/Month"
                                  : _twelve
                                      ? "Studio can post Unlimited Jobs"
                                      : ""),
                      planDetails(screenHeight, screenWidth,
                          "Studio able to chat with Applicants"),
                      planDetails(screenHeight, screenWidth,
                          "All Basic Features are Available"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => UsePaypal(
                      sandboxMode: true,
                      onSuccess: (Map params) async {
                        navigatePop() => Navigator.pop(context);
                        circularProgressIndicatorNew(context);
                        print("onSuccess: $params");
                        await updateSubscription(
                            _three
                                ? "Silver"
                                : _six
                                    ? "Gold"
                                    : "Platinum",
                            _three
                                ? "12.10"
                                : _six
                                    ? "24.19"
                                    : "60.48");
                        navigatePop();
                      },
                      onError: (error) {
                        print("onError: $error");
                        showSnackBar(context, error.toString());
                      },
                      onCancel: (params) {
                        print("canceled: $params");
                        showSnackBar(context, params);
                      },
                      returnURL: "https://samplesite.com/return",
                      cancelURL: "https://samplesite.com/cancel",
                      transactions: [
                        {
                          "amount": {
                            "total": _three
                                ? "12.10"
                                : _six
                                    ? "24.19"
                                    : "60.48",
                            "currency": "USD",
                            "details": {
                              "subtotal": _three
                                  ? "12.10"
                                  : _six
                                      ? "24.19"
                                      : "60.48",
                              "shipping": "0",
                              "shipping_discount": 0
                            }
                          },
                          "description": "The payment transaction description",
                          "item_list": {
                            "items": [
                              {
                                "name": "A demo product",
                                "quantity": 1,
                                "price": _three
                                    ? "12.10"
                                    : _six
                                        ? "24.19"
                                        : "60.48",
                                "currency": "USD"
                              }
                            ],
                          }
                        }
                      ],
                      note: "Contact us for any questions on your order.",
                      clientId:
                          "AeUtJ9WFeXrkKOkpoQdzgAf7h94_2yqew6mRAmgrDISYRUuZ2fXGSD8FqeQ_lDfV9Li6VxgvpVAs-sDQ",
                      secretKey:
                          "EFi7Xi1NlV62-dhzrIaD3a5Q7dOSgmqrpeOGyw1kl4D7x3gQsDlz-Uf1XltbowPlQz9KYW2QIOrfjYCd",
                    )),
          );
        },
        child: Container(
          width: screenWidth * 0.70,
          height: screenHeight * 0.07,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black),
            color: secondoryColor,
          ),
          child: Text(
            "Pay ${_three ? '\u{20B9}1000' : _six ? '\u{20B9}2000' : '\u{20B9}5000'}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
            // left: screenWidth * 0.04,
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