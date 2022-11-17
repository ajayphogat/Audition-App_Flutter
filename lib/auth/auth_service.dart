import 'dart:convert';
import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/login/mainPage.dart';
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
    try {
      var user = UserModel(
        id: "",
        fname: fname,
        email: email,
        number: number,
        password: password,
        category: "",
        token: "",
        bio: "",
        pronoun: "",
        gender: "",
        location: "",
        profileUrl: "",
        visibility: "",
        age: "",
        ethnicity: "",
        height: "",
        weight: "",
        bodyType: "",
        hairColor: "",
        eyeColor: "",
        socialMedia: [],
        unionMembership: [],
        skills: [],
        credits: [],
      );

      http.Response res = await http.post(Uri.parse("$url/api/audition/signup"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            showSnackBar(
              context,
              "Account created! Login with same Credentials",
            );
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
  }) async {
    try {
      var user = UserModel(
        id: "",
        fname: "",
        email: email,
        number: "",
        password: password,
        category: "",
        token: "",
        bio: "",
        pronoun: "",
        gender: "",
        location: "",
        profileUrl: "",
        visibility: "",
        age: "",
        ethnicity: "",
        height: "",
        weight: "",
        bodyType: "",
        hairColor: "",
        eyeColor: "",
        socialMedia: [],
        unionMembership: [],
        skills: [],
        credits: [],
      );

      http.Response res = await http.post(Uri.parse("$url/api/audition/login"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () async {
            var userProvider =
                Provider.of<UserProvider>(context, listen: false);
            navigator(String routeName) =>
                Navigator.pushNamed(context, routeName);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            userProvider.setUser(res.body);
            await prefs.setString(
                "x-auth-token", jsonDecode(res.body)['token']);
            await prefs.remove("x-studio-token");
            navigator(BottomNavigationPage.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
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

          return userProvider.setUser(userResp.body);

          // print(jsonDecode(userResp.body));
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
          return studioProvider.setUser(userResp.body);
          // print(jsonDecode(userResp.body));
        } else {
          navigatePush();
        }
      }
    } catch (e) {
      showSnackBar(context, e.toString());
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
          visibility: visibility,
          age: "",
          ethnicity: "",
          height: "",
          weight: "",
          bodyType: "",
          hairColor: "",
          eyeColor: "",
          socialMedia: [],
          unionMembership: [],
          skills: [],
          credits: []);
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
          credits: []);
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

  // Switch to Audition api call
  Future<void> switchToAudition({
    required BuildContext context,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
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
            await prefs.setString("x-studio-token", "");
            await prefs.setString(
                "x-auth-token", jsonDecode(res.body)['token']);
            if (userProvider.user.token.isEmpty) {
              navigatePop();
            } else {
              navigatePop();
              navigatePush();
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
            await prefs.setString("x-auth-token", "");
            await prefs.setString(
                "x-studio-token", jsonDecode(res.body)['token']);
            if (studioProvider.user.token.isEmpty) {
              navigatePop();
            } else {
              navigatePop();
              navigatePush();
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
    try {
      var user = StudioModel(
        id: "",
        fname: fname,
        email: email,
        number: number,
        password: password,
        token: "",
      );

      http.Response res = await http.post(Uri.parse("$url/api/studio/signup"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            showSnackBar(
              context,
              "Account created! Login with same Credentials",
            );
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
  }) async {
    try {
      var user = StudioModel(
        id: "",
        fname: "",
        email: email,
        number: "",
        password: password,
        token: "",
      );

      http.Response res = await http.post(Uri.parse("$url/api/studio/login"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      httpErrorHandelForLoginSignup(
          context: context,
          res: res,
          onSuccess: () async {
            var userProvider =
                Provider.of<StudioProvider>(context, listen: false);
            navigator(String routeName) =>
                Navigator.pushNamed(context, routeName);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            userProvider.setUser(res.body);
            await prefs.setString(
                "x-studio-token", jsonDecode(res.body)['token']);
            await prefs.remove("x-auth-token");
            navigator(SBottomNavigationPage.routeName);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
