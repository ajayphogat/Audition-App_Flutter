// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/auth/databaseService.dart';
import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/login/loginPage.dart';
import 'package:first_app/login/mainPage.dart';
import 'package:first_app/login/resetPassword.dart';
import 'package:first_app/login/verifyMobile.dart';
import 'package:first_app/model/studio_user_model.dart';
import 'package:first_app/pages/splashScreen/firstScreen.dart';
import 'package:first_app/provider/studio_provider.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:first_app/studio_code/sbottomNavigation/sbottomNavigationBar.dart';
import 'package:first_app/utils/showSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:first_app/model/audition_user_model.dart';
import 'package:first_app/utils/errorHandel.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/constant.dart';
import '../login/verificationPage.dart';
import '../pages/categorySection/studio_description.dart';

class AuthService {
  //Audition api call

  // signup function
  Future<void> signUpUser({
    required BuildContext context,
    required String fname,
    required String email,
    required String number,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // User firebaseUser;
    try {
      var user = UserModel(
        id: "",
        fname: fname,
        email: email.toLowerCase().trim(),
        number: number,
        password: password,
        category: "",
        token: "",
        bio: "",
        pronoun: "",
        gender: "",
        location: "",
        profileUrl: "",
        profilePic: "",
        visibility: "",
        age: "",
        ethnicity: "",
        height: "",
        weight: "",
        bodyType: "",
        hairColor: "",
        eyeColor: "",
        subscriptionName: "",
        socialMedia: [],
        unionMembership: [],
        skills: [],
        credits: [],
        photos: [],
        videos: [],
        audios: [],
        documents: [],
        applied: [],
        shortlisted: [],
        accepted: [],
        declined: [],
        following: [],
        thumbnailVideo: [],
      );

      http.Response res = await http.post(
          Uri.parse("$url/api/audition/web/signup"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      // if (res.statusCode == 200 && jsonDecode(res.body)["created"]) {
      //   firebaseUser = (await firebaseAuth.createUserWithEmailAndPassword(
      //           email: email.trim(), password: "${email.trim()}password"))
      //       .user!;
      //   if (firebaseUser != null) {
      //     await DatabaseService(uid: jsonDecode(res.body)['_id'])
      //         .updateUserData(fname.trim(), email.trim());
      //   } else {
      //     showSnackBar(context, firebaseAuth.currentUser.toString());
      //   }
      // }

      httpErrorHandelForLoginSignup(
          context: context,
          res: res,
          onSuccess: () async {
            // showMessage() => showSnackBar(
            //       context,
            //       "Account created! Login with same Credentials",
            //     );
            Navigator.pushNamed(context, VerificationPage.routeName,
                arguments: [jsonDecode(res.body), "audition"]);
            // showMessage();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> verificationOTPStudio({
    required BuildContext context,
    required String number,
    required String otp,
    required String fname,
    required String email,
    required String password,
  }) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User firebaseUser;
    try {
      http.Response res =
          await http.post(Uri.parse("$url/api/studio/web/verify-otp"),
              // await http.post(Uri.parse("$url/api/studio/web/verify-otp"),
              body: jsonEncode(
                {
                  "number": number,
                  "otp": otp,
                  "fname": fname,
                  "email": email.toLowerCase().trim(),
                  "password": password,
                },
              ),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      if (res.statusCode != 200) {
        Navigator.pop(context);
      }

      if (res.statusCode == 200 &&
          jsonDecode(res.body)["created"] == 'create') {
        firebaseUser = (await firebaseAuth.createUserWithEmailAndPassword(
                email: email.toLowerCase().trim(),
                password: "${email.toLowerCase().trim()}password"))
            .user!;
        if (firebaseUser != null) {
          await DatabaseService(uid: jsonDecode(res.body)['_id'])
              .updateUserData(fname.trim(), email.toLowerCase().trim());
        } else {
          showSnackBar(context, firebaseAuth.currentUser.toString());
        }
      } else if (res.statusCode == 200 &&
          jsonDecode(res.body)["created"] != 'create') {
        firebaseUser = (await firebaseAuth.signInWithEmailAndPassword(
                email: email.toLowerCase().trim(),
                password: "${email.toLowerCase().trim()}password"))
            .user!;
        if (firebaseUser != null) {
          await DatabaseService(uid: jsonDecode(res.body)['_id'])
              .updateUserData(fname.trim(), email.toLowerCase().trim());
        } else {
          showSnackBar(context, firebaseAuth.currentUser.toString());
        }
      }
      httpErrorHandelForLoginSignup(
          context: context,
          res: res,
          onSuccess: () {
            Navigator.pushNamed(
              context,
              LoginPage.routeName,
              // arguments:
            );
            showSnackBar(
                context, "Account created! Login with same Credentials");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> verificationOTP({
    required BuildContext context,
    required String number,
    required String otp,
    required String fname,
    required String email,
    required String password,
  }) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User firebaseUser;
    try {
      http.Response res =
          await http.post(Uri.parse("$url/api/audition/web/verify-otp"),
              body: jsonEncode(
                {
                  "number": number,
                  "otp": otp,
                  "fname": fname,
                  "email": email.toLowerCase().trim(),
                  "password": password,
                },
              ),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      if (res.statusCode == 200 &&
          jsonDecode(res.body)["created"] == 'create') {
        firebaseUser = (await firebaseAuth.createUserWithEmailAndPassword(
                email: email.toLowerCase().trim(),
                password: "${email.toLowerCase().trim()}password"))
            .user!;
        if (firebaseUser != null) {
          await DatabaseService(uid: jsonDecode(res.body)['_id'])
              .updateUserData(fname.trim(), email.toLowerCase().trim());
        } else {
          showSnackBar(context, firebaseAuth.currentUser.toString());
        }
      } else if (res.statusCode == 200 &&
          jsonDecode(res.body)["created"] != 'create') {
        firebaseUser = (await firebaseAuth.signInWithEmailAndPassword(
                email: email.toLowerCase().trim(),
                password: "${email.toLowerCase().trim()}password"))
            .user!;

        if (firebaseUser != null) {
          await DatabaseService(uid: jsonDecode(res.body)['_id'])
              .updateUserData(fname.trim(), email.toLowerCase().trim());
        } else {
          showSnackBar(context, firebaseAuth.currentUser.toString());
        }
      }

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            Navigator.pushNamed(
              context,
              LoginPage.routeName,
              // arguments:
            );
            showSnackBar(
                context, "Account created! Login with same Credentials");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> verificationOTPForgot({
    required BuildContext context,
    required String number,
    required String otp,
  }) async {
    try {
      http.Response res =
          await http.post(Uri.parse("$url/api/audition/verify-otp"),
              body: jsonEncode(
                {
                  "number": number,
                  "otp": otp,
                },
              ),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            Navigator.pushNamed(context, ResetPassword.routeName,
                arguments: number);
            // showSnackBar(
            //     context, "Account created! Login with same Credentials");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> verificationOTPForgotStudio({
    required BuildContext context,
    required String number,
    required String otp,
  }) async {
    try {
      http.Response res =
          await http.post(Uri.parse("$url/api/studio/verify-otp"),
              body: jsonEncode(
                {
                  "number": number,
                  "otp": otp,
                },
              ),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            Navigator.pushNamed(context, ResetPassword.routeName,
                arguments: number);
            // showSnackBar(
            //     context, "Account created! Login with same Credentials");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // login function
  Future<void> loginUser({
    required BuildContext context,
    required String email,
    required String password,
    bool? saveToken,
  }) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      var user = UserModel(
        id: "",
        fname: "",
        email: email.toLowerCase().trim(),
        number: "",
        password: password,
        category: "",
        token: "",
        bio: "",
        pronoun: "",
        gender: "",
        location: "",
        profileUrl: "",
        profilePic: "",
        visibility: "",
        age: "",
        ethnicity: "",
        height: "",
        weight: "",
        bodyType: "",
        hairColor: "",
        eyeColor: "",
        subscriptionName: "",
        socialMedia: [],
        unionMembership: [],
        skills: [],
        credits: [],
        photos: [],
        videos: [],
        audios: [],
        documents: [],
        applied: [],
        shortlisted: [],
        accepted: [],
        declined: [],
        following: [],
        thumbnailVideo: [],
      );

      http.Response res = await http.post(Uri.parse("$url/api/audition/login"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

          print(res.statusCode);
      if (res.statusCode == 200) {
        // Signin user with Email and Password
        await firebaseAuth.signInWithEmailAndPassword(
            email: email.toLowerCase().trim(),
            password: "${email.toLowerCase().trim()}password");

        // Update FCM Token in user Database
        await DatabaseService(uid: jsonDecode(res.body)['_id'])
            .gettingUserData(email.toLowerCase().trim());
      }

      httpErrorHandelForLoginSignup(
          context: context,
          res: res,
          onSuccess: () async {
            var userProvider =
                Provider.of<UserProvider>(context, listen: false);
            navigator(String routeName) => Navigator.pushNamedAndRemoveUntil(
                context, routeName, (route) => false);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            userProvider.setUser(res.body);
            if (saveToken == true) {
              await prefs.setBool('tokenSaved', true);
            } else {
              await prefs.setBool('tokenSaved', false);
            }
            await prefs.setString(
                "x-auth-token", jsonDecode(res.body)['token']);
            await prefs.remove("x-studio-token");
            navigator(BottomNavigationPage.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> forgotPassword({
    required BuildContext context,
    required String number,
  }) async {
    try {
      http.Response res = await http
          .post(Uri.parse("$url/api/send/otp/forget/password/audition"),
              body: jsonEncode(
                {
                  "number": number,
                },
              ),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      httpErrorHandelForLoginSignup(
        context: context,
        res: res,
        onSuccess: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, VerifyMobile.routeName, arguments: [
            jsonDecode(res.body)["number"].toString(),
            "audition"
          ]);
        },
      );
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
  }

  Future<void> forgotPasswordStudio({
    required BuildContext context,
    required String number,
  }) async {
    try {
      http.Response res =
          await http.post(Uri.parse("$url/api/send/otp/forget/password"),
              body: jsonEncode(
                {
                  "number": number,
                },
              ),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          Navigator.pop(context);
          Navigator.pushNamed(context, VerifyMobile.routeName,
              arguments: [jsonDecode(res.body)["number"].toString(), "studio"]);
        },
      );
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
  }

  Future<void> resetPassword({
    required BuildContext context,
    required String password,
    required String number,
    required String type,
  }) async {
    try {
      String apiUrl = "";
      if (type == "Audition") {
        apiUrl = "$url/reset/password/audition";
      } else {
        apiUrl = "$url/reset/password/studio";
      }
      http.Response res = await http.post(Uri.parse(apiUrl),
          body: jsonEncode(
            {
              "password": password,
              "number": number,
            },
          ),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
              context, LoginPage.routeName, (route) => false);
          showSnackBar(context, "Password Changed!!");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // logout api call
  Future<void> logoutUser(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = Provider.of<UserProvider>(context, listen: false).user;
      // var studioUser = Provider.of<StudioProvider>(context, listen: false).user;
      // if (user.id.isNotEmpty && studioUser.id.isEmpty) {
      //   userid = user.id;
      // } else if (user.id.isEmpty && studioUser.id.isNotEmpty) {
      //   userid = studioUser.id;
      // } else {
      //   Navigator.pop(context);
      //   showSnackBar(context, "Please restart this app and try again!");
      // }

      var token = prefs.getString("x-auth-token");
      if (token == null || token.isEmpty) {
        await prefs.remove("x-auth-token");
      }

      http.Response res = await http.post(Uri.parse("$url/api/audition/logout"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () async {
            navigatorPop() => Navigator.pop(context);

            navigatorPush() => Navigator.pushNamedAndRemoveUntil(
                context, LoginPage.routeName, (route) => false);

            await DatabaseService(uid: user.id).logoutFCMToken();
            await FirebaseAuth.instance.signOut();
            prefs.setString("x-auth-token", "");
            prefs.setString("x-studio-token", "");
            showSnackBar(context, "Logged out");
            navigatorPop();
            navigatorPush();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // logout studio api call
  Future<void> logoutStudioUser(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var studioProvider =
          Provider.of<StudioProvider>(context, listen: false).user;

      var token = prefs.getString("x-studio-token");
      if (token == null || token.isEmpty) {
        await prefs.remove("x-studio-token");
      }

      http.Response res = await http
          .post(Uri.parse("$url/api/studio/logout"), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "x-studio-token": token!,
      });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () async {
            navigatorPop() => Navigator.pop(context);
            navigatorPush() => Navigator.pushNamedAndRemoveUntil(
                context, LoginPage.routeName, (route) => false);
            await DatabaseService(uid: studioProvider.id).logoutFCMToken();
            await FirebaseAuth.instance.signOut();
            prefs.setString("x-auth-token", "");
            prefs.setString("x-studio-token", "");
            showSnackBar(context, "Logged out");
            navigatorPop();
            navigatorPush();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Delete audition account api call
  Future<void> deleteUser(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = Provider.of<UserProvider>(context, listen: false).user;

      var token = prefs.getString("x-auth-token");
      if (token == null || token.isEmpty) {
        await prefs.remove("x-auth-token");
      }
      print("user id");
      print(user.id);
      http.Response res = await http.delete(
          Uri.parse("$url/api/audition/delete-account/${user.id}"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      navigatorPop() => Navigator.pop(context);
      navigatorPush() => Navigator.pushNamedAndRemoveUntil(
          context, LoginPage.routeName, (route) => false);

      if (res.statusCode == 200) {
        var studioExist = jsonDecode(res.body)['studioExist'];
        await DatabaseService(uid: user.id).deleteFirebaseData();
        print("Studio Exist: $studioExist");
        if (!studioExist) {
          print("yes");
          await _deleteUserAccount(context);
        }
        prefs.setString("x-auth-token", "");
        prefs.setString("x-studio-token", "");
        showSnackBar(context, "Account Deleted Successfully");
        navigatorPop();
        navigatorPop();
        navigatorPush();
      } else if (res.statusCode == 400 || res.statusCode == 401) {
        navigatorPop();
        navigatorPop();
        showSnackBar(context, jsonDecode(res.body)['msg']);
      } else {
        navigatorPop();
        navigatorPop();
        showSnackBar(context, jsonDecode(res.body)['error']);
      }
    } catch (e) {
      Navigator.pop(context);
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
  }

  // Delete studio account api call
  Future<void> deleteUserStudio(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var studioProvider =
          Provider.of<StudioProvider>(context, listen: false).user;

      var token = prefs.getString("x-studio-token");
      if (token == null || token.isEmpty) {
        await prefs.remove("x-studio-token");
      }
      http.Response res = await http.delete(
          Uri.parse("$url/api/studio/delete-account/${studioProvider.id}"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-studio-token": token!,
          });

      navigatorPop() => Navigator.pop(context);
      navigatorPush() => Navigator.pushNamedAndRemoveUntil(
          context, LoginPage.routeName, (route) => false);

      if (res.statusCode == 200) {
        var auditionExist = jsonDecode(res.body)['auditionExist'];
        await DatabaseService(uid: studioProvider.id).deleteFirebaseData();
        if (!auditionExist) {
          await _deleteUserAccount(context);
        }
        prefs.setString("x-auth-token", "");
        prefs.setString("x-studio-token", "");
        showSnackBar(context, "Account Deleted Successfully");
        navigatorPop();
        navigatorPop();
        navigatorPush();
      } else if (res.statusCode == 400 || res.statusCode == 401) {
        navigatorPop();
        navigatorPop();
        showSnackBar(context, jsonDecode(res.body)['msg']);
      } else {
        navigatorPop();
        navigatorPop();
        showSnackBar(context, jsonDecode(res.body)['error']);
      }
    } catch (e) {
      Navigator.pop(context);
      Navigator.pop(context);
      showSnackBar(context, e.toString());
    }
  }

  Future<void> _deleteUserAccount(context) async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.toString());

      if (e.code == "requires-recent-login") {
        await _reauthenticateAndDelete();
      } else {
        // Handle other Firebase exceptions
      }
    } catch (e) {
      showSnackBar(context, e.toString());

      // Handle general exception
    }
  }

  Future<void> _reauthenticateAndDelete() async {
    try {
      var firebaseAuth = FirebaseAuth.instance;
      final providerData = firebaseAuth.currentUser?.providerData.first;

      if (AppleAuthProvider().providerId == providerData!.providerId) {
        await firebaseAuth.currentUser!
            .reauthenticateWithProvider(AppleAuthProvider());
      } else if (GoogleAuthProvider().providerId == providerData.providerId) {
        await firebaseAuth.currentUser!
            .reauthenticateWithProvider(GoogleAuthProvider());
      }

      await firebaseAuth.currentUser?.delete();
    } catch (e) {
      // Handle exceptions
    }
  }

  // get data and token validation
  Future<dynamic> getUserData(BuildContext context) async {
    try {
      navigatePush() => Navigator.pushNamed(context, MainPage.routeName);

      var userProvider = Provider.of<UserProvider>(context, listen: false);
      var studioProvider = Provider.of<StudioProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? tokenAudition = prefs.getString("x-auth-token");
      String? tokenStudio = prefs.getString("x-studio-token");

      if (prefs.getBool('tokenSaved') == false) {
        return FirstSplashScreen.routeName;
      }

      if ((tokenAudition == null || tokenAudition.isEmpty) &&
          (tokenStudio == null || tokenStudio.isEmpty)) {
        // await prefs.setString("x-auth-token", "");
        // token = prefs.getString("x-auth-token");
        return FirstSplashScreen.routeName;
      } else if ((tokenAudition != null && tokenAudition.isNotEmpty) &&
          (tokenStudio == null || tokenStudio.isEmpty)) {
        http.Response tokenResp = await http
            .post(Uri.parse("$url/api/tokenValid"), headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
          "x-auth-token": tokenAudition,
        });

        if (jsonDecode(tokenResp.body) == true) {
          http.Response userResp = await http.get(
              Uri.parse("$url/api/audition/getUserData"),
              headers: <String, String>{
                "Content-Type": "application/json; charset=UTF-8",
                "x-auth-token": tokenAudition,
              });

          await prefs.setString(
              "x-auth-token", jsonDecode(userResp.body)['token']);
          await prefs.remove("x-studio-token");
          userProvider.setUser(userResp.body);
          return userProvider.user.token;
        } else {
          navigatePush();
        }
      } else if ((tokenAudition == null || tokenAudition.isEmpty) &&
          (tokenStudio != null && tokenStudio.isNotEmpty)) {
        http.Response tokenResp = await http.post(
            Uri.parse("$url/api/studio/tokenValid"),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "x-studio-token": tokenStudio,
            });

        if (jsonDecode(tokenResp.body) == true) {
          http.Response userResp = await http.get(
              Uri.parse("$url/api/studio/getUserData"),
              headers: <String, String>{
                "Content-Type": "application/json; charset=UTF-8",
                "x-studio-token": tokenStudio,
              });
          await prefs.setString(
              "x-studio-token", jsonDecode(userResp.body)['token']);
          await prefs.remove("x-auth-token");
          studioProvider.setUser(userResp.body);
          return studioProvider.user.token;
        } else {
          navigatePush();
        }
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getStudioData(
    BuildContext context,
    String studioId,
  ) async {
    try {
      navigatePush() =>
          Navigator.pushNamed(context, StudioDescriptionPage.routeName);

      var studioProvider = Provider.of<StudioProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? tokenAudition = prefs.getString("x-auth-token");

      if (tokenAudition != null && tokenAudition.isNotEmpty) {
        http.Response userResp = await http.get(
            Uri.parse("$url/api/audition/getStudioData?studioId=$studioId"),
            headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "x-auth-token": tokenAudition,
            });

        studioProvider.setUser(userResp.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());

      Navigator.pushNamedAndRemoveUntil(
          context, FirstSplashScreen.routeName, (route) => false);
    }
  }

  // change bio
  Future<void> changeBio({
    required String bio,
    required BuildContext context,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res =
          await http.post(Uri.parse("$url/api/audition/changeBio"),
              body: jsonEncode({
                'bio': bio,
              }),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            userProvider.setUser(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // upload Profile Pic
  Future<void> updateProfilePic({
    required BuildContext context,
    required String profilePicUrl,
    required String user,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      var studioProvider = Provider.of<StudioProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("x-auth-token");
      String? studioToken = prefs.getString("x-studio-token");

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      if (studioToken == null) {
        await prefs.setString("x-studio-token", "");
        studioToken = prefs.getString("x-studio-token");
      }

      if (user == "audition") {
        http.Response res =
            await http.post(Uri.parse("$url/api/upload/profilePic"),
                body: jsonEncode({
                  "profilePicUrl": profilePicUrl,
                }),
                headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "x-auth-token": token!,
            });

        httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () async {
            await DatabaseService(uid: jsonDecode(res.body)['_id'])
                .updateUserProfilePic(jsonDecode(res.body)['profilePic']);
            userProvider.setUser(res.body);
          },
        );
      } else {
        http.Response res =
            await http.post(Uri.parse("$url/api/upload/studio/profilePic"),
                body: jsonEncode({
                  "profilePicUrl": profilePicUrl,
                }),
                headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "x-studio-token": studioToken!,
            });

        httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () async {
            await DatabaseService(uid: jsonDecode(res.body)['_id'])
                .updateUserProfilePic(jsonDecode(res.body)['profilePic']);
            studioProvider.setUser(res.body);
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // upload Media Files
  Future<void> uploadMedia({
    required BuildContext context,
    required String media,
    required String mediaType,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.post(Uri.parse("$url/api/upload/media"),
          body: jsonEncode({
            "media": media,
            "mediaType": mediaType,
          }),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          userProvider.setUser(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // delete Media Files
  Future<void> deleteMedia({
    required BuildContext context,
    required String media,
    required String mediaType,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.post(Uri.parse("$url/api/delete/media"),
          body: jsonEncode({
            "media": media,
            "mediaType": mediaType,
          }),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          userProvider.setUser(res.body);
          showSnackBar(context, "Deleted Successfully");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // update Basic Info
  Future<void> updateBasicInfo({
    required BuildContext context,
    required String fname,
    required String pronoun,
    required String gender,
    required String location,
    required String profileUrl,
    required String category,
    required String visibility,
  }) async {
    try {
      var user = UserModel(
        id: "",
        fname: fname,
        email: "",
        number: "",
        password: "",
        category: category,
        token: "",
        bio: "",
        pronoun: pronoun,
        gender: gender,
        location: location,
        profileUrl: profileUrl,
        profilePic: "",
        visibility: visibility,
        age: "",
        ethnicity: "",
        height: "",
        weight: "",
        bodyType: "",
        hairColor: "",
        eyeColor: "",
        subscriptionName: "",
        socialMedia: [],
        unionMembership: [],
        skills: [],
        credits: [],
        photos: [],
        videos: [],
        audios: [],
        documents: [],
        applied: [],
        shortlisted: [],
        accepted: [],
        declined: [],
        following: [],
        thumbnailVideo: [],
      );
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.post(
          Uri.parse("$url/api/audition/updateBasicInfo"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            userProvider.setUser(res.body);
            showSnackBar(context, "Saved Successfully!");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // update Appearance
  Future<void> updateAppearance({
    required BuildContext context,
    required String age,
    required String ethnicity,
    required String height,
    required String weight,
    required String bodyType,
    required String hairColor,
    required String eyeColor,
  }) async {
    try {
      var user = UserModel(
        id: "",
        fname: "",
        email: "",
        number: "",
        password: "",
        category: "",
        token: "",
        bio: "",
        pronoun: "",
        gender: "",
        location: "",
        profileUrl: "",
        profilePic: "",
        visibility: "",
        age: age,
        ethnicity: ethnicity,
        height: height,
        weight: weight,
        bodyType: bodyType,
        hairColor: hairColor,
        eyeColor: eyeColor,
        socialMedia: [],
        unionMembership: [],
        skills: [],
        credits: [],
        photos: [],
        videos: [],
        audios: [],
        documents: [],
        applied: [],
        shortlisted: [],
        accepted: [],
        declined: [],
        following: [],
        thumbnailVideo: [],
        subscriptionName: "",
      );
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.post(
          Uri.parse("$url/api/audition/updateAppearance"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            userProvider.setUser(res.body);
            showSnackBar(context, "Saved Successfully!");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // update Social Media
  Future<void> updateSocialMedia({
    required BuildContext context,
    required List<String> socialMedia,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.post(
          Uri.parse("$url/api/audition/updateSocialMedia"),
          body: jsonEncode(socialMedia),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            userProvider.setUser(res.body);
            showSnackBar(context, "Saved Successfully!");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // update Union Membership
  Future<void> updateUnionMembership({
    required BuildContext context,
    required List<String> unionMembership,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.post(
          Uri.parse("$url/api/audition/updateUnionMembership"),
          body: jsonEncode(unionMembership),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            userProvider.setUser(res.body);
            showSnackBar(context, "Saved Successfully!");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // update Skills
  Future<void> updateSkills({
    required BuildContext context,
    required List<String> skills,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.post(
          Uri.parse("$url/api/audition/updateSkills"),
          body: jsonEncode(skills),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            userProvider.setUser(res.body);
            showSnackBar(context, "Saved Successfully!");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // update Credits
  Future<void> updateCredits({
    required BuildContext context,
    required List<String> credits,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.post(
          Uri.parse("$url/api/audition/updateCredits"),
          body: jsonEncode(credits),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            userProvider.setUser(res.body);
            showSnackBar(context, "Saved Successfully!");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Audition Subscription plan api call
  Future<void> buySubscription(
      {required BuildContext context,
      required String subscriptionName,
      required String subscriptionPrice}) async {
    try {
      var user = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("x-auth-token");
      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }
      http.Response res =
          await http.post(Uri.parse("$url/api/audition/subscriptionData"),
              body: jsonEncode({
                "subscriptionName": subscriptionName,
                "subscriptionPrice": subscriptionPrice,
              }),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            user.setUser(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Studio Subscription plan api call
  Future<void> updateSubscriptionStudio(
      {required BuildContext context,
      required String subscriptionName,
      required String subscriptionPrice}) async {
    try {
      var user = Provider.of<StudioProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("x-studio-token");
      if (token == null) {
        await prefs.setString("x-studio-token", "");
        token = prefs.getString("x-studio-token");
      }
      http.Response res =
          await http.post(Uri.parse("$url/api/studio/subscriptionData"),
              body: jsonEncode({
                "subscriptionName": subscriptionName,
                "subscriptionPrice": subscriptionPrice,
              }),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-studio-token": token!,
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            user.setUser(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Switch to Audition api call
  Future<void> switchToAudition({
    required BuildContext context,
  }) async {
    Map<String, dynamic> uu = {
      'id': "",
      'fname': "",
      'email': "",
      'number': "",
      'password': "",
      'token': "",
      'location': "",
      'profilePic': "",
      'views': 0,
      'projectDesc': "",
      'aboutDesc': "",
      'followers': [],
      'post': [],
      'totalApplicants': "",
      'totalShortlisted': "",
      'totalAccepted': "",
      'totalDeclined': "",
      'totalBookmark': "",
    };
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      var studioProvider =
          Provider.of<StudioProvider>(context, listen: false).user;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("x-studio-token");

      if (token == null) {
        await prefs.setString("x-studio-token", "");
        token = prefs.getString("x-studio-token");
      }

      http.Response res = await http.get(Uri.parse("$url/api/switchToAudition"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-studio-token": token!,
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () async {
            navigatePush() => Navigator.pushNamedAndRemoveUntil(
                context, BottomNavigationPage.routeName, (route) => false);
            navigatePop() => Navigator.pop(context);

            userProvider.setUser(res.body);
            await DatabaseService(uid: studioProvider.id).logoutFCMToken();
            await DatabaseService(uid: jsonDecode(res.body)['_id'])
                .updateFCMToken();

            await prefs.setString("x-studio-token", "");
            await prefs.setString(
                "x-auth-token", jsonDecode(res.body)['token']);
            if (userProvider.user.token != null ||
                userProvider.user.token != "") {
              navigatePop();
              navigatePush();
            } else {
              navigatePop();
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Switch to Studio api call
  Future<void> switchToStudio({
    required BuildContext context,
  }) async {
    try {
      var studioProvider = Provider.of<StudioProvider>(context, listen: false);
      var user = Provider.of<UserProvider>(context, listen: false).user;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("x-auth-token");

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http
          .get(Uri.parse("$url/api/switchToStudio"), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": token!,
      });
      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () async {
            navigatePush() => Navigator.pushNamedAndRemoveUntil(
                context, SBottomNavigationPage.routeName, (route) => false);
            navigatePop() => Navigator.pop(context);
            studioProvider.setUser(res.body);
            await DatabaseService(uid: user.id).logoutFCMToken();
            await DatabaseService(uid: jsonDecode(res.body)['_id'])
                .updateFCMToken();
            await prefs.setString("x-auth-token", "");
            await prefs.setString(
                "x-studio-token", jsonDecode(res.body)['token']);
            if (studioProvider.user.token != null ||
                studioProvider.user.token != "") {
              navigatePop();
              navigatePush();
            } else {
              navigatePop();
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // Studio api call

  // signup
  Future<void> signUpStudio({
    required BuildContext context,
    required String fname,
    required String email,
    required String number,
    required String password,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    // User firebaseUser;
    try {
      var user = StudioModel(
        id: "",
        fname: fname,
        email: email.toLowerCase().trim(),
        number: number,
        password: password,
        token: "",
        location: "",
        profilePic: "",
        views: 0,
        projectDesc: "",
        aboutDesc: "",
        followers: [],
        post: [],
      );

      http.Response res = await http.post(
          Uri.parse("$url/api/studio/web/signup"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      // if (res.statusCode == 200 && jsonDecode(res.body)["created"]) {
      //   firebaseUser = (await firebaseAuth.createUserWithEmailAndPassword(
      //           email: email.trim(), password: "${email.trim()}password"))
      //       .user!;
      //   if (firebaseUser != null) {
      //     await DatabaseService(uid: jsonDecode(res.body)['_id'])
      //         .updateUserData(fname.trim(), email.trim());
      //   } else {
      //     showSnackBar(context, firebaseAuth.currentUser.toString());
      //   }
      // }
      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            // showSnackBar(
            //   context,
            //   "Account created! Login with same Credentials",
            // );
            Navigator.pushNamed(context, VerificationPage.routeName,
                arguments: [jsonDecode(res.body), "studio"]);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // login
  Future<void> loginStudio({
    required BuildContext context,
    required String email,
    required String password,
    bool? saveToken,
  }) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    try {
      var user = StudioModel(
        id: "",
        fname: "",
        email: email.toLowerCase().trim(),
        number: "",
        password: password,
        token: "",
        location: "",
        profilePic: "",
        views: 0,
        projectDesc: "",
        aboutDesc: "",
        followers: [],
        post: [],
      );

      http.Response res = await http.post(Uri.parse("$url/api/studio/login"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      print(res.statusCode);

      if (res.statusCode == 200) {
        // Signin user with Email and Password
        await firebaseAuth.signInWithEmailAndPassword(
            email: email.toLowerCase().trim(),
            password: "${email.toLowerCase().trim()}password");

        // Update FCM Token in user database
        await DatabaseService(uid: jsonDecode(res.body)['_id'])
            .gettingUserData(email.toLowerCase().trim());
      }

      httpErrorHandelForLoginSignup(
          context: context,
          res: res,
          onSuccess: () async {
            var userProvider =
                Provider.of<StudioProvider>(context, listen: false);
            navigator(String routeName) => Navigator.pushNamedAndRemoveUntil(
                context, routeName, (route) => false);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            userProvider.setUser(res.body);
            if (saveToken == true) {
              await prefs.setBool('tokenSaved', true);
            } else {
              await prefs.setBool('tokenSaved', false);
            }
            await prefs.setString(
                "x-studio-token", jsonDecode(res.body)['token']);
            await prefs.remove("x-auth-token");
            navigator(SBottomNavigationPage.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> updateNameLoc({
    required BuildContext context,
    required String fname,
    required String location,
  }) async {
    try {
      var user = StudioModel(
        id: "",
        fname: fname,
        email: "",
        number: "",
        password: "",
        token: "",
        location: location,
        profilePic: "",
        views: 0,
        projectDesc: "",
        aboutDesc: "",
        followers: [],
        post: [],
      );
      var userProvider = Provider.of<StudioProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("x-studio-token");

      if (token == null) {
        await prefs.setString("x-studio-token", "");
        token = prefs.getString("x-studio-token");
      }

      http.Response res = await http.post(
          Uri.parse("$url/api/studio/updateNameLoc"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-studio-token": token!,
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            userProvider.setUser(res.body);
            showSnackBar(context, "Saved Successfully!");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> updateProjectDesc({
    required BuildContext context,
    required String projectDesc,
  }) async {
    try {
      var user = StudioModel(
        id: "",
        fname: "",
        email: "",
        number: "",
        password: "",
        token: "",
        location: "",
        profilePic: "",
        views: 0,
        projectDesc: projectDesc,
        aboutDesc: "",
        followers: [],
        post: [],
      );
      var userProvider = Provider.of<StudioProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("x-studio-token");

      if (token == null) {
        await prefs.setString("x-studio-token", "");
        token = prefs.getString("x-studio-token");
      }

      http.Response res = await http.post(
          Uri.parse("$url/api/studio/updateProjectDesc"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-studio-token": token!,
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            userProvider.setUser(res.body);
            showSnackBar(context, "Saved Successfully!");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> updateAboutDesc({
    required BuildContext context,
    required String aboutDesc,
  }) async {
    try {
      var user = StudioModel(
        id: "",
        fname: "",
        email: "",
        number: "",
        password: "",
        token: "",
        location: "",
        profilePic: "",
        views: 0,
        projectDesc: "",
        aboutDesc: aboutDesc,
        followers: [],
        post: [],
      );
      var userProvider = Provider.of<StudioProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();

      String? token = prefs.getString("x-studio-token");

      if (token == null) {
        await prefs.setString("x-studio-token", "");
        token = prefs.getString("x-studio-token");
      }

      http.Response res = await http.post(
          Uri.parse("$url/api/studio/updateAboutDesc"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-studio-token": token!,
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            userProvider.setUser(res.body);
            showSnackBar(context, "Saved Successfully!");
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
