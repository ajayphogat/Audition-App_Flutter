import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/auth/databaseService.dart';
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
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User firebaseUser;
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
        profilePic: "",
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
        photos: [],
        videos: [],
        audios: [],
        documents: [],
        applied: [],
        shortlisted: [],
        accepted: [],
        declined: [],
        following: [],
      );

      http.Response res = await http.post(Uri.parse("$url/api/audition/signup"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      if (res.statusCode == 200) {
        firebaseUser = (await firebaseAuth.createUserWithEmailAndPassword(
                email: email.trim(), password: password))
            .user!;
        if (firebaseUser != null) {
          await DatabaseService(uid: jsonDecode(res.body)['_id'])
              .updateUserData(fname.trim(), email.trim());
        } else {
          showSnackBar(context, firebaseAuth.currentUser.toString());
        }
      }

      httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () async {
            showMessage() => showSnackBar(
                  context,
                  "Account created! Login with same Credentials",
                );

            showMessage();
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
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User firebaseUser;
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
        profilePic: "",
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
        photos: [],
        videos: [],
        audios: [],
        documents: [],
        applied: [],
        shortlisted: [],
        accepted: [],
        declined: [],
        following: [],
      );

      http.Response res = await http.post(Uri.parse("$url/api/audition/login"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      if (res.statusCode == 200) {
        firebaseUser = (await firebaseAuth.signInWithEmailAndPassword(
                email: email.trim(), password: password))
            .user!;

        QuerySnapshot snapshot =
            await DatabaseService(uid: jsonDecode(res.body)['_id'])
                .gettingUserData(email.trim());

        print("Here is snapshot");
        print(snapshot);
      }

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
                "x-firebase-token", FirebaseAuth.instance.currentUser!.uid);
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
          print("pop");
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

      Navigator.pushNamedAndRemoveUntil(
          context, FirstSplashScreen.routeName, (route) => false);
      // print(e.toString());
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

      print(profilePicUrl);

      if (user == "audition") {
        print("audition");
        http.Response res =
            await http.post(Uri.parse("$url/api/upload/profilePic"),
                body: jsonEncode({
                  "profilePicUrl": profilePicUrl,
                }),
                headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "x-auth-token": token!,
            });

        print(res.statusCode);
        httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
            userProvider.setUser(res.body);
          },
        );
      } else {
        print("studio");
        http.Response res =
            await http.post(Uri.parse("$url/api/upload/studio/profilePic"),
                body: jsonEncode({
                  "profilePicUrl": profilePicUrl,
                }),
                headers: <String, String>{
              "Content-Type": "application/json; charset=UTF-8",
              "x-studio-token": studioToken!,
            });

        print(res.statusCode);
        httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () {
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

      print(media);
      print("before res");
      print(mediaType);
      http.Response res = await http.post(Uri.parse("$url/api/upload/media"),
          body: jsonEncode({
            "media": media,
            "mediaType": mediaType,
          }),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      print(res.statusCode);
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

      print(media);
      print("before res");
      print(mediaType);
      http.Response res = await http.post(Uri.parse("$url/api/delete/media"),
          body: jsonEncode({
            "media": media,
            "mediaType": mediaType,
          }),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      print(res.statusCode);
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
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User firebaseUser;
    try {
      var user = StudioModel(
        id: "",
        fname: fname,
        email: email,
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

      http.Response res = await http.post(Uri.parse("$url/api/studio/signup"),
          body: user.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });

      if (res.statusCode == 200) {
        firebaseUser = (await firebaseAuth.createUserWithEmailAndPassword(
                email: email.trim(), password: password))
            .user!;
        if (firebaseUser != null) {
          await DatabaseService(uid: jsonDecode(res.body)['_id'])
              .updateUserData(fname.trim(), email.trim());
        } else {
          showSnackBar(context, firebaseAuth.currentUser.toString());
        }
      }

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
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User firebaseUser;
    try {
      var user = StudioModel(
        id: "",
        fname: "",
        email: email,
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

      if (res.statusCode == 200) {
        firebaseUser = (await firebaseAuth.signInWithEmailAndPassword(
                email: email.trim(), password: password))
            .user!;

        QuerySnapshot snapshot =
            await DatabaseService(uid: jsonDecode(res.body)['_id'])
                .gettingUserData(email.trim());
        print("Here is snapshot");
        print(snapshot);
      }

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
