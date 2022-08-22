import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/studio_code/scommon/scommon.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:first_app/studio_code/spages/sprofilePages/sprojectPage/ssubscriptionPages/saddCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SPaymentPage extends StatefulWidget {
  const SPaymentPage({Key? key}) : super(key: key);

  static const String routeName = "/spayment-page";

  @override
  State<SPaymentPage> createState() => _SPaymentPageState();
}

class _SPaymentPageState extends State<SPaymentPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:
          paymentAppBar(screenHeight, screenWidth, context, "Payment Methods"),
      body: Column(
        children: [
          SizedBox(height: screenHeight * 0.04),
          Container(
            width: screenWidth,
            height: screenHeight * 0.32,
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight * 0.058,
                  child: ListTile(
                    minLeadingWidth: 0,
                    leading: SvgPicture.asset("asset/icons/v1.svg"),
                    title: const Text("Credit/Debit card"),
                  ),
                ),
                Divider(
                  thickness: 2,
                  height: 0.1,
                  color: Colors.grey[400],
                  indent: screenWidth * 0.02,
                  endIndent: screenWidth * 0.02,
                ),
                SizedBox(height: screenHeight * 0.04),
                debitCardContainer(screenHeight, screenWidth,
                    "asset/icons/mastercard.svg", "Axis bank ****1234"),
                SizedBox(height: screenHeight * 0.01),
                debitCardContainer(screenHeight, screenWidth,
                    "asset/icons/visa.svg", "HDFC bank ****1234"),
                SizedBox(height: screenHeight * 0.03),
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.05,
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.yellow.shade800,
                      width: 2,
                    ),
                    color: Colors.yellow.shade800.withOpacity(0.5),
                  ),
                  child: ListTile(
                    dense: true,
                    visualDensity: const VisualDensity(vertical: -2),
                    minLeadingWidth: 30,
                    onTap: () {
                      Navigator.pushNamed(context, SAddCardPage.routeName);
                    },
                    leading: const Icon(
                      Icons.add_circle,
                      color: Colors.black,
                    ),
                    title: const Text(
                      "Add Card",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Container(
            width: screenWidth,
            height: screenHeight * 0.07,
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              dense: true,
              visualDensity: const VisualDensity(vertical: 3),
              minLeadingWidth: 30,
              leading: SvgPicture.asset("asset/icons/vv.svg"),
              title: const Text(
                "Net Banking",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(
                  MyFlutterApp.arrow_right_2,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ),
          ),
          Container(
            width: screenWidth * 0.50,
            height: screenHeight * 0.05,
            margin: EdgeInsets.only(top: screenHeight * 0.25),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: secondoryColor,
            ),
            alignment: Alignment.center,
            child: const Text(
              "Checkout",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
