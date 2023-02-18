import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/login/forgotPassword.dart';
import 'package:first_app/login/signUpPage.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:first_app/studio_code/sbottomNavigation/sbottomNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.15),
                AspectRatio(
                    aspectRatio: 2.5,
                    child: SvgPicture.asset(
                        "asset/images/illustration/login.svg")),
                SizedBox(height: screenHeight * 0.047),
                const Text(
                  "LOGIN",
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.15),
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
                loginTextField(screenWidth, screenHeight, context, _email,
                    "Email/Phone No.", MyFlutterApp.username, false),
                SizedBox(height: screenHeight * 0.041),
                SizedBox(
                  width: screenWidth - screenWidth * 0.305,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: screenWidth - screenWidth * 0.305,
                          height: screenHeight * 0.06,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: placeholderColor,
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _password,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please fill this";
                          } else {
                            return null;
                          }
                        },
                        style: const TextStyle(
                          fontSize: 18,
                          fontFamily: fontFamily,
                        ),
                        obscureText: isObscure,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            height: 0.1,
                          ),
                          hintText: "Password",
                          hintStyle: const TextStyle(
                            fontSize: 18,
                            fontFamily: fontFamily,
                            color: placeholderTextColor,
                          ),
                          border: InputBorder.none,
                          prefixIcon: const Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 5, bottom: 3),
                            child: Icon(MyFlutterApp.lock,
                                color: Colors.black, size: 35),
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
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Container(
                  alignment: Alignment.topRight,
                  width: screenWidth - screenWidth * 0.305,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgotPassword.routeName);
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontFamily: fontFamily,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
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
                        isLoading ? screenHeight * 0.047 : screenWidth * 0.383,
                    height: screenHeight * 0.047,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(isLoading ? 50 : 8),
                      color: secondoryColor,
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
                        : const Text(
                            "Login",
                            style: TextStyle(
                              fontFamily: fontFamily,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: fontFamily,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.popAndPushNamed(
                            context, SignupPage.routeName);
                      },
                      child: const Text("Sign up",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: fontFamily,
                            decoration: TextDecoration.underline,
                          )),
                    ),
                  ],
                ),
              ],
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
    return SizedBox(
      width: screenWidth - screenWidth * 0.305,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: screenWidth - screenWidth * 0.305,
              height: screenHeight * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: placeholderColor,
              ),
            ),
          ),
          TextFormField(
            controller: controller,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Please fill this";
              } else {
                return null;
              }
            },
            style: const TextStyle(
              fontSize: 18,
              fontFamily: fontFamily,
            ),
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontSize: 18,
                fontFamily: fontFamily,
                color: placeholderTextColor,
              ),
              errorStyle: const TextStyle(
                fontFamily: fontFamily,
                height: 0.1,
              ),
              border: InputBorder.none,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 20, right: 5, bottom: 0),
                child: Icon(icon,
                    color: Colors.black,
                    size: icon == MyFlutterApp.message ? 28 : 35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
