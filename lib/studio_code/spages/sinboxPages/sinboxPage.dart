import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_app/auth/databaseService.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/provider/studio_provider.dart';
import 'package:first_app/studio_code/spages/sinboxPages/smessagePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SInboxMessagePage extends StatefulWidget {
  const SInboxMessagePage({Key? key}) : super(key: key);

  static const String routeName = "/sinboxMessage-page";

  @override
  State<SInboxMessagePage> createState() => _SInboxMessagePageState();
}

class _SInboxMessagePageState extends State<SInboxMessagePage> {
  bool a = false;
  Stream? groups;
  List<String> profilePics = [];
  List<String> recentMessages = [];
  List<String> allUserId = [];

  Future<void> getUserGroups() async {
    var pp = Provider.of<StudioProvider>(context, listen: false).user.id;
    await DatabaseService(uid: pp)
        .getUserGroupsProfilePic("studio")
        .then((value) {
      if (this.mounted) {
        setState(() {
          profilePics = value;
        });
      }
    });
    await DatabaseService(uid: pp).getChatUserId("studio").then((value) {
      if (this.mounted) {
        setState(() {
          allUserId = value;
        });
      }
    });

    await DatabaseService(uid: pp).getUserGroupsRecentMessage().then((value) {
      if (this.mounted) {
        setState(() {
          recentMessages = value;
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
    getUserGroups();
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
    var pp = Provider.of<StudioProvider>(context, listen: false).user.id;
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return RefreshIndicator(
                onRefresh: () {
                  return getUserGroups();
                },
                child: ListView.builder(
                  itemCount: snapshot.data['groups'].length,
                  itemBuilder: (context, index) {
                    // int reverseIndex =
                    //     snapshot.data['groups'].length - index - 1;
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (context) => SMessagePage(
                              groupId: getId(snapshot.data['groups'][index]),
                              groupName: snapshot.data['groups'][index],
                              // groupName: getName(
                              //     snapshot.data['groups'][reverseIndex]),
                              userName: snapshot.data['fullName'],
                              profilePic: profilePics[index],
                              adminProfilePic: snapshot.data['profilePic'],
                              chatUserId: allUserId[index],
                              currentUserId: pp,
                            ),
                          ),
                        ).then((value) {
                          getUserGroups();
                        });
                      },
                      child: Container(
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
                              child: profilePics == [] ||
                                      profilePics[index].isEmpty
                                  ? Container(
                                      color: Colors.black,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: profilePics[index],
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          title: Text(
                            getName(snapshot.data['groups'][index]),
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // subtitle: Text(
                          //   recentMessages[reverseIndex],
                          //   style: const TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        ),
                      ),
                    );
                  },
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
            child: CircularProgressIndicator(color: greenColor),
          );
        }
      },
    );
  }
}
