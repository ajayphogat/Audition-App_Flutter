import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/homePage/homePage.dart';
import 'package:first_app/login/common.dart';
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

  bool isObscure = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              AspectRatio(
                  aspectRatio: 2.5,
                  child:
                      SvgPicture.asset("asset/images/illustration/login.svg")),
              const SizedBox(height: 40),
              const Text(
                "LOGIN",
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(height: 50),
              commonTextField(context, _email, "Email/Phone No.",
                  MyFlutterApp.username, false),
              const SizedBox(height: 35),
              SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                child: Stack(
                  children: [
                    Material(
                      elevation: 8,
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
              Container(
                alignment: Alignment.topRight,
                width: MediaQuery.of(context).size.width - 120,
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  child: const Text("Forgot Password?"),
                ),
              ),
              const SizedBox(height: 20),
              basicButton(context, _formKey, HomePage.routeName, "Login"),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text("Sign up",
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
