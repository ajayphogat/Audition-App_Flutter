import 'package:first_app/homePage/homePage.dart';
import 'package:first_app/login/forgotPassword.dart';
import 'package:first_app/login/loginPage.dart';
import 'package:first_app/login/mainPage.dart';
import 'package:first_app/login/signUpPage.dart';
import 'package:first_app/login/verifiedPage.dart';
import 'package:first_app/login/verifyMobile.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyAPP());

class MyAPP extends StatelessWidget {
  const MyAPP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => ForgotPassword(), //FIXME: Change this Starting Screen
        LoginPage.routeName: (context) => const LoginPage(),
        SignupPage.routeName: (context) => const SignupPage(),
        VerifyMobile.routeName: (context) => const VerifyMobile(),
        VerifiedPage.routeName: (context) => const VerifiedPage(),
        ForgotPassword.routeName: (context) => ForgotPassword(),
        HomePage.routeName: (context) => const HomePage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
