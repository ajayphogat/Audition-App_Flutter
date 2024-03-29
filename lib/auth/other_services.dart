// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:first_app/auth/databaseService.dart';
import 'package:first_app/model/job_post_model.dart';
import 'package:first_app/pages/categorySection/descriptionPage.dart';
import 'package:first_app/pages/categorySection/studio_description.dart';
import 'package:first_app/provider/job_post_provider.dart';
import 'package:first_app/provider/studio_provider.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sactorProfilePage.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sdesignationPage.dart';
import 'package:first_app/studio_code/spages/sprofilePages/followersPage.dart';
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
      var studioProvider = Provider.of<StudioProvider>(context, listen: false);

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
          studioProvider.setUser(jsonEncode({
            '_id': "",
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
          }));
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
    return allJobs;
  }

  Future<List<JobModel>> getStudioJobs({
    required BuildContext context,
    required String search,
  }) async {
    List<JobModel> allJobs = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-studio-token');

      if (token == null) {
        await prefs.setString("x-studio-token", "");
        token = prefs.getString("x-studio-token");
      }
      http.Response res = await http.get(
          Uri.parse("$url/api/getStudioJob?search=$search"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-studio-token": token!,
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
    return allJobs;
  }

  Future<List<JobModel>> categoryJobs({
    required BuildContext context,
    required String category,
    required String search,
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
          Uri.parse(
              "$url/api/getCategoryJob?category=$category&search=$search"),
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
    required String toFollowId,
    required String jobId,
  }) async {
    try {
      var jobProvider = Provider.of<JobProvider>(context, listen: false);
      var userProvider = Provider.of<UserProvider>(context, listen: false).user;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.post(Uri.parse("$url/api/audition/follow"),
          body: jsonEncode({
            "toFollowId": toFollowId,
            "jobId": jobId,
          }),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          DatabaseService(uid: toFollowId).updateNotification(
              "${userProvider.fname} started following you__${userProvider.profilePic}");
          jobProvider.setUser(res.body);
          showSnackBar(context, "Followed");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> unfollowStudio({
    required BuildContext context,
    required String toFollowId,
    required String jobId,
  }) async {
    try {
      var jobProvider = Provider.of<JobProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res =
          await http.post(Uri.parse("$url/api/audition/unfollow"),
              body: jsonEncode({
                "toFollowId": toFollowId,
                "jobId": jobId,
              }),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          jobProvider.setUser(res.body);
          showSnackBar(context, "Unfollowed");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> bookmarked({
    required BuildContext context,
    required toBookmarkId,
  }) async {
    try {
      var jobProvider = Provider.of<JobProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");
      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res =
          await http.post(Uri.parse("$url/api/audition/bookmark"),
              body: jsonEncode({
                "jobPostId": toBookmarkId,
              }),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          jobProvider.setUser(res.body);
          showSnackBar(context, "Bookmarked");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> unBookmarked({
    required BuildContext context,
    required toBookmarkId,
  }) async {
    try {
      var jobProvider = Provider.of<JobProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");
      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res =
          await http.post(Uri.parse("$url/api/audition/undoBookmark"),
              body: jsonEncode({
                "jobPostId": toBookmarkId,
              }),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          jobProvider.setUser(res.body);
          showSnackBar(context, "Removed Bookmark");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<dynamic> getJobDetails({
    required BuildContext context,
    required String jobId,
  }) async {
    dynamic jobData;
    navigatePop() => Navigator.pop(context);
    // navigatePush(data) =>
    //     Navigator.pushNamed(context, DescriptionPage.routeName,
    //         arguments: data);
    navigatePush() => Navigator.pushNamed(context, DescriptionPage.routeName);
    try {
      var jobProvider = Provider.of<JobProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");
      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.get(
          Uri.parse("$url/api/getOneJobDetail?jobId=$jobId"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          jobProvider.setUser(res.body);
          navigatePop();
          navigatePush();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<dynamic> getJobDetails1({
    required BuildContext context,
    required String jobId,
  }) async {
    dynamic jobData;
    navigatePop() => Navigator.pop(context);
    // navigatePush(data) =>
    //     Navigator.pushNamed(context, DescriptionPage.routeName,
    //         arguments: data);
    navigatePush() =>
        Navigator.pushNamed(context, StudioDescriptionPage.routeName);
    try {
      var jobProvider = Provider.of<JobProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");
      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.get(
          Uri.parse("$url/api/getOneJobDetail?jobId=$jobId"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          jobProvider.setUser(res.body);
          navigatePop();
          navigatePush();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<dynamic> getStudioJobDetail({
    required BuildContext context,
    required String jobId,
  }) async {
    dynamic jobData;
    navigatePop() => Navigator.pop(context);
    // navigatePush(data) =>
    //     Navigator.pushNamed(context, DescriptionPage.routeName,
    //         arguments: data);
    navigatePush() =>
        Navigator.pushNamed(context, StudioDescriptionPage.routeName);
    try {
      var jobProvider = Provider.of<JobProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-studio-token");
      if (token == null) {
        await prefs.setString("x-studio-token", "");
        token = prefs.getString("x-studio-token");
      }

      http.Response res = await http.get(
          Uri.parse("$url/api/getOneStudioJobDetail?jobId=$jobId"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-studio-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          jobProvider.setUser(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<dynamic> getStudioJobDetail_Studio({
    required BuildContext context,
    required String jobId,
  }) async {
    // dynamic jobData;
    navigatePop() => Navigator.pop(context);
    // navigatePush(data) =>
    //     Navigator.pushNamed(context, DescriptionPage.routeName,
    //         arguments: data);
    navigatePush(List<dynamic> argument, jobId) =>
        Navigator.pushNamed(context, SActorProfilePage.routeName,
            arguments: [argument, jobId]);
    try {
      List<dynamic> appliedUser = [];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-studio-token");
      if (token == null) {
        await prefs.setString("x-studio-token", "");
        token = prefs.getString("x-studio-token");
      }

      http.Response res = await http.get(
          Uri.parse("$url/api/studio/getOneStudioJobDetail?jobId=$jobId"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-studio-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            appliedUser.add(jsonDecode(res.body)[i]);
          }
          navigatePop();
          navigatePush(appliedUser, jobId);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<dynamic> getAcceptedStudioJobDetails({
    required BuildContext context,
    required String jobId,
  }) async {
    // dynamic jobData;
    navigatePop() => Navigator.pop(context);
    // navigatePush(data) =>
    //     Navigator.pushNamed(context, DescriptionPage.routeName,
    //         arguments: data);
    navigatePush(List<dynamic> argument, jobId) =>
        Navigator.pushNamed(context, SActorProfilePage.routeName,
            arguments: [argument, jobId]);
    try {
      List<dynamic> _acceptedUser = [];
      var jobProvider = Provider.of<JobProvider1>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-studio-token");
      if (token == null) {
        await prefs.setString("x-studio-token", "");
        token = prefs.getString("x-studio-token");
      }

      http.Response res = await http.get(
          Uri.parse("$url/api/studio/getOneAcceptedJobDetail?jobId=$jobId"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-studio-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            _acceptedUser.add(jsonDecode(res.body)[i]);
          }
          navigatePop();
          navigatePush(_acceptedUser, jobId);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<dynamic> getShortlistedStudioJobDetails({
    required BuildContext context,
    required String jobId,
  }) async {
    // dynamic jobData;
    navigatePop() => Navigator.pop(context);
    // navigatePush(data) =>
    //     Navigator.pushNamed(context, DescriptionPage.routeName,
    //         arguments: data);
    navigatePush(List<dynamic> argument, jobId) =>
        Navigator.pushNamed(context, SActorProfilePage.routeName,
            arguments: [argument, jobId]);
    try {
      List<dynamic> _acceptedUser = [];
      var jobProvider = Provider.of<JobProvider1>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-studio-token");
      if (token == null) {
        await prefs.setString("x-studio-token", "");
        token = prefs.getString("x-studio-token");
      }

      http.Response res = await http.get(
          Uri.parse("$url/api/studio/getOneShortlistedJobDetail?jobId=$jobId"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-studio-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            _acceptedUser.add(jsonDecode(res.body)[i]);
          }
          navigatePop();
          navigatePush(_acceptedUser, jobId);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> applyJob({
    required BuildContext context,
    required String jobId,
    required String studioUserId,
  }) async {
    try {
      String? user2FCMToken;
      var jobProvider = Provider.of<JobProvider>(context, listen: false);
      var userProvider = Provider.of<UserProvider>(context, listen: false).user;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-auth-token");
      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res =
          await http.post(Uri.parse("$url/api/audition/applyJob"),
              body: jsonEncode({
                "jobPostId": jobId,
              }),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      user2FCMToken = await DatabaseService().gettingUserFCMToken(studioUserId);
      if (user2FCMToken != null) {
        httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () async {
            var data = {
              'to': user2FCMToken,
              'priority': 'high',
              'notification': {
                'title': "Applied",
                'body': "${userProvider.fname} applied on your job.",
                "alert": true
              },
              'data': {
                'type': 'job applied',
              }
            };

            http.Response ress = await http.post(
                Uri.parse('https://fcm.googleapis.com/fcm/send'),
                body: jsonEncode(data),
                headers: {
                  "Content-Type": "application/json; charset=UTF-8",
                  "Authorization":
                      "key=AAAApcOKBAM:APA91bGGRSk9rDbs6mGdNlHICXGLfObzdulJ7lbwtzF6jwOnVKfx23GmMO3sfuvI2KNnnmsGdXjgShv7ZhHM8I4jaLmS0ljkZiQmE6UfDe-MbvEmTYvnh7IfnoqVrQh6h7GOQufJYAs-"
                });
            DatabaseService(uid: studioUserId).updateNotification(
                "${userProvider.fname} has applied on your job post__${userProvider.profilePic}");
            jobProvider.setUser(res.body);
            showSnackBar(context, "Job applied");
          },
        );
      } else {
        httpErrorHandel(
          context: context,
          res: res,
          onSuccess: () async {
            DatabaseService(uid: studioUserId).updateNotification(
                "${userProvider.fname} has applied on your job post__${userProvider.profilePic}");
            jobProvider.setUser(res.body);
            showSnackBar(context, "Job applied");
          },
        );
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> acceptedStudioJob({
    required BuildContext context,
    required jobId,
    required userId,
    required sUserName,
    required jobType,
    required String work,
  }) async {
    try {
      var user2FCMToken = "";
      var jobProvider = Provider.of<JobProvider1>(context, listen: false);
      var sUser = Provider.of<StudioProvider>(context, listen: false).user;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-studio-token");
      if (token == null) {
        await prefs.setString("x-studio-token", "");
        token = prefs.getString("x-studio-token");
      }

      http.Response res =
          await http.post(Uri.parse("$url/api/studio/acceptJob"),
              body: jsonEncode({
                "jobPostId": jobId,
                "userId": userId,
                "work": work,
              }),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-studio-token": token!,
          });

      user2FCMToken = await DatabaseService().gettingUserFCMToken(userId);
      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () async {
          ss() => showSnackBar(context, work);
          if (jsonDecode(res.body)["isAccepted"]) {
            var data = {
              'to': user2FCMToken,
              'priority': 'high',
              'notification': {
                'title': "Accepted",
                'body': "$sUserName accepted you as $jobType for their job.",
                "alert": true
              },
              'data': {
                'type': 'job status',
              }
            };

            http.Response res = await http.post(
                Uri.parse('https://fcm.googleapis.com/fcm/send'),
                body: jsonEncode(data),
                headers: {
                  "Content-Type": "application/json; charset=UTF-8",
                  "Authorization":
                      "key=AAAApcOKBAM:APA91bGGRSk9rDbs6mGdNlHICXGLfObzdulJ7lbwtzF6jwOnVKfx23GmMO3sfuvI2KNnnmsGdXjgShv7ZhHM8I4jaLmS0ljkZiQmE6UfDe-MbvEmTYvnh7IfnoqVrQh6h7GOQufJYAs-"
                });
            await DatabaseService(uid: userId).updateNotification(
                "$sUserName accepted you as an $jobType for their job.__${sUser.profilePic}");
          } else if (jsonDecode(res.body)["isShortlisted"]) {
            var data = {
              'to': user2FCMToken,
              'priority': 'high',
              'notification': {
                'title': "Shortlisted",
                'body': "$sUserName shortlisted you as $jobType for their job.",
                "alert": true
              },
              'data': {
                'type': 'job status',
              }
            };

            http.Response res = await http.post(
                Uri.parse('https://fcm.googleapis.com/fcm/send'),
                body: jsonEncode(data),
                headers: {
                  "Content-Type": "application/json; charset=UTF-8",
                  "Authorization":
                      "key=AAAApcOKBAM:APA91bGGRSk9rDbs6mGdNlHICXGLfObzdulJ7lbwtzF6jwOnVKfx23GmMO3sfuvI2KNnnmsGdXjgShv7ZhHM8I4jaLmS0ljkZiQmE6UfDe-MbvEmTYvnh7IfnoqVrQh6h7GOQufJYAs-"
                });
            await DatabaseService(uid: userId).updateNotification(
                "$sUserName shortlisted you as an $jobType for their job.__${sUser.profilePic}");
          } else if (jsonDecode(res.body)["isDeclined"]) {
            var data = {
              'to': user2FCMToken,
              'priority': 'high',
              'notification': {
                'title': "Declined",
                'body': "$sUserName declined you as $jobType for their job.",
                "alert": true
              },
              'data': {
                'type': 'job status',
              }
            };

            http.Response res = await http.post(
                Uri.parse('https://fcm.googleapis.com/fcm/send'),
                body: jsonEncode(data),
                headers: {
                  "Content-Type": "application/json; charset=UTF-8",
                  "Authorization":
                      "key=AAAApcOKBAM:APA91bGGRSk9rDbs6mGdNlHICXGLfObzdulJ7lbwtzF6jwOnVKfx23GmMO3sfuvI2KNnnmsGdXjgShv7ZhHM8I4jaLmS0ljkZiQmE6UfDe-MbvEmTYvnh7IfnoqVrQh6h7GOQufJYAs-"
                });
            await DatabaseService(uid: userId).updateNotification(
                "$sUserName declined you as an $jobType for their job.__${sUser.profilePic}");
          }
          jobProvider.setUser(res.body);
          ss();
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<bool> studioAcceptJobData({
    required BuildContext context,
    required jobId,
    required userId,
  }) async {
    bool isAccepted = false;
    try {
      var jobProvider = Provider.of<JobProvider1>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-studio-token");
      if (token == null) {
        await prefs.setString("x-studio-token", "");
        token = prefs.getString("x-studio-token");
      }

      http.Response res =
          await http.post(Uri.parse("$url/api/studioAcceptJobData"),
              body: jsonEncode({
                "jobPostId": jobId,
                "userId": userId,
              }),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-studio-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          jobProvider.setUser(res.body);
          isAccepted = jobProvider.job.isAccepted!;
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return isAccepted;
  }

  Future<List<JobModel1>> showWorkingJobs({
    required BuildContext context,
    required String working,
    required String search,
  }) async {
    List<JobModel1> workingJobs = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        await prefs.setString("x-auth-token", "");
        token = prefs.getString("x-auth-token");
      }

      http.Response res = await http.get(
          Uri.parse("$url/api/showWorkingJobs?working=$working&search=$search"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-auth-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            workingJobs.add(
              JobModel1.fromJson(
                jsonEncode(jsonDecode(res.body)[i]),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return workingJobs;
  }

  Future<List<JobModel1>> showStudioJobs({
    required BuildContext context,
    required String working,
    required String search,
  }) async {
    List<JobModel1> workingJobs = [];
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-studio-token');

      if (token == null) {
        await prefs.setString("x-studio-token", "");
        token = prefs.getString("x-studio-token");
      }

      http.Response res = await http.get(
          Uri.parse(
              "$url/api/studio/showWorkingJobs?working=$working&search=$search"),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-studio-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            workingJobs.add(
              JobModel1.fromJson(
                jsonEncode(jsonDecode(res.body)[i]),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return workingJobs;
  }

  Future<void> getStudioData({
    required BuildContext context,
  }) async {
    try {
      var studioProvider = Provider.of<StudioProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-studio-token');

      if (token == null) {
        await prefs.setString("x-studio-token", "");
        token = prefs.getString("x-studio-token");
      }

      http.Response res = await http
          .get(Uri.parse("$url/api/getStudioData"), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "x-studio-token": token!,
      });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () {
          studioProvider.setUser(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> artistProfileData({
    required BuildContext context,
    required userID,
    required jobId,
  }) async {
    try {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-studio-token");
      if (token == null) {
        await prefs.setString("x-studio-token", "");
        token = prefs.getString("x-studio-token");
      }

      http.Response res =
          await http.post(Uri.parse("$url/api/studio/getArtistData"),
              body: jsonEncode({
                "userID": userID,
              }),
              headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
            "x-studio-token": token!,
          });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () async {
          navigatorPop() => Navigator.pop(context);
          navigatorPush() =>
              Navigator.pushNamed(context, SDesignationPage.routeName,
                  arguments: jobId);
          userProvider.setUser(res.body);
          await studioAcceptJobData(
              context: context, jobId: jobId, userId: userID);
          navigatorPop();
          navigatorPush();
          // showSnackBar(context, "Job applied");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<void> getFollowers({
    required BuildContext context,
  }) async {
    try {
      var studioProvider = Provider.of<StudioProvider1>(context, listen: false);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("x-studio-token");
      if (token == null) {
        await prefs.setString("x-studio-token", "");
        token = prefs.getString("x-studio-token");
      }

      http.Response res = await http
          .get(Uri.parse("$url/api/showFollowers"), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
        "x-studio-token": token!,
      });

      httpErrorHandel(
        context: context,
        res: res,
        onSuccess: () async {
          studioProvider.setUser(res.body);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
