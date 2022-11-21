import 'dart:convert';

import 'package:first_app/model/job_post_model.dart';
import 'package:first_app/provider/job_post_provider.dart';
import 'package:first_app/provider/studio_provider.dart';
import 'package:first_app/utils/errorHandel.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../common/constant.dart';
import '../utils/showSnackbar.dart';

class OtherService {
  Future<List<JobModel>> getAllJobs({
    required BuildContext context,
  }) async {
    List<JobModel> allJobs = [];
    try {
      var jobProvider = Provider.of<JobProvider>(context, listen: false).job;
      var studioProvider =
          Provider.of<StudioProvider>(context, listen: false).user;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http
          .get(Uri.parse("$url/api/getJob"), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "x-auth-token": token!,
      });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            allJobs.add(
              JobModel.fromJson(
                jsonEncode(jsonDecode(res.body)[i]),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    print(allJobs);
    return allJobs;
  }

  Future<List<JobModel>> categoryJobs({
    required BuildContext context,
    required String category,
  }) async {
    List<JobModel> categoryJobs = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.get(
          Uri.parse("$url/api/getCategoryJob?category=$category"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            categoryJobs.add(
              JobModel.fromJson(
                jsonEncode(jsonDecode(res.body)[i]),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return categoryJobs;
  }

  Future<void> followStudio({
    required BuildContext context,
    required toFollowId,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.post(Uri.parse("$url/api/audition/follow"),
          body: jsonEncode(toFollowId),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          showSnackBar(context, "Followed");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> unfollowStudio({
    required BuildContext context,
    required toFollowId,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.post(
          Uri.parse("$url/api/audition/unfollow"),
          body: jsonEncode(toFollowId),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          showSnackBar(context, "Unfollowed");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
