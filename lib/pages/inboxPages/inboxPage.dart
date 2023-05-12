import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/auth/databaseService.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../studio_code/spages/sinboxPages/smessagePage.dart';

class InboxMessagePage extends StatefulWidget {
  const InboxMessagePage({Key? key}) : super(key: key);

  static const String routeName = "/inboxMessage-page";

  @override
  State<InboxMessagePage> createState() => _InboxMessagePageState();
}

class _InboxMessagePageState extends State<InboxMessagePage> {
  final TextEditingController _textEditingController = TextEditingController();
  List<String>? message;
  Stream? groups;
  List<String> profilePics = [];
  List<String> allUserId = [];

  void getUserGroups(id) async {
    var pp = Provider.of<UserProvider>(context, listen: false).user.id;
    await DatabaseService(uid: pp)
        .getUserGroupsProfilePic("audition")
        .then((value) {
      if (this.mounted) {
        setState(() {
          profilePics = value;
        });
      }
    });

    await DatabaseService(uid: pp).getChatUserId("audition").then((value) {
      if (this.mounted) {
        setState(() {
          allUserId = value;
        });
      }
    });

    await DatabaseService(uid: pp).getUserGroups().then((snapshot) {
      if (this.mounted) {
        setState(() {
          groups = snapshot;
        });
      }
    });
    await DatabaseService(uid: pp).getUserGroupsRecentMessage();
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  @override
  void initState() {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    getUserGroups(user.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: groupList(screenHeight, screenWidth),
    );
  }

  groupList(double screenHeight, double screenWidth) {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          // print(snapshot.data.data());
          print("data");
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              print(snapshot.data['groups'].length);
              return ListView.builder(
                itemCount: snapshot.data['groups'].length,
                itemBuilder: (context, index) {
                  int reverseIndex = snapshot.data['groups'].length - index - 1;

                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => SMessagePage(
                            groupId:
                                getId(snapshot.data['groups'][reverseIndex]),
                            groupName:
                                getName(snapshot.data['groups'][reverseIndex]),
                            userName: snapshot.data['fullName'],
                            profilePic: profilePics.isEmpty
                                ? ""
                                : profilePics[reverseIndex].isEmpty
                                    ? ""
                                    : profilePics[reverseIndex],
                            adminProfilePic: snapshot.data['profilePic'],
                            chatUserId: allUserId[reverseIndex],
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.01),
                        ListTile(
                          leading: Container(
                            width: (screenWidth * 0.1),
                            height: (screenWidth * 0.1),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: profilePics.isEmpty
                                  ? Container(
                                      color: Colors.black,
                                    )
                                  : profilePics[reverseIndex].isEmpty
                                      ? Container(
                                          color: Colors.black,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: profilePics[reverseIndex],
                                          fit: BoxFit.cover,
                                        ),
                            ),
                          ),
                          title: Text(
                            getName(snapshot.data['groups'][reverseIndex]),
                            // getId(snapshot.data['groups'][reverseIndex]),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                              getName(snapshot.data['groups'][reverseIndex])),
                          trailing: AutoSizeText(
                            "5 m",
                            maxFontSize: 16,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Divider(
                          height: 0,
                          thickness: 1,
                          color: Colors.black26,
                          indent: screenWidth * 0.025,
                          endIndent: screenWidth * 0.025,
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("No Chats found"),
              );
            }
          } else {
            return const Center(
              child: Text("No Chats found"),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget sendDocumentButton(double screenWidth, IconData icon) {
    return InkWell(
      onTap: () {
        print("Hello");
      },
      child: Container(
        width: screenWidth * 0.15,
        height: screenWidth * 0.15,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: secondoryColor,
        ),
        child: Icon(icon),
      ),
    );
  }
}
