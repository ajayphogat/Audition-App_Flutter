import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/studio_code/scommon/sdata.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:first_app/studio_code/spages/sprofilePages/sprojectPage/ssubscriptionPages/spaymentPage.dart';
import 'package:first_app/utils/showSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class SSubscriptionPage extends StatefulWidget {
  const SSubscriptionPage({Key? key}) : super(key: key);

  static const String routeName = "/ssubscription-Page";

  @override
  State<SSubscriptionPage> createState() => _SSubscriptionPageState();
}

class _SSubscriptionPageState extends State<SSubscriptionPage> {
  bool _three = false;
  bool _six = true;
  bool _twelve = false;

  final AuthService authService = AuthService();

  Future<void> updateSubscription(
      String subscriptionName, String subscriptionPrice) async {
    await authService.updateSubscriptionStudio(
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
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
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
                              _three
                                  ? "Silver"
                                  : _six
                                      ? "Gold"
                                      : _twelve
                                          ? "Platinum"
                                          : "",
                              style: const TextStyle(fontSize: 22),
                            ),
                            // Text(
                            //   _plans[1],
                            //   style: const TextStyle(fontSize: 16),
                            // ),
                          ],
                        ),
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
                      SizedBox(height: screenHeight * 0.04),
                      Divider(
                        thickness: 1,
                        color: Colors.black,
                        indent: screenWidth * 0.03,
                        endIndent: screenWidth * 0.03,
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      InkWell(
                        // onTap: () {
                        //   Navigator.pushNamed(context, SPaymentPage.routeName);
                        // },
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
                                      returnURL:
                                          "https://samplesite.com/return",
                                      cancelURL:
                                          "https://samplesite.com/cancel",
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
                                          "description":
                                              "The payment transaction description",
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
                                      note:
                                          "Contact us for any questions on your order.",
                                      clientId:
                                          "AeUtJ9WFeXrkKOkpoQdzgAf7h94_2yqew6mRAmgrDISYRUuZ2fXGSD8FqeQ_lDfV9Li6VxgvpVAs-sDQ",
                                      secretKey:
                                          "EFi7Xi1NlV62-dhzrIaD3a5Q7dOSgmqrpeOGyw1kl4D7x3gQsDlz-Uf1XltbowPlQz9KYW2QIOrfjYCd",
                                    )),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFF9D422),
                          ),
                          child: Text(
                            "PAY ${_three ? '\u{20B9}1000' : _six ? '\u{20B9}2000' : '\u{20B9}5000'}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
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