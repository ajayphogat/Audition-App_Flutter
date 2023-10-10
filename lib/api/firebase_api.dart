// import 'dart:convert';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
// import 'package:first_app/main.dart';
// import 'package:first_app/studio_code/sbottomNavigation/sbottomNavigationBar.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';

// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print('Title: ${message.notification?.title}');
//   print('Bdoy: ${message.notification?.body}');
//   print('Payload: ${message.data}');
// }

// class FirebaseApi {
//   final _firebaseMessaging = FirebaseMessaging.instance;

//   final _androidChannel = const AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     description: 'This Channel is used for important notifications',
//     importance: Importance.max,
//   );

//   final _localNotifications = FlutterLocalNotificationsPlugin();

//   void handleMessage(RemoteMessage? message) async {
//     if (message == null) return;
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? tokenAudition = prefs.getString("x-auth-token");
//     String? tokenStudio = prefs.getString("x-studio-token");

//     print("================message================");
//     print(message);
//     if ((tokenAudition != null && tokenAudition.isNotEmpty) &&
//         (tokenStudio == null || tokenStudio.isEmpty)) {
//       navigatorKey.currentState?.push(
//         MaterialPageRoute(
//           builder: (context) => BottomNavigationPage(
//             pageNumber: 2,
//           ),
//         ),
//       );
//     } else {
//       navigatorKey.currentState?.push(
//         MaterialPageRoute(
//           builder: (context) => SBottomNavigationPage(
//             pageNumber: 2,
//           ),
//         ),
//       );
//     }
//   }

//   Future<String> getDeviceToken() async {
//     var token = await _firebaseMessaging.getToken();
//     return token!;
//   }

//   Future initPushNotifications() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//     FirebaseMessaging.onMessage.listen((message) {
//       final notification = message.notification;
//       if (notification == null) return;

//       print("Local Notification Show");
//       print(notification.title);
//       print(notification.body);
//       print(notification.body);
//       print("payload");
//       print(message);
//       _localNotifications.show(
//         notification.hashCode,
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             _androidChannel.id,
//             _androidChannel.name,
//             channelDescription: _androidChannel.description,
//             priority: Priority.max,
//             icon: '@drawable/launcher_icon',
//           ),
//         ),
//         payload: jsonEncode(message.toMap()),
//       );
//     });
//   }

//   Future initLocalNotifications() async {
//     const iOS = DarwinInitializationSettings();
//     const android = AndroidInitializationSettings('@drawable/launcher_icon');
//     // const android = AndroidInitializationSettings('@drawable/ic_launcher');
//     const settings = InitializationSettings(
//       android: android,
//       iOS: iOS,
//     );
//     await _localNotifications.initialize(settings,
//         onDidReceiveNotificationResponse: (payload) {
//       if (payload != null) {
//         final message = RemoteMessage.fromMap(jsonDecode(payload.toString()));
//         handleMessage(message);
//       }
//     });
//     print("========Local Notifications initialized========");
//     final platform = _localNotifications.resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>();
//     await platform?.requestPermission();

//     await platform?.createNotificationChannel(_androidChannel);
//   }

//   Future<void> initNotifications() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();
//     print("fCMToken: " + fCMToken!);
//     await prefs.setString('fCMToken', fCMToken);
//     initPushNotifications();
//     initLocalNotifications();
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'dart:math';

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
      print('user granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user granted provisional permission');
    } else {
      AppSettings.openAppSettings();
      print('user denied permission');
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

  //TODO: Run this function at the starting and update the token in the firebase database and use it later to send
  // Get Device Token
  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  // If token is changed or refreshed
  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print('refresh');
    });
  }

  void firebaseInit(BuildContext context) {
    // When App is in active state
    FirebaseMessaging.onMessage.listen((message) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? currentGroup = prefs.getString('currentGroup');
      print(message.notification!.title.toString());
      print(message.notification!.body.toString());

      // navigatorKey.currentState!.widget.pages.last.child
      if (Platform.isAndroid) {
        print("currentGroup");
        print(currentGroup);
        if (currentGroup != null) {
          if (currentGroup != message.notification!.title.toString()) {
            initLocalNotifications(context, message);
            showNotification(message);
          } else {
            print("else 1");
          }
        } else {
          print("else 2");
          initLocalNotifications(context, message);
          showNotification(message);
        }
      } else {
        print("else 3");
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
      print("on open");
      handelMessage(context, event);
    });
  }

  void handelMessage(BuildContext context, RemoteMessage message) async {
    print("new message");
    print(message);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tokenAudition = prefs.getString("x-auth-token");
    String? tokenStudio = prefs.getString("x-studio-token");

    // Write Redirect Funtion here
    if (message.data['type'] == 'chat') {
      if ((tokenAudition != null && tokenAudition.isNotEmpty) &&
          (tokenStudio == null || tokenStudio.isEmpty)) {
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
      if ((tokenAudition != null && tokenAudition.isNotEmpty) &&
          (tokenStudio == null || tokenStudio.isEmpty)) {
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
      if ((tokenAudition != null && tokenAudition.isNotEmpty) &&
          (tokenStudio == null || tokenStudio.isEmpty)) {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (context) => const BottomNavigationPage(
              pageNumber: 1,
            ),
          ),
        );
      }
    }
  }
}
