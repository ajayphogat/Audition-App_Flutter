import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  static const String routeName = '/payment-page';

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Payment",
                      style: TextStyle(
                        fontSize: 30,
                        color: thirdColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              newBankDetails(screenWidth, screenHeight, "Bank Name",
                  "Enter your bank name"),
              SizedBox(height: screenHeight * 0.03),
              newBankDetails(screenWidth, screenHeight, "Account Holder Name",
                  "Enter account holder name"),
              SizedBox(height: screenHeight * 0.03),
              newBankDetails(
                  screenWidth, screenHeight, "IFSC", "Enter IFSC code"),
              SizedBox(height: screenHeight * 0.03),
              newBankDetails(
                  screenWidth, screenHeight, "Amount", "Enter the amount"),
              SizedBox(height: screenHeight * 0.03),
              InkWell(
                onTap: () {
                  newDialogBox(
                      context,
                      screenWidth,
                      screenHeight,
                      "Payment Successfull",
                      "GO HOME",
                      true,
                      BottomNavigationPage.routeName);
                },
                child: Container(
                  alignment: Alignment.center,
                  width: screenWidth * 0.38,
                  height: screenHeight * 0.047,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFF9D422),
                  ),
                  child: const Text(
                    "PAY",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding newBankDetails(double screenWidth, double screenHeight,
      String textName, String hintText) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(left: screenWidth * 0.01),
            child: Text(
              textName,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Container(
            width: screenWidth * 0.75,
            height: screenHeight * 0.045,
            padding: EdgeInsets.only(left: screenWidth * 0.03),
            margin: EdgeInsets.only(top: screenHeight * 0.01),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black,
              ),
              color: placeholderColor,
            ),
            child: TextFormField(
              controller: _textController,
              style: const TextStyle(
                fontSize: 13,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: placeholderTextColor,
                  fontSize: 14,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
