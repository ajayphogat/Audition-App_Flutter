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
  List<String>? recentMsgTime;
  Stream? groups;
  List<String> profilePics = [];
  List<String> allUserId = [];

  Future<void> getUserGroups(id) async {
    var pp = Provider.of<UserProvider>(context, listen: false).user.id;
    await DatabaseService(uid: pp)
        .getUserGroupsRecentMessageTime()
        .then((snapshot) {
      if (this.mounted) {
        setState(() {
          recentMsgTime = snapshot;
        });
      }
    });

    await DatabaseService(uid: pp)
        .getUserGroupsRecentMessage()
        .then((snapshot) {
      if (this.mounted) {
        setState(() {
          message = snapshot;
        });
      }
    });

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
    var pp = Provider.of<UserProvider>(context, listen: false).user.id;
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return RefreshIndicator(
                onRefresh: () {
                  return getUserGroups(pp);
                },
                child: ListView.separated(
                  itemCount: snapshot.data['groups'].length,
                  itemBuilder: (context, index) {
                    // int reverseIndex = snapshot.data['groups'].length - index - 1;
                    var newDate = DateTime.fromMillisecondsSinceEpoch(
                        int.parse(recentMsgTime![index]));
                    // var newDate = DateTime.fromMillisecondsSinceEpoch(
                    //     int.parse(recentMsgTime![reverseIndex]));
                    var currentDate = DateTime.now();
                    Duration duration = currentDate.difference(newDate);
                    var newMin = duration.inMinutes;

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => SMessagePage(
                              groupId: getId(snapshot.data['groups'][index]),
                              // getId(snapshot.data['groups'][reverseIndex]),
                              groupName: snapshot.data['groups'][index],
                              // groupName: snapshot.data['groups'][reverseIndex],
                              // groupName:
                              //     getName(snapshot.data['groups'][reverseIndex]),
                              userName: snapshot.data['fullName'],
                              profilePic: profilePics.isEmpty
                                  ? ""
                                  : profilePics[index].isEmpty
                                      // : profilePics[reverseIndex].isEmpty
                                      ? ""
                                      : profilePics[index],
                              // : profilePics[reverseIndex],
                              adminProfilePic: snapshot.data['profilePic'],
                              chatUserId: allUserId[index],
                              // chatUserId: allUserId[reverseIndex],
                              currentUserId: pp,
                            ),
                          ),
                        );
                        setState(() {});
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
                                    : profilePics[index].isEmpty
                                        // : profilePics[reverseIndex].isEmpty
                                        ? Container(
                                            color: Colors.black,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: profilePics[index],
                                            // imageUrl: profilePics[reverseIndex],
                                            fit: BoxFit.cover,
                                          ),
                              ),
                            ),
                            title: Text(
                              getName(snapshot.data['groups'][index]),
                              // getName(snapshot.data['groups'][reverseIndex]),
                              // getId(snapshot.data['groups'][reverseIndex]),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              message![index],
                              // message![reverseIndex],
                              // getName(snapshot.data['groups'][reverseIndex]),
                            ),
                            trailing: AutoSizeText(
                              "${newMin} m",
                              maxFontSize: 16,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.01),

                          // Divider(
                          //   height: 0,
                          //   thickness: 1,
                          //   color: Colors.black26,
                          //   indent: screenWidth * 0.025,
                          //   endIndent: screenWidth * 0.025,
                          // ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                    thickness: 1,
                    height: 0,
                    indent: screenWidth * 0.03,
                    endIndent: screenWidth * 0.03,
                    color: Color(0xff706E72).withOpacity(0.28),
                  ),
                ),
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
      onTap: () {},
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
