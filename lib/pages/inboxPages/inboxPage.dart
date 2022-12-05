import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/auth/databaseService.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/inboxPages/messagePage.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

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

  void getUserGroups(id) async {
    await DatabaseService(uid: id).getUserGroups().then((snapshot) {
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

      // SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       ((message == null) || (message!.length == 0))
      //           ? Container(
      //               height: screenHeight - (screenHeight * 0.213),
      //             )
      //           : Container(
      //               height: screenHeight - (screenHeight * 0.213),
      //               child: ListView.builder(
      //                 itemCount: message!.length,
      //                 itemBuilder: (context, index) {
      //                   return Row(
      //                     mainAxisAlignment: MainAxisAlignment.end,
      //                     children: [
      //                       Padding(
      //                         padding: const EdgeInsets.only(top: 30),
      //                         child: ChatBubble(
      //                           clipper: ChatBubbleClipper1(
      //                               type: BubbleType.sendBubble),
      //                           alignment: Alignment.topRight,
      //                           backGroundColor: secondoryColor,
      //                           child: Container(
      //                             constraints: BoxConstraints(
      //                               maxWidth: screenWidth * 0.7,
      //                             ),
      //                             child: Text(
      //                               message![index],
      //                               style: const TextStyle(
      //                                 color: Colors.black,
      //                               ),
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                       Container(
      //                         width: 32,
      //                         height: 32,
      //                         decoration: const BoxDecoration(
      //                           shape: BoxShape.circle,
      //                         ),
      //                         child: ClipRRect(
      //                           borderRadius: BorderRadius.circular(32),
      //                           child: Image.asset(
      //                               "asset/images/uiImages/face.png",
      //                               fit: BoxFit.cover),
      //                         ),
      //                       ),
      //                     ],
      //                   );
      //                 },
      //               )),
      //       Column(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: [
      //           Padding(
      //             padding: EdgeInsets.symmetric(
      //               horizontal: screenWidth * 0.02,
      //               vertical: screenHeight * 0.005,
      //             ),
      //             child: Material(
      //               borderRadius: BorderRadius.circular(20),
      //               elevation: 4,
      //               child: Container(
      //                 width: screenWidth,
      //                 height: screenHeight * 0.06,
      //                 alignment: Alignment.centerLeft,
      //                 padding: EdgeInsets.only(
      //                     left: screenWidth * 0.02, right: screenWidth * 0.02),
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(20),
      //                   color: Colors.grey[200],
      //                 ),
      //                 child: TextFormField(
      //                   controller: _textEditingController,
      //                   decoration: InputDecoration(
      //                     hintText: "Type your message here",
      //                     hintStyle: const TextStyle(
      //                       fontSize: 15,
      //                       fontFamily: fontFamily,
      //                       color: placeholderTextColor,
      //                     ),
      //                     border: InputBorder.none,
      //                     prefixIcon: IconButton(
      //                       onPressed: () {
      //                         showDialog(
      //                           barrierColor: Colors.transparent,
      //                           context: context,
      //                           builder: ((context) {
      //                             return Dialog(
      //                               insetPadding: EdgeInsets.only(
      //                                   top: screenHeight * 0.49),
      //                               elevation: 4,
      //                               shape: RoundedRectangleBorder(
      //                                 borderRadius: BorderRadius.circular(10),
      //                               ),
      //                               child: Container(
      //                                 width: screenWidth * 0.95,
      //                                 height: screenHeight * 0.30,
      //                                 padding:
      //                                     EdgeInsets.all(screenWidth * 0.05),
      //                                 decoration: BoxDecoration(
      //                                   borderRadius: BorderRadius.circular(10),
      //                                   color: Colors.grey[200],
      //                                 ),
      //                                 child: Column(
      //                                   children: [
      //                                     Row(
      //                                       mainAxisAlignment:
      //                                           MainAxisAlignment.spaceBetween,
      //                                       children: [
      //                                         sendDocumentButton(screenWidth,
      //                                             MyFlutterApp.camera_2_fill),
      //                                         sendDocumentButton(screenWidth,
      //                                             MyFlutterApp.live_fill),
      //                                         sendDocumentButton(screenWidth,
      //                                             MyFlutterApp.mic_fill),
      //                                       ],
      //                                     ),
      //                                     SizedBox(height: screenHeight * 0.02),
      //                                     Row(
      //                                       mainAxisAlignment:
      //                                           MainAxisAlignment.spaceBetween,
      //                                       children: [
      //                                         sendDocumentButton(screenWidth,
      //                                             MyFlutterApp.paper),
      //                                       ],
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ),
      //                             );
      //                           }),
      //                         );
      //                       },
      //                       icon: const Icon(
      //                           MyFlutterApp.clarity_attachment_line,
      //                           color: Colors.black),
      //                     ),
      //                     suffixIcon: IconButton(
      //                       icon:
      //                           SvgPicture.asset("asset/icons/send_button.svg"),
      //                       onPressed: () {},
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),

      // groupList(),

      // Padding(
      //   padding: const EdgeInsets.only(top: 25),
      //   child: ListView.builder(
      //     itemCount: inboxMessageData.length,
      //     itemBuilder: (context, index) {
      //       List<String> data = inboxMessageData[index];
      //       return InkWell(
      //         onTap: () {
      //           Navigator.pushNamed(context, MessagePage.routeName);
      //         },
      //         child: SizedBox(
      //           child: Column(
      //             children: [
      //               ListTile(
      //                 leading: CircleAvatar(
      //                   radius: screenWidth * 0.0635,
      //                   child: ClipRRect(
      //                     borderRadius: BorderRadius.circular(50),
      //                     child: Image.asset(data[2]),
      //                   ),
      //                 ),
      //                 title: Padding(
      //                   padding: const EdgeInsets.only(bottom: 5),
      //                   child: Text(
      //                     data[0],
      //                     style: const TextStyle(
      //                       fontFamily: fontFamily,
      //                     ),
      //                   ),
      //                 ),
      //                 subtitle: Text(
      //                   data[1],
      //                   style: const TextStyle(
      //                     fontSize: 13,
      //                     fontFamily: fontFamily,
      //                     color: Colors.black,
      //                   ),
      //                 ),
      //               ),
      //               const Divider(
      //                 thickness: 1,
      //                 color: Color(0xFF979797),
      //                 indent: 20,
      //                 endIndent: 20,
      //               ),
      //             ],
      //           ),
      //         ),
      //       );
      //     },
      //   ),
      // ),
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
