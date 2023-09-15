import 'package:auto_size_text/auto_size_text.dart';
import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/login/forgotPassword.dart';
import 'package:first_app/login/signUpPage.dart';
import 'package:first_app/studio_code/sbottomNavigation/sbottomNavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  static const String routeName = "/login-page";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  String account = "Audition";

  bool isObscure = true;
  bool _rememberMe = true;

  bool _showEmailError = false;
  bool _showPasswordError = false;

  final _formKey = GlobalKey<FormState>();

  final AuthService authService = AuthService();
  bool isLoading = false;

  Future<void> loginUser() async {
    await authService.loginUser(
        context: context, email: _email.text, password: _password.text);
  }

  Future<void> loginStudio() async {
    await authService.loginStudio(
        context: context, email: _email.text, password: _password.text);
  }

  void changeRememberMe(bool value) {
    setState(() {
      _rememberMe = value;
    });
  }

  @override
  void initState() {
    super.initState();
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
              height: screenHeight - MediaQuery.of(context).padding.top,
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
                              "Login",
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
                  // SizedBox(height: screenHeight * 0.15),
                  // AspectRatio(
                  //     aspectRatio: 2.5,
                  //     child: SvgPicture.asset(
                  //         "asset/images/illustration/login.svg")),
                  SizedBox(height: screenHeight * 0.08),
                  // const Text(
                  //   "LOGIN",
                  //   style: TextStyle(
                  //     fontSize: 40,
                  //     fontFamily: fontFamily,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Radio(
                              activeColor: secondoryColor,
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
                              activeColor: secondoryColor,
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
                  loginTextField(
                    screenWidth,
                    screenHeight,
                    context,
                    _email,
                    "Email",
                    MyFlutterApp.username,
                    false,
                  ),
                  _showEmailError
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.025),
                          child: const Row(
                            children: [
                              Text(
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
                  SizedBox(height: screenHeight * 0.02),
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
                          setState(() {
                            _showPasswordError = true;
                          });
                          return "no";
                        } else {
                          setState(() {
                            _showPasswordError = false;
                          });
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
                          height: 0.1,
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
                  _showPasswordError
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.025),
                          child: Row(
                            children: [
                              const Text(
                                "Please Enter Password",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  SizedBox(height: screenHeight * 0.01),
                  Container(
                    // color: Colors.red,
                    width: screenWidth,
                    height: screenHeight * 0.05,
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              changeRememberMe(!_rememberMe);
                            });
                          },
                          child: SizedBox(
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.04,
                            child: Row(
                              children: [
                                SizedBox(
                                  height: screenHeight * 0.025,
                                  child: FittedBox(
                                    child: CupertinoSwitch(
                                      activeColor: const Color(0xff0A4C7E),
                                      value: _rememberMe,
                                      onChanged: (value) =>
                                          changeRememberMe(value),
                                    ),
                                  ),
                                ),
                                const AutoSizeText(
                                  "Remember Me",
                                  maxLines: 1,
                                  maxFontSize: 12,
                                  minFontSize: 8,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff131212),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, ForgotPassword.routeName);
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                          ),
                          child: const AutoSizeText(
                            "Forgot Password?",
                            maxLines: 1,
                            maxFontSize: 12,
                            minFontSize: 8,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              fontFamily: fontFamily,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
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
                          await loginUser();
                          // await Future.delayed(const Duration(seconds: 2));

                          setState(() {
                            isLoading = !isLoading;
                          });
                        } else {
                          setState(() {
                            isLoading = !isLoading;
                          });
                          await loginStudio();
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
                              "Login",
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
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AutoSizeText(
                        "Don't have an account? ",
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
                              context, SignupPage.routeName);
                        },
                        child: const AutoSizeText(
                          "Sign up",
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
                  SizedBox(height: screenHeight * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  InkWell loginButton(BuildContext context, double screenWidth) {
    return InkWell(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          // _password.text == "studio"
          account == "Studio"
              ? Navigator.pushNamedAndRemoveUntil(
                  context, SBottomNavigationPage.routeName, (route) => false)
              : Navigator.pushNamedAndRemoveUntil(
                  context, BottomNavigationPage.routeName, (route) => false);
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: screenWidth * 0.383,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: secondoryColor,
        ),
        child: const Text(
          "Login",
          style: TextStyle(
            fontFamily: fontFamily,
          ),
        ),
      ),
    );
  }

  Widget loginTextField(
    double screenWidth,
    double screenHeight,
    BuildContext context,
    controller,
    String hintText,
    icon,
    bool isPassword,
  ) {
    return Container(
      // height: screenHeight * 0.05,
      width: screenWidth,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xffDADADA),
        ),
      ),
      child: TextFormField(
        controller: controller,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            setState(() {
              _showEmailError = true;
            });
            return "no";
          } else {
            _showEmailError = false;
            return null;
          }
        },
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: fontFamily,
        ),
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontFamily: fontFamily,
            color: placeholderTextColor,
          ),
          errorStyle: const TextStyle(
            fontFamily: fontFamily,
            color: Colors.transparent,
            height: 0.001,
          ),
          border: InputBorder.none,
          prefixIcon: Container(
            width: screenWidth * 0.025,
            height: screenHeight * 0.025,
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              "asset/icons/Message.svg",
              color: const Color(0xff0A4C7E),
            ),
          ),
          // prefixIcon: Padding(
          //   padding: const EdgeInsets.only(left: 20, right: 5, bottom: 0),
          //   child: Icon(icon,
          //       color: Color(0xff0A4C7E),
          //       size: icon == MyFlutterApp.message ? 28 : 35),
          // ),
        ),
      ),
    );
  }
}
