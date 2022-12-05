import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/auth/databaseService.dart';
import 'package:first_app/studio_code/scommon/sdata.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:first_app/studio_code/spages/sinboxPages/smessagePage.dart';
import 'package:flutter/material.dart';

class SInboxMessagePage extends StatefulWidget {
  const SInboxMessagePage({Key? key}) : super(key: key);

  static const String routeName = "/sinboxMessage-page";

  @override
  State<SInboxMessagePage> createState() => _SInboxMessagePageState();
}

class _SInboxMessagePageState extends State<SInboxMessagePage> {
  bool a = false;
  Stream? groups;

  void getUserGroups() async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
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

      // a
      //     ? Padding(
      //         padding: const EdgeInsets.only(top: 25),
      //         child: ListView.builder(
      //           itemCount: inboxMessageData.length,
      //           itemBuilder: (context, index) {
      //             List<String> data = inboxMessageData[index];
      //             return InkWell(
      //               onTap: () {
      //                 Navigator.pushNamed(context, SMessagePage.routeName);
      //               },
      //               child: SizedBox(
      //                 child: Column(
      //                   children: [
      //                     ListTile(
      //                       leading: CircleAvatar(
      //                         radius: screenWidth * 0.0635,
      //                         child: ClipRRect(
      //                           borderRadius: BorderRadius.circular(50),
      //                           child: Image.asset(data[2]),
      //                         ),
      //                       ),
      //                       title: Padding(
      //                         padding: const EdgeInsets.only(bottom: 5),
      //                         child: Text(
      //                           data[0],
      //                           style: const TextStyle(
      //                             fontFamily: fontFamily,
      //                           ),
      //                         ),
      //                       ),
      //                       subtitle: Text(
      //                         data[1],
      //                         style: const TextStyle(
      //                           fontSize: 13,
      //                           fontFamily: fontFamily,
      //                           color: Colors.black,
      //                         ),
      //                       ),
      //                     ),
      //                     const Divider(
      //                       thickness: 1,
      //                       color: Color(0xFF979797),
      //                       indent: 20,
      //                       endIndent: 20,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
      //       )
      //     : const Center(
      //         child: CircularProgressIndicator(),
      // )
    );
  }

  groupList(double screenHeight, double screenWidth) {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['groups'].length != 0) {
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
                          groupId: getId(snapshot.data['groups'][reverseIndex]),
                          groupName:
                              getName(snapshot.data['groups'][reverseIndex]),
                          userName: snapshot.data['fullName'],
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: screenWidth * 0.0635,
                        child: Text(
                          getName(snapshot.data['groups'][reverseIndex])
                              .substring(0, 1)
                              .toUpperCase(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        )

                        // ClipRRect(
                        //   borderRadius: BorderRadius.circular(50),
                        //   child: Image.asset(data[2]),
                        // ),
                        ),
                    title: Text(
                      getId(snapshot.data['groups'][reverseIndex]),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle:
                        Text(getName(snapshot.data['groups'][reverseIndex])),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
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
