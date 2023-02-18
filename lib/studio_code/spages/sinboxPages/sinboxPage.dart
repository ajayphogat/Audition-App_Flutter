import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_app/auth/databaseService.dart';
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

  void getUserGroups() async {
    var pp = Provider.of<StudioProvider>(context, listen: false).user.id;
    await DatabaseService(uid: pp)
        .getUserGroupsProfilePic("studio")
        .then((value) {
      if (this.mounted) {
        setState(() {
          profilePics = value;
          print(profilePics[0]);
          print(profilePics[1]);
          print("profilePic");
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
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          // print(snapshot.data.data());
          print("data");
          if (snapshot.data['groups'] != null) {
            if (snapshot.data['groups'].length != 0) {
              return ListView.builder(
                itemCount: snapshot.data['groups'].length,
                itemBuilder: (context, index) {
                  int reverseIndex = snapshot.data['groups'].length - index - 1;
                  print(profilePics[reverseIndex]);
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
                            profilePic: profilePics[reverseIndex],
                            adminProfilePic: snapshot.data['profilePic'],
                            chatUserId: allUserId[reverseIndex],
                          ),
                        ),
                      );
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
                                    profilePics[reverseIndex].isEmpty
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
}
