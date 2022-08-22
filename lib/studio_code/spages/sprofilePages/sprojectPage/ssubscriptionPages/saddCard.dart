import 'package:first_app/studio_code/scommon/scommon.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SAddCardPage extends StatefulWidget {
  const SAddCardPage({Key? key}) : super(key: key);

  static const String routeName = "/saddCard-page";

  @override
  State<SAddCardPage> createState() => _SAddCardPageState();
}

class _SAddCardPageState extends State<SAddCardPage> {
  late TextEditingController _cardHolderName;
  late TextEditingController _cardNumber;
  late TextEditingController _expireDate;
  late TextEditingController _cvv;

  @override
  void initState() {
    super.initState();
    _cardHolderName = TextEditingController();
    _cardNumber = TextEditingController();
    _expireDate = TextEditingController();
    _cvv = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _cardHolderName.dispose();
    _cardNumber.dispose();
    _expireDate.dispose();
    _cvv.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: paymentAppBar(screenHeight, screenWidth, context, "Add Card"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.04),
            Container(
              width: screenWidth,
              height: screenHeight * 0.42,
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
                  SizedBox(height: screenHeight * 0.02),
                  addCardField(screenWidth, screenHeight, "Cardholder Name",
                      "Enter your name", _cardHolderName),
                  SizedBox(height: screenHeight * 0.03),
                  addCardField(screenWidth, screenHeight, "Card Number",
                      "Enter your card number", _cardNumber),
                  SizedBox(height: screenHeight * 0.03),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        smallAddCard(screenWidth, screenHeight, "Expire Date",
                            "**/**/***", _expireDate),
                        smallAddCard(
                            screenWidth, screenHeight, "CVV", "***", _cvv),
                      ],
                    ),
                  ),
                ],
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
                "Add Card",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding addCardField(double screenWidth, double screenHeight, String text1,
      String text2, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text1,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Container(
            width: screenWidth * 0.75,
            height: screenHeight * 0.045,
            padding: EdgeInsets.only(left: screenWidth * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 2,
              ),
              color: Colors.white,
            ),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: text2,
                hintStyle: const TextStyle(
                  fontSize: 15,
                  fontFamily: fontFamily,
                  color: placeholderTextColor,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget smallAddCard(double screenWidth, double screenHeight, String text1,
      String text2, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Container(
          width: screenWidth * 0.30,
          height: screenHeight * 0.045,
          padding: EdgeInsets.only(
              left: screenWidth * 0.02, top: screenHeight * 0.02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.grey.shade400,
              width: 2,
            ),
            color: Colors.white,
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: text2,
              hintStyle: const TextStyle(
                fontSize: 20,
                fontFamily: fontFamily,
                color: placeholderTextColor,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Container debitCardContainer(
      double screenHeight, double screenWidth, String assetName, String text) {
    return Container(
      height: screenHeight * 0.05,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade400, width: 2),
        color: Colors.white,
      ),
      child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(vertical: -2),
        minLeadingWidth: 30,
        leading:
            AspectRatio(aspectRatio: 0.68, child: SvgPicture.asset(assetName)),
        title: Text(text),
        trailing: Stack(
          children: [
            Container(
              width: screenWidth * 0.04,
              height: screenWidth * 0.04,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 4,
                ),
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
