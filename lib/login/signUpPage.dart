import 'package:auto_size_text/auto_size_text.dart';
import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/login/loginPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  static const String routeName = "/signup-page";

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isObscure = true;
  bool isLoading = false;

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool _showNameError = false;
  bool _showNumberError = false;
  bool _showEmailError = false;
  String _showPassError = "";

  void changeNameError(bool value) {
    setState(() {
      _showNameError = value;
    });
  }

  void changeNumberError(bool value) {
    setState(() {
      _showNumberError = value;
    });
  }

  void changeEmailError(bool value) {
    setState(() {
      _showEmailError = value;
    });
  }

  void changePassError(String value) {
    setState(() {
      _showPassError = value;
    });
  }

  String account = "Audition";

  final _formKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();

  Future<void> signUpAudition() async {
    await authService.signUpUser(
      context: context,
      fname: _fullName.text.trim(),
      email: _email.text.trim(),
      number: _phone.text.trim(),
      password: _password.text,
    );
  }

  Future<void> signUpStudio() async {
    await authService.signUpStudio(
      context: context,
      fname: _fullName.text.trim(),
      email: _email.text.trim(),
      number: _phone.text.trim(),
      password: _password.text,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _fullName.dispose();
    _phone.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Column(
                children: [
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight * 0.25,
                    // color: Colors.grey,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: screenWidth,
                          height: screenHeight * 0.25,
                          child: Image.asset(
                            "asset/images/uiImages/sscreen.png",
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                        Positioned(
                          bottom: screenHeight * 0.02,
                          left: screenWidth * 0.025,
                          child: SizedBox(
                            width: screenWidth,
                            height: screenHeight * 0.05,
                            // color: Colors.blue,
                            child: const AutoSizeText(
                              "Signup",
                              maxLines: 1,
                              maxFontSize: 30,
                              minFontSize: 20,
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // AspectRatio(
                  //   aspectRatio: 2.5,
                  //   child: SvgPicture.asset(
                  //     "asset/images/illustration/signup.svg",
                  //   ),
                  // ),
                  // const SizedBox(height: 30),
                  // const Text(
                  //   "SIGN UP",
                  //   style: TextStyle(
                  //     fontSize: 40,
                  //     fontFamily: fontFamily,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  SizedBox(height: screenHeight * 0.025),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: "Audition",
                              groupValue: account,
                              onChanged: (String? value) {
                                setState(() {
                                  account = value!;
                                });
                              },
                            ),
                            const Text(
                              "Audition",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: "Studio",
                              groupValue: account,
                              onChanged: (String? value) {
                                setState(() {
                                  account = value!;
                                });
                              },
                            ),
                            const Text(
                              "Studio",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  commonTextField(
                      screenWidth,
                      screenHeight,
                      context,
                      _fullName,
                      account == "Studio" ? "Studio Name" : "Full Name",
                      "asset/icons/profile_color.svg",
                      false,
                      changeNameError),
                  _showNameError
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.025),
                          child: Row(
                            children: [
                              const Text(
                                "Please Enter Full Name",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(height: screenHeight * 0.015),
                  commonTextField(
                      screenWidth,
                      screenHeight,
                      context,
                      _phone,
                      "Phone No.",
                      "asset/icons/phone_icon.svg",
                      false,
                      changeNumberError),
                  _showNumberError
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.025),
                          child: Row(
                            children: [
                              const Text(
                                "Please Enter Number",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(height: screenHeight * 0.015),
                  commonTextField(
                      screenWidth,
                      screenHeight,
                      context,
                      _email,
                      "Email",
                      "asset/icons/Message.svg",
                      false,
                      changeEmailError),
                  _showEmailError
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.025),
                          child: Row(
                            children: [
                              const Text(
                                "Please Enter Email",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(height: screenHeight * 0.015),
                  Container(
                    width: screenWidth,
                    margin:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xffDADADA),
                      ),
                    ),
                    child: TextFormField(
                      controller: _password,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          changePassError("Please Enter Password");
                          return "no";
                        } else if (!(value.length >= 8)) {
                          changePassError(
                              "Password must be at least 8 characters");
                          return "no";
                        } else {
                          changePassError("");
                          return null;
                        }
                      },
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(
                        fontSize: 14,
                        fontFamily: fontFamily,
                      ),
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        errorStyle: const TextStyle(
                          color: Colors.transparent,
                          height: 0.001,
                        ),
                        hintText: "Password",
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          fontFamily: fontFamily,
                          color: placeholderTextColor,
                        ),
                        border: InputBorder.none,
                        prefixIcon: Container(
                          width: screenWidth * 0.025,
                          height: screenHeight * 0.025,
                          padding: const EdgeInsets.all(12),
                          child: SvgPicture.asset("asset/icons/Lock.svg"),
                        ),
                        suffixIcon: isObscure
                            ? IconButton(
                                icon: const Icon(MyFlutterApp.show),
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                                iconSize: 20,
                                color: placeholderTextColor,
                              )
                            : IconButton(
                                icon: const Icon(MyFlutterApp.hide),
                                onPressed: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                                iconSize: 28,
                                color: placeholderTextColor,
                              ),
                      ),
                    ),
                  ),
                  _showPassError != ""
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.025),
                          child: Row(
                            children: [
                              Text(
                                _showPassError,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(height: screenHeight * 0.025),
                  InkWell(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus &&
                            currentFocus.focusedChild != null) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                        if (account == "Audition") {
                          setState(() {
                            isLoading = !isLoading;
                          });
                          await signUpAudition();
                          setState(() {
                            isLoading = !isLoading;
                          });
                        } else {
                          // showSnackBar(context, "Not Now");
                          setState(() {
                            isLoading = !isLoading;
                          });
                          await signUpStudio();
                          setState(() {
                            isLoading = !isLoading;
                          });
                        }
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      alignment: Alignment.center,
                      width:
                          isLoading ? screenHeight * 0.047 : screenWidth * 0.7,
                      height: screenHeight * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(isLoading ? 50 : 8),
                        color: greenColor,
                      ),
                      child: isLoading
                          ? SizedBox(
                              height: screenHeight * 0.03,
                              width: screenHeight * 0.03,
                              child: const CircularProgressIndicator(
                                backgroundColor: Colors.black,
                                color: secondoryColor,
                              ),
                            )
                          : const AutoSizeText(
                              "Sign Up",
                              maxLines: 1,
                              maxFontSize: 16,
                              minFontSize: 12,
                              style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  // const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AutoSizeText(
                        "Already have an account? ",
                        maxLines: 1,
                        maxFontSize: 12,
                        minFontSize: 8,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: fontFamily,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, LoginPage.routeName);
                        },
                        child: const AutoSizeText(
                          "Login",
                          maxLines: 1,
                          maxFontSize: 12,
                          minFontSize: 8,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: fontFamily,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

InkWell signUpButton(BuildContext context, formKey, routeName, String text) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.width;
  return InkWell(
    onTap: () {
      if (formKey.currentState!.validate()) {}
    },
    child: Container(
      alignment: Alignment.center,
      width: screenWidth * 0.383,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: secondoryColor,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: fontFamily,
        ),
      ),
    ),
  );
}
