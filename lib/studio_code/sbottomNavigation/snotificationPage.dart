import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_app/auth/databaseService.dart';
import 'package:first_app/provider/studio_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SNotificationPage extends StatefulWidget {
  const SNotificationPage({super.key});

  static const String routeName = "/snotification-page";

  @override
  State<SNotificationPage> createState() => _SNotificationPageState();
}

class _SNotificationPageState extends State<SNotificationPage> {
  List<String> notificationData = [
    "Raja Dey have bookmarked your Job Post",
    "Raja Dey Applied on your Job Post",
    "ababab sent you a message",
    "Raja Dey sent you a message",
    "Raja Dey followed you",
  ];

  bool a = false;

  List<List<String>> allData = [];
  List<String>? allNotifications;
  List<String>? allNotificationPic;

  getAllNotifications(String userId) async {
    allData = await DatabaseService().getAllUserNotifications(userId);
    setState(() {
      allNotifications = allData[0];
      allNotificationPic = allData[1];
    });
  }

  updateData() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      a = true;
    });
  }

  @override
  void initState() {
    var sUser = Provider.of<StudioProvider>(context, listen: false).user;
    getAllNotifications(sUser.id);
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
                                    imageUrl: allNotificationPic![reverseIndex],
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
                ),
    );
  }
}
