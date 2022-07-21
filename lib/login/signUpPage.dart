import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/login/verifyMobile.dart';

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

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _fullName.dispose();
    _phone.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.only(top: 100),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 2.5,
                  child: SvgPicture.asset(
                    "asset/images/illustration/signup.svg",
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  "SIGN UP",
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
                const SizedBox(height: 50),
                commonTextField(context, _fullName, "Full Name",
                    MyFlutterApp.username, false),
                const SizedBox(height: 35),
                commonTextField(
                    context, _phone, "Phone No.", MyFlutterApp.call, false),
                const SizedBox(height: 35),
                commonTextField(
                    context, _email, "Email", MyFlutterApp.message, false),
                const SizedBox(height: 35),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 120,
                  child: Stack(
                    children: [
                      Material(
                        elevation: 5,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: MediaQuery.of(context).size.width - 120,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xFFFDF5F2),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _password,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please fill this";
                          } else if (value.length < 6) {
                            return "Length of Password must be greater than 6";
                          } else {
                            return null;
                          }
                        },
                        obscureText: isObscure,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(
                            height: 0.1,
                          ),
                          hintText: "Password",
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF979797),
                          ),
                          border: InputBorder.none,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 20, right: 5),
                            child: Icon(MyFlutterApp.lock,
                                color: Colors.black, size: 30),
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
                                  color: Colors.grey,
                                )
                              : IconButton(
                                  icon: const Icon(MyFlutterApp.hide),
                                  onPressed: () {
                                    setState(() {
                                      isObscure = !isObscure;
                                    });
                                  },
                                  iconSize: 25,
                                  color: Colors.grey,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 45),
                basicButton(
                    context, _formKey, VerifyMobile.routeName, "Sign Up"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
