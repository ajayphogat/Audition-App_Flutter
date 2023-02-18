import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_app/auth/databaseService.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  static const String routeName = "/notification-page";
  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<String> notificationData = [
    "Marvel Studio shortlisted you",
    "Marvel Studio followed you",
    "Marvel Studio sent you a message",
  ];

  bool a = false;
  List<List<String>> allData = [];
  List<String>? allNotifications;
  List<String>? allNotificationPic;

  getAllNotifications(String userId) async {
    allData = await DatabaseService().getAllUserNotifications(userId);
    if (this.mounted) {
      setState(() {
        allNotifications = allData[0];
        allNotificationPic = allData[1];
      });
    }
  }

  updateData() async {
    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );
    setState(() {
      a = true;
    });
  }

  @override
  void initState() {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    getAllNotifications(user.id);

    super.initState();
    // updateData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: allNotifications == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : allNotifications!.isEmpty
                ? const Center(
                    child: Text("No Data Available"),
                  )
                : ListView.builder(
                    itemCount: allNotifications!.length,
                    itemBuilder: (context, index) {
                      int reverseIndex = allNotifications!.length - index - 1;
                      return Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                          ),
                        ),
                        // margin: const EdgeInsets.only(bottom: 5),
                        child: ListTile(
                          leading: Container(
                            width: (screenWidth * 0.1),
                            height: (screenWidth * 0.1),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: allNotificationPic![reverseIndex].isEmpty
                                  ? Container(
                                      color: Colors.black,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl:
                                          allNotificationPic![reverseIndex],
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          title: Text(
                            allNotifications![reverseIndex],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ));
  }
}
