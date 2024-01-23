import 'package:auto_size_text/auto_size_text.dart';
import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/utils/showSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';
import '../myProfilePage.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  static const String routeName = "/subscription-Page";

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  // bool _three = true;
  // bool _six = false;
  // bool _twelve = false;

  // bool _platinum = false;
  // bool _gold = false;
  // bool _silver = false;
  final AuthService authService = AuthService();
  String? s1;

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

    var user = Provider.of<UserProvider>(context).user;
    user.subscriptionName == "Free"
        ? s1 = "You can apply to Unlimited Jobs"
        : user.subscriptionName == "Silver"
            ? "You can apply to 30 Jobs/Month"
            : user.subscriptionName == "Gold"
                ? "You can apply to 70 Jobs/Month"
                : "You can apply to Unlimited Jobs";
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: const Icon(MyFlutterApp.bi_arrow_down, color: Colors.black),
      //   ),
      //   title: const Text(
      //     "Subscription Plan",
      //     style: TextStyle(
      //       color: Colors.black,
      //       fontSize: 20,
      //     ),
      //   ),
      //   centerTitle: true,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Image.asset("asset/images/uiImages/Home.png"),
                  Column(
                    children: [
                      Container(
                        width: screenWidth,
                        height: screenHeight * 0.0689,
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025),
                        decoration: const BoxDecoration(
                          // color: Colors.red,
                          image: DecorationImage(
                            image: AssetImage(
                              "asset/images/uiImages/media_appbar.png",
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back_ios_sharp),
                            SizedBox(width: screenWidth * 0.04),
                            const AutoSizeText(
                              "Subscription Plans",
                              maxFontSize: 20,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.04),
                      Container(
                        width: screenWidth,
                        height: screenHeight * 0.2,
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.01,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xffF4D243).withOpacity(0.56),
                              Color(0xffF4D243).withOpacity(0),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "Current Plan (${user.subscriptionName})",
                              maxFontSize: 25,
                              style: TextStyle(
                                fontSize: 25,
                                color: Color(0xff2D2D2D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: screenWidth * 0.02,
                                      top: screenHeight * 0.0035),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    // color: const Color(0xFFF9D422),
                                    size: screenWidth * 0.015,
                                  ),
                                ),
                                AutoSizeText(
                                  s1!,
                                  // "Studio can post Unlimited Jobs",
                                  maxFontSize: 14,
                                  minFontSize: 10,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: screenWidth * 0.02,
                                      top: screenHeight * 0.0035),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    // color: const Color(0xFFF9D422),
                                    size: screenWidth * 0.015,
                                  ),
                                ),
                                AutoSizeText(
                                  "You are able to chat with Studios",
                                  // "Studio able to chat with Applicants",
                                  maxFontSize: 14,
                                  minFontSize: 10,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: screenWidth * 0.02,
                                      top: screenHeight * 0.0035),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    // color: const Color(0xFFF9D422),
                                    size: screenWidth * 0.015,
                                  ),
                                ),
                                AutoSizeText(
                                  "All Basic Features are Available",
                                  maxFontSize: 14,
                                  minFontSize: 10,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: screenWidth * 0.04,
                      //       vertical: screenHeight * 0.02),
                      //   child: Image.asset("asset/images/subscription_banner/banner.png"),
                      // ),
                      SizedBox(height: screenHeight * 0.05),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            "Why Subscribe?",
                            maxFontSize: 22,
                            minFontSize: 14,
                            style: TextStyle(
                              fontSize: 22,
                              color: Color(0xff2D2D2D),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025),
                        child: AutoSizeText(
                          "To get the access of whole application features without having any issue as per the T&C .",
                          maxFontSize: 16,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff2D2D2D),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      // InkWell(
                      //   onTap: () {
                      //     setState(() {
                      //       _platinum = !_platinum;
                      //       _gold = false;
                      //       _silver = false;
                      //     });
                      //   },
                      //   child:
                      Container(
                        // duration: const Duration(milliseconds: 500),
                        width: screenWidth,
                        // height:
                        //     _platinum ? screenHeight * 0.38 : screenHeight * 0.295,
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.01,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xffF4D243).withOpacity(0.56),
                              Color(0xffF4D243).withOpacity(0),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "Platinum",
                              maxFontSize: 25,
                              style: TextStyle(
                                fontSize: 25,
                                color: Color(0xff2D2D2D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: screenWidth * 0.02,
                                      top: screenHeight * 0.0035),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    // color: const Color(0xFFF9D422),
                                    size: screenWidth * 0.015,
                                  ),
                                ),
                                AutoSizeText(
                                  "You can apply to Unlimited Jobs",
                                  // "Studio can post Unlimited Jobs",
                                  maxFontSize: 14,
                                  minFontSize: 10,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: screenWidth * 0.02,
                                      top: screenHeight * 0.0035),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    // color: const Color(0xFFF9D422),
                                    size: screenWidth * 0.015,
                                  ),
                                ),
                                AutoSizeText(
                                  "You are able to chat with Studios",
                                  // "Studio able to chat with Applicants",
                                  maxFontSize: 14,
                                  minFontSize: 10,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: screenWidth * 0.02,
                                      top: screenHeight * 0.0035),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    // color: const Color(0xFFF9D422),
                                    size: screenWidth * 0.015,
                                  ),
                                ),
                                AutoSizeText(
                                  "All Basic Features are Available",
                                  maxFontSize: 14,
                                  minFontSize: 10,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            // Container(
                            //   // duration: const Duration(milliseconds: 500),
                            //   width: screenWidth,
                            //   height: screenHeight * 0.085,
                            //   // height: _platinum ? screenHeight * 0.085 : 0,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       AutoSizeText(
                            //         "Choose duration",
                            //         maxFontSize: 18,
                            //         style: TextStyle(
                            //           fontSize: 18,
                            //           fontWeight: FontWeight.bold,
                            //           color: Color(0xff2D2D2D),
                            //         ),
                            //       ),
                            //       SizedBox(height: screenHeight * 0.01),
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           InkWell(
                            //             onTap: () {
                            //               setState(() {
                            //                 _three = true;
                            //                 _six = false;
                            //               });
                            //             },
                            //             child: Container(
                            //               width: screenWidth * 0.3,
                            //               height: screenHeight * 0.04,
                            //               decoration: BoxDecoration(
                            //                 borderRadius: BorderRadius.circular(50),
                            //                 border: Border.all(
                            //                   width: 2,
                            //                   color:
                            //                       _three ? greenColor : Colors.grey,
                            //                 ),
                            //                 color: Colors.grey[50],
                            //               ),
                            //               alignment: Alignment.center,
                            //               child: AutoSizeText(
                            //                 "3 months",
                            //                 maxFontSize: 16,
                            //                 style: TextStyle(
                            //                   fontSize: 16,
                            //                   color:
                            //                       _three ? greenColor : Colors.grey,
                            //                   fontWeight: FontWeight.w500,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //           InkWell(
                            //             onTap: () {
                            //               setState(() {
                            //                 _six = true;
                            //                 _three = false;
                            //               });
                            //             },
                            //             child: Container(
                            //               width: screenWidth * 0.3,
                            //               height: screenHeight * 0.04,
                            //               decoration: BoxDecoration(
                            //                 borderRadius: BorderRadius.circular(50),
                            //                 border: Border.all(
                            //                   width: 2,
                            //                   color: _six ? greenColor : Colors.grey,
                            //                 ),
                            //                 color: Colors.grey[50],
                            //               ),
                            //               alignment: Alignment.center,
                            //               child: AutoSizeText(
                            //                 "6 months",
                            //                 maxFontSize: 16,
                            //                 style: TextStyle(
                            //                   fontSize: 16,
                            //                   color: _six ? greenColor : Colors.grey,
                            //                   fontWeight: FontWeight.w500,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(height: screenHeight * 0.015),
                            Divider(
                              height: 0,
                              thickness: 1,
                              color: const Color(0xff000000).withOpacity(0.13),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const AutoSizeText(
                                  "\u{20B9}8000/month",
                                  maxFontSize: 18,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff2D2D2D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            UsePaypal(
                                          sandboxMode: false,
                                          onSuccess: (Map params) async {
                                            navigatePop() =>
                                                Navigator.pop(context);
                                            circularProgressIndicatorNew(
                                                context);
                                            await updateSubscription(
                                                "Platinum", "96.84");
                                            navigatePop();
                                          },
                                          onError: (error) {
                                            showSnackBar(
                                                context, error.toString());
                                          },
                                          onCancel: (params) {
                                            showSnackBar(context, params);
                                          },
                                          returnURL:
                                              "https://samplesite.com/return",
                                          cancelURL:
                                              "https://samplesite.com/cancel",
                                          transactions: const [
                                            {
                                              "amount": {
                                                "total": "96.84",
                                                "currency": "USD",
                                                "details": {
                                                  "subtotal": "96.84",
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
                                                    "price": "96.84",
                                                    "currency": "USD"
                                                  }
                                                ],
                                              }
                                            }
                                          ],
                                          note:
                                              "Contact us for any questions on your order.",
                                          clientId:
                                              "Ad0bmje1jZ7jEuOosaOb_B4IKfluOldXdmCAAai4y0VKsGCUQosAJghTE76_3DLq6NfRttuDXIDZM8KU",
                                          secretKey:
                                              "EBD9rXSI98EGlvvXFIAhCO3eSXgcpAk0368jlAyZDsHU2Paam_GsK27BLkA6fZwIy4BFl_OhuVTOCuZQ",
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: screenWidth * 0.4,
                                    height: screenHeight * 0.05,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: greenColor,
                                    ),
                                    alignment: Alignment.center,
                                    child: const AutoSizeText(
                                      "Go Platinum",
                                      maxFontSize: 18,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // ),
                      SizedBox(height: screenHeight * 0.02),
                      // InkWell(
                      //   onTap: () {
                      //     setState(() {
                      //       _gold = !_gold;
                      //       _platinum = false;
                      //       _silver = false;
                      //     });
                      //   },
                      //   child:
                      Container(
                        width: screenWidth,
                        // height: screenHeight * 0.38,
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.01,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              const Color(0xffF4D243).withOpacity(0.56),
                              const Color(0xffF4D243).withOpacity(0),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const AutoSizeText(
                              "Gold",
                              maxFontSize: 25,
                              style: TextStyle(
                                fontSize: 25,
                                color: Color(0xff2D2D2D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: screenWidth * 0.02,
                                      top: screenHeight * 0.0035),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    // color: const Color(0xFFF9D422),
                                    size: screenWidth * 0.015,
                                  ),
                                ),
                                const AutoSizeText(
                                  "You can apply to 70 Jobs/Month",
                                  // "Studio can post 70 Jobs/Month",
                                  maxFontSize: 14,
                                  minFontSize: 10,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: screenWidth * 0.02,
                                      top: screenHeight * 0.0035),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    // color: const Color(0xFFF9D422),
                                    size: screenWidth * 0.015,
                                  ),
                                ),
                                AutoSizeText(
                                  "You are able to chat with Studios",
                                  // "Studio able to chat with Applicants",
                                  maxFontSize: 14,
                                  minFontSize: 10,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: screenWidth * 0.02,
                                      top: screenHeight * 0.0035),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    // color: const Color(0xFFF9D422),
                                    size: screenWidth * 0.015,
                                  ),
                                ),
                                AutoSizeText(
                                  "All Basic Features are Available",
                                  maxFontSize: 14,
                                  minFontSize: 10,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            // Container(
                            //   // duration: const Duration(milliseconds: 500),
                            //   width: screenWidth,
                            //   height: screenHeight * 0.085,
                            //   // height: _gold ? screenHeight * 0.085 : 0,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       AutoSizeText(
                            //         "Choose duration",
                            //         maxFontSize: 18,
                            //         style: TextStyle(
                            //           fontSize: 18,
                            //           fontWeight: FontWeight.bold,
                            //           color: Color(0xff2D2D2D),
                            //         ),
                            //       ),
                            //       SizedBox(height: screenHeight * 0.01),
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           InkWell(
                            //             onTap: () {
                            //               setState(() {
                            //                 _three = true;
                            //                 _six = false;
                            //               });
                            //             },
                            //             child: Container(
                            //               width: screenWidth * 0.3,
                            //               height: screenHeight * 0.04,
                            //               decoration: BoxDecoration(
                            //                 borderRadius: BorderRadius.circular(50),
                            //                 border: Border.all(
                            //                   width: 2,
                            //                   color:
                            //                       _three ? greenColor : Colors.grey,
                            //                 ),
                            //                 color: Colors.grey[50],
                            //               ),
                            //               alignment: Alignment.center,
                            //               child: AutoSizeText(
                            //                 "3 months",
                            //                 maxFontSize: 16,
                            //                 style: TextStyle(
                            //                   fontSize: 16,
                            //                   color:
                            //                       _three ? greenColor : Colors.grey,
                            //                   fontWeight: FontWeight.w500,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //           InkWell(
                            //             onTap: () {
                            //               setState(() {
                            //                 _six = true;
                            //                 _three = false;
                            //               });
                            //             },
                            //             child: Container(
                            //               width: screenWidth * 0.3,
                            //               height: screenHeight * 0.04,
                            //               decoration: BoxDecoration(
                            //                 borderRadius: BorderRadius.circular(50),
                            //                 border: Border.all(
                            //                   width: 2,
                            //                   color: _six ? greenColor : Colors.grey,
                            //                 ),
                            //                 color: Colors.grey[50],
                            //               ),
                            //               alignment: Alignment.center,
                            //               child: AutoSizeText(
                            //                 "6 months",
                            //                 maxFontSize: 16,
                            //                 style: TextStyle(
                            //                   fontSize: 16,
                            //                   color: _six ? greenColor : Colors.grey,
                            //                   fontWeight: FontWeight.w500,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(height: screenHeight * 0.015),
                            Divider(
                              height: 0,
                              thickness: 1,
                              color: Color(0xff000000).withOpacity(0.13),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AutoSizeText(
                                  "\u{20B9}5000/month",
                                  maxFontSize: 18,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff2D2D2D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              UsePaypal(
                                                sandboxMode: false,
                                                onSuccess: (Map params) async {
                                                  navigatePop() =>
                                                      Navigator.pop(context);
                                                  circularProgressIndicatorNew(
                                                      context);
                                                  await updateSubscription(
                                                      "Gold", "60.52");
                                                  navigatePop();
                                                },
                                                onError: (error) {
                                                  showSnackBar(context,
                                                      error.toString());
                                                },
                                                onCancel: (params) {
                                                  showSnackBar(context, params);
                                                },
                                                returnURL:
                                                    "https://samplesite.com/return",
                                                cancelURL:
                                                    "https://samplesite.com/cancel",
                                                transactions: [
                                                  {
                                                    "amount": {
                                                      "total": "60.52",
                                                      "currency": "USD",
                                                      "details": {
                                                        "subtotal": "60.52",
                                                        "shipping": "0",
                                                        "shipping_discount": 0
                                                      }
                                                    },
                                                    "description":
                                                        "The payment transaction description",
                                                    "item_list": {
                                                      "items": [
                                                        {
                                                          "name":
                                                              "A demo product",
                                                          "quantity": 1,
                                                          "price": "60.52",
                                                          "currency": "USD"
                                                        }
                                                      ],
                                                    }
                                                  }
                                                ],
                                                note:
                                                    "Contact us for any questions on your order.",
                                                clientId:
                                                    "Ad0bmje1jZ7jEuOosaOb_B4IKfluOldXdmCAAai4y0VKsGCUQosAJghTE76_3DLq6NfRttuDXIDZM8KU",
                                                secretKey:
                                                    "EBD9rXSI98EGlvvXFIAhCO3eSXgcpAk0368jlAyZDsHU2Paam_GsK27BLkA6fZwIy4BFl_OhuVTOCuZQ",
                                              )),
                                    );
                                  },
                                  child: Container(
                                    width: screenWidth * 0.4,
                                    height: screenHeight * 0.05,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: greenColor,
                                    ),
                                    alignment: Alignment.center,
                                    child: const AutoSizeText(
                                      "Go Gold",
                                      maxFontSize: 18,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // ),
                      SizedBox(height: screenHeight * 0.02),
                      // InkWell(
                      //   onTap: () {
                      //     setState(() {
                      //       _silver = !_silver;
                      //       _gold = false;
                      //       _platinum = false;
                      //     });
                      //   },
                      //   child:
                      Container(
                        width: screenWidth,
                        // height: screenHeight * 0.38,
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.01,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xffF4D243).withOpacity(0.56),
                              Color(0xffF4D243).withOpacity(0),
                            ],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              "Silver",
                              maxFontSize: 25,
                              style: TextStyle(
                                fontSize: 25,
                                color: Color(0xff2D2D2D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: screenWidth * 0.02,
                                      top: screenHeight * 0.0035),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    // color: const Color(0xFFF9D422),
                                    size: screenWidth * 0.015,
                                  ),
                                ),
                                AutoSizeText(
                                  "You can apply to 30 Jobs/Month",
                                  // "Studio can post 30 Jobs/Month",
                                  maxFontSize: 14,
                                  minFontSize: 10,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: screenWidth * 0.02,
                                      top: screenHeight * 0.0035),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    // color: const Color(0xFFF9D422),
                                    size: screenWidth * 0.015,
                                  ),
                                ),
                                AutoSizeText(
                                  "You are able to chat with Studios",
                                  // "Studio able to chat with Applicants",
                                  maxFontSize: 14,
                                  minFontSize: 10,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: screenWidth * 0.02,
                                      top: screenHeight * 0.0035),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.black,
                                    // color: const Color(0xFFF9D422),
                                    size: screenWidth * 0.015,
                                  ),
                                ),
                                AutoSizeText(
                                  "All Basic Features are Available",
                                  maxFontSize: 14,
                                  minFontSize: 10,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            // Container(
                            //   // duration: const Duration(milliseconds: 500),
                            //   width: screenWidth,
                            //   height: screenHeight * 0.085,
                            //   // height: _silver ? screenHeight * 0.085 : 0,
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       AutoSizeText(
                            //         "Choose duration",
                            //         maxFontSize: 18,
                            //         style: TextStyle(
                            //           fontSize: 18,
                            //           fontWeight: FontWeight.bold,
                            //           color: Color(0xff2D2D2D),
                            //         ),
                            //       ),
                            //       SizedBox(height: screenHeight * 0.01),
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: [
                            //           InkWell(
                            //             onTap: () {
                            //               setState(() {
                            //                 _three = true;
                            //                 _six = false;
                            //               });
                            //             },
                            //             child: Container(
                            //               width: screenWidth * 0.3,
                            //               height: screenHeight * 0.04,
                            //               decoration: BoxDecoration(
                            //                 borderRadius: BorderRadius.circular(50),
                            //                 border: Border.all(
                            //                   width: 2,
                            //                   color:
                            //                       _three ? greenColor : Colors.grey,
                            //                 ),
                            //                 color: Colors.grey[50],
                            //               ),
                            //               alignment: Alignment.center,
                            //               child: AutoSizeText(
                            //                 "3 months",
                            //                 maxFontSize: 16,
                            //                 style: TextStyle(
                            //                   fontSize: 16,
                            //                   color:
                            //                       _three ? greenColor : Colors.grey,
                            //                   fontWeight: FontWeight.w500,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //           InkWell(
                            //             onTap: () {
                            //               setState(() {
                            //                 _six = true;
                            //                 _three = false;
                            //               });
                            //             },
                            //             child: Container(
                            //               width: screenWidth * 0.3,
                            //               height: screenHeight * 0.04,
                            //               decoration: BoxDecoration(
                            //                 borderRadius: BorderRadius.circular(50),
                            //                 border: Border.all(
                            //                   width: 2,
                            //                   color: _six ? greenColor : Colors.grey,
                            //                 ),
                            //                 color: Colors.grey[50],
                            //               ),
                            //               alignment: Alignment.center,
                            //               child: AutoSizeText(
                            //                 "6 months",
                            //                 maxFontSize: 16,
                            //                 style: TextStyle(
                            //                   fontSize: 16,
                            //                   color: _six ? greenColor : Colors.grey,
                            //                   fontWeight: FontWeight.w500,
                            //                 ),
                            //               ),
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(height: screenHeight * 0.015),
                            Divider(
                              height: 0,
                              thickness: 1,
                              color: Color(0xff000000).withOpacity(0.13),
                            ),
                            SizedBox(height: screenHeight * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AutoSizeText(
                                  "\u{20B9}3000/month",
                                  maxFontSize: 18,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff2D2D2D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              UsePaypal(
                                                sandboxMode: false,
                                                onSuccess: (Map params) async {
                                                  navigatePop() =>
                                                      Navigator.pop(context);
                                                  circularProgressIndicatorNew(
                                                      context);
                                                  await updateSubscription(
                                                      "Silver", "36.31");
                                                  navigatePop();
                                                },
                                                onError: (error) {
                                                  showSnackBar(context,
                                                      error.toString());
                                                },
                                                onCancel: (params) {
                                                  showSnackBar(context, params);
                                                },
                                                returnURL:
                                                    "https://samplesite.com/return",
                                                cancelURL:
                                                    "https://samplesite.com/cancel",
                                                transactions: [
                                                  {
                                                    "amount": {
                                                      "total": "36.31",
                                                      "currency": "USD",
                                                      "details": {
                                                        "subtotal": "36.31",
                                                        "shipping": "0",
                                                        "shipping_discount": 0
                                                      }
                                                    },
                                                    "description":
                                                        "The payment transaction description",
                                                    "item_list": {
                                                      "items": [
                                                        {
                                                          "name":
                                                              "A demo product",
                                                          "quantity": 1,
                                                          "price": "36.31",
                                                          "currency": "USD"
                                                        }
                                                      ],
                                                    }
                                                  }
                                                ],
                                                note:
                                                    "Contact us for any questions on your order.",
                                                clientId:
                                                    "Ad0bmje1jZ7jEuOosaOb_B4IKfluOldXdmCAAai4y0VKsGCUQosAJghTE76_3DLq6NfRttuDXIDZM8KU",
                                                secretKey:
                                                    "EBD9rXSI98EGlvvXFIAhCO3eSXgcpAk0368jlAyZDsHU2Paam_GsK27BLkA6fZwIy4BFl_OhuVTOCuZQ",
                                              )),
                                    );
                                  },
                                  child: Container(
                                    width: screenWidth * 0.4,
                                    height: screenHeight * 0.05,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: greenColor,
                                    ),
                                    alignment: Alignment.center,
                                    child: const AutoSizeText(
                                      "Go Silver",
                                      maxFontSize: 18,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // ),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ],
              ),

              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       subscriptionPlan3Container(
              //           screenWidth, screenHeight, "3 Months"),
              //       subscriptionPlan6Container(
              //           screenWidth, screenHeight, "6 Months"),
              //       subscriptionPlan12Container(
              //           screenWidth, screenHeight, "12 Months"),
              //     ],
              //   ),
              // ),
              // SizedBox(height: screenHeight * 0.03),

              // Container(
              //   width: screenWidth,
              //   height: screenHeight * 0.30,
              //   margin: EdgeInsets.only(bottom: screenHeight * 0.02),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     color: Colors.white,
              //     boxShadow: const [
              //       BoxShadow(
              //         offset: Offset(3, 3),
              //         blurRadius: 5,
              //         spreadRadius: 2,
              //         color: Colors.black12,
              //       ),
              //     ],
              //   ),
              //   child: Row(
              //     children: [
              //       Container(
              //         width: screenWidth * 0.25,
              //         height: screenHeight * 0.30,
              //         decoration: const BoxDecoration(
              //           borderRadius: BorderRadius.only(
              //             topLeft: Radius.circular(10),
              //             bottomLeft: Radius.circular(10),
              //           ),
              //           color: Color(0xFFFFD0D0),
              //         ),
              //         child: Image.asset("asset/images/uiImages/yygg.png"),
              //       ),
              //       Container(
              //         width: screenWidth * 0.70,
              //         padding: EdgeInsets.only(
              //             right: screenWidth * 0.02, left: screenWidth * 0.02),
              //         decoration: const BoxDecoration(
              //           borderRadius: BorderRadius.only(
              //             topRight: Radius.circular(10),
              //             bottomRight: Radius.circular(10),
              //           ),
              //         ),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Text(
              //                   _three
              //                       ? "Silver"
              //                       : _six
              //                           ? "Gold"
              //                           : _twelve
              //                               ? "Platinum"
              //                               : "",
              //                   style: const TextStyle(
              //                     fontSize: 20,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //             planDetails(
              //               screenHeight,
              //               screenWidth,
              //               _three
              //                   ? "Studio can post 30 Jobs/Month"
              //                   : _six
              //                       ? "Studio can post 70 Jobs/Month"
              //                       : _twelve
              //                           ? "Studio can post Unlimited Jobs"
              //                           : "",
              //             ),
              //             // planDetails(
              //             //   screenHeight,
              //             //   screenWidth,
              //             //   "Studio able to chat with Applicants",
              //             // ),
              //             planDetails(
              //               screenHeight,
              //               screenWidth,
              //               "All Basic Features are Available",
              //             ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
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
        // setState(() {
        //   _three = true;
        //   _six = false;
        //   _twelve = false;
        // });
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
            // color: _three ? secondoryColor : Colors.grey.shade100,
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
        // setState(() {
        //   _three = false;
        //   _six = true;
        //   _twelve = false;
        // });
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
            // color: _six ? secondoryColor : Colors.grey.shade100,
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
        // setState(() {
        //   _three = false;
        //   _six = false;
        //   _twelve = true;
        // });
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
            // color: _twelve ? const Color(0xFFF9D422) : Colors.grey.shade100,
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
