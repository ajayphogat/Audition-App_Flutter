// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:first_app/main.dart';
import 'package:first_app/provider/studio_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bottomNavigation/bottomNavigationBar.dart';
import '../pages/categorySection/categoryDetailPage.dart';
import '../provider/user_provider.dart';
import '../studio_code/sbottomNavigation/sbottomNavigationBar.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Request for the permission to send notifications
  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {
      AppSettings.openAppSettings();
    }
  }

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize the Local Notifications
  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@drawable/launcher_icon');
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        handelMessage(context, message);
      },
    );
  }

  // Get Device Token
  Future<String> getDeviceToken() async {
    String? token;
    if (Platform.isIOS) {
      token = await messaging.getAPNSToken();
      if (token == null) {
        await Future.delayed(const Duration(seconds: 1));
        token = await messaging.getAPNSToken();
      }
    } else {
      token = await messaging.getToken();
    }
    return token!;
  }

  // If token is changed or refreshed
  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
    });
  }

  void firebaseInit(BuildContext context) {
    // When App is in active state
    FirebaseMessaging.onMessage.listen((message) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? currentGroup = prefs.getString('currentGroup');

      // navigatorKey.currentState!.widget.pages.last.child
      if (Platform.isAndroid) {
        if (currentGroup != null) {
          if (currentGroup != message.notification!.title.toString()) {
            initLocalNotifications(context, message);
            showNotification(message);
          } else {}
        } else {
          initLocalNotifications(context, message);
          showNotification(message);
        }
      } else {
        showNotification(message);
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel androidNotificationChannel =
        const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notification',
      importance: Importance.max,
      showBadge: true,
      playSound: true,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      androidNotificationChannel.id.toString(),
      androidNotificationChannel.name.toString(),
      channelDescription: 'your channel description',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      playSound: true,
      icon: '@drawable/launcher_icon',
    );

    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    // When app is terminated
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handelMessage(context, initialMessage);
    }

    // When app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handelMessage(context, event);
    });
  }

  void handelMessage(BuildContext context, RemoteMessage message) async {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    var studioUser = Provider.of<StudioProvider>(context, listen: false).user;

    // Write Redirect Funtion here
    if (message.data['type'] == 'chat') {
      // For chat messages
      if (user.id.isNotEmpty && studioUser.id.isEmpty) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => const BottomNavigationPage(
              pageNumber: 2,
            ),
          ),
        );
      } else {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => const SBottomNavigationPage(
              pageNumber: 2,
            ),
          ),
        );
      }
    } else if (message.data['type'] == 'new job') {
      // When a studio that a artist has followed has posted a new job => from studio to audition user
      if (user.id.isNotEmpty && studioUser.id.isEmpty) {
        if (message.data['category'] == 'Actor') {
          navigatorKey.currentState!.pushNamed(
            CategoryDetailPage.routeName,
            arguments: [0, ""],
          );
        } else if (message.data['category'] == 'Model') {
          navigatorKey.currentState!.pushNamed(
            CategoryDetailPage.routeName,
            arguments: [1, ""],
          );
        } else if (message.data['category'] == 'Singer') {
          navigatorKey.currentState!.pushNamed(
            CategoryDetailPage.routeName,
            arguments: [2, ""],
          );
        } else if (message.data['category'] == 'Musician') {
          navigatorKey.currentState!.pushNamed(
            CategoryDetailPage.routeName,
            arguments: [3, ""],
          );
        } else if (message.data['category'] == 'Writer') {
          navigatorKey.currentState!.pushNamed(
            CategoryDetailPage.routeName,
            arguments: [4, ""],
          );
        } else if (message.data['category'] == 'Dancer') {
          navigatorKey.currentState!.pushNamed(
            CategoryDetailPage.routeName,
            arguments: [5, ""],
          );
        } else if (message.data['category'] == 'Choreographer') {
          navigatorKey.currentState!.pushNamed(
            CategoryDetailPage.routeName,
            arguments: [6, ""],
          );
        } else if (message.data['category'] == 'Designer') {
          navigatorKey.currentState!.pushNamed(
            CategoryDetailPage.routeName,
            arguments: [7, ""],
          );
        } else if (message.data['category'] == 'Other') {
          navigatorKey.currentState!.pushNamed(
            CategoryDetailPage.routeName,
            arguments: [8, ""],
          );
        } else {
          navigatorKey.currentState!.pushNamed(
            CategoryDetailPage.routeName,
            arguments: [0, ""],
          );
        }
      }
    } else if (message.data['type'] == 'job status') {
      // from Studio to audition user for accepting or rejecting job status
      if ((user.id.isNotEmpty && studioUser.id.isEmpty) &&
          (message.data['page'] == 'accepted')) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => const BottomNavigationPage(
              pageNumber: 1,
              page: 2,
            ),
          ),
        );
      } else if ((user.id.isNotEmpty && studioUser.id.isEmpty) &&
          (message.data['page'] == 'shortlisted')) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => const BottomNavigationPage(
              pageNumber: 1,
              page: 1,
            ),
          ),
        );
      } else if ((user.id.isNotEmpty && studioUser.id.isEmpty) &&
          (message.data['page'] == 'declined')) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => const BottomNavigationPage(
              pageNumber: 1,
              page: 3,
            ),
          ),
        );
      }
    } else if (message.data['type'] == 'job applied') {
      // push notification from audition to studio for job applied
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => const SBottomNavigationPage(
            pageNumber: 1,
            page: 1,
          ),
        ),
      );
    } else if (message.data['type'] == 'interview') {
      // from Studio panel to Audition user(app) for interview
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => const BottomNavigationPage(
            pageNumber: 2,
            inboxPage: 1,
          ),
        ),
      );
    }
  }
}
