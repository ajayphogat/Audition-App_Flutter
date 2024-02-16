import 'dart:io';

import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/provider/studio_provider.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:first_app/utils/bottom_gallary_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MediaVideoPage extends StatefulWidget {
  const MediaVideoPage({super.key});

  @override
  State<MediaVideoPage> createState() => _MediaVideoPageState();
}

class _MediaVideoPageState extends State<MediaVideoPage> {
  final AuthService authService = AuthService();
  List<String?> videoThumbnailList = [];

  Future<void> deletePhoto(String media) async {
    await authService.deleteMedia(
        context: context, media: media, mediaType: "photos");
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    var user = Provider.of<UserProvider>(context).user;
    var sUser = Provider.of<StudioProvider>(context).user;
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04, vertical: screenHeight * 0.025),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon(
                      MyFlutterApp.live_fill,
                      color: placeholderTextColor,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "3 Videos",
                      style: TextStyle(
                        color: placeholderTextColor,
                        fontFamily: fontFamily,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    // BottomMediaUp().showPickerMedia(context, user.id, "videos");
                    navigatorPop() => Navigator.pop(context);
                    circularProgressIndicatorNew(context);
                    // videoThumbnailList = [];
                    await BottomMediaUp().pickMedia(
                      context: context,
                      userId: user.id,
                      mediaType: "videos",
                    );
                    // setState(() {});
                    // await generateThumbnail1(user.videos);
                    navigatorPop();
                  },
                  child: const Icon(MyFlutterApp.fluent_add_circle_24_filled),
                ),
              ],
            ),
          ),
          emptyVideosContainer(screenWidth, screenHeight, user, "videos"),
        ],
      ),
    );
  }

  Container emptyVideosContainer(
      double screenWidth, double screenHeight, user, String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      height: screenHeight * 0.52,
      child: user.videos.isEmpty
          ? Container(
              height: screenHeight * 0.52,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "asset/images/illustration/mediaAudio.svg",
                    width: screenWidth * 0.40,
                  ),
                  Text(
                    "You don't have any $text added yet",
                    style: const TextStyle(
                      fontSize: 18,
                      color: placeholderTextColor,
                      fontFamily: fontFamily,
                    ),
                  ),
                ],
              ),
            )
          : videoThumbnailList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(color: greenColor),
                )
              : GridView.builder(
                  gridDelegate: SliverWovenGridDelegate.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    pattern: const [
                      WovenGridTile(1),
                      WovenGridTile(
                        5 / 7,
                        crossAxisRatio: 1,
                        alignment: AlignmentDirectional.centerEnd,
                      ),
                    ],
                  ),
                  itemCount: videoThumbnailList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onLongPress: () {
                        newDialogDelete(context, screenHeight, screenWidth, "");
                      },
                      child: Container(
                        width: screenWidth,
                        height: screenHeight * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.file(
                              File(videoThumbnailList[index]!),
                              fit: BoxFit.cover,
                            ),
                            // Container(
                            //   color: Colors.grey.withOpacity(0.3),
                            // ),
                            Icon(
                              Icons.play_circle_outline,
                              color: Colors.white.withOpacity(0.8),
                              size: 80,
                            )
                          ],
                        ),
                      ),
                    );
                  }),
    );
  }

  Future<dynamic> newDialogDelete(BuildContext context, double screenHeight,
      double screenWidth, String photo) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.only(top: screenHeight * 0.20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: screenWidth * 0.50,
              height: screenHeight * 0.10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () async {
                      navigatorPop() => Navigator.pop(context);
                      circularProgressIndicatorNew(context);
                      await deletePhoto(photo);
                      navigatorPop();
                      navigatorPop();
                    },
                    child: const Text(
                      "Delete",
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: const Text(
                  //     "Edit",
                  //   ),
                  // ),
                  // TextButton(
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: const Text(
                  //     "Change",
                  //   ),
                  // ),
                ],
              ),
            ),
          );
        });
  }
}
