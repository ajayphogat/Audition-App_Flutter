import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MediaProfilePage extends StatefulWidget {
  const MediaProfilePage({Key? key}) : super(key: key);

  static const String routeName = "/mediaProfile-page";

  @override
  State<MediaProfilePage> createState() => _MediaProfilePageState();
}

class _MediaProfilePageState extends State<MediaProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              MyFlutterApp.bi_arrow_down,
              color: Colors.black,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded,
                  color: Colors.black)),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            width: screenWidth,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Leslie Alexander",
                  style: TextStyle(fontSize: 20),
                ),
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.15,
                  margin: EdgeInsets.only(top: screenHeight * 0.03),
                  child: Row(
                    children: [
                      Container(
                        width: screenWidth * 0.25,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset("asset/images/uiImages/actor.jpg",
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.67,
                        height: screenHeight * 0.20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: screenWidth * 0.06),
                                  child: const Text(
                                    "Actor",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: const [
                                    Text(
                                      "12k",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "Followers",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: const [
                                    Text(
                                      "2k",
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      "Following",
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.25,
                                  height: screenHeight * 0.025,
                                  margin:
                                      EdgeInsets.only(left: screenWidth * 0.05),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: secondoryColor,
                                  ),
                                  child: const Text("Follow"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenHeight * 0.03),
            height: screenHeight * 0.04,
            child: TabBar(
              controller: _tabController,
              physics: const BouncingScrollPhysics(),
              labelStyle: const TextStyle(
                fontFamily: fontFamily,
                fontWeight: FontWeight.normal,
                fontSize: 18,
              ),
              isScrollable: true,
              indicatorColor: thirdColor,
              labelColor: thirdColor,
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  text: profileMediaData[0],
                ),
                Tab(
                  text: profileMediaData[1],
                ),
                Tab(
                  text: profileMediaData[2],
                ),
                Tab(
                  text: profileMediaData[3],
                ),
                Tab(
                  text: profileMediaData[4],
                ),
              ],
            ),
          ),
          Container(
            height: screenHeight * 0.6,
            child: TabBarView(
              controller: _tabController,
              children: [
                mediaPhotoSection(screenWidth, screenHeight),
                mediaVideoSection(screenWidth, screenHeight),
                mediaAudioSection(screenWidth, screenHeight),
                mediaDocumentSection(screenWidth, screenHeight),
                mediaDraftSection(screenWidth, screenHeight),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column mediaDraftSection(double screenWidth, double screenHeight) {
    return Column(
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
                    "0 Draft",
                    style: TextStyle(
                      color: placeholderTextColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const Icon(MyFlutterApp.fluent_add_circle_24_filled),
            ],
          ),
        ),
        Container(
          height: screenHeight * 0.52,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "asset/images/illustration/mediaAudio.svg",
                width: screenWidth * 0.40,
              ),
              const Text(
                "You don't have any draft",
                style: TextStyle(fontSize: 18, color: placeholderTextColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column mediaDocumentSection(double screenWidth, double screenHeight) {
    return Column(
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
                    "0 Document",
                    style: TextStyle(
                      color: placeholderTextColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const Icon(MyFlutterApp.fluent_add_circle_24_filled),
            ],
          ),
        ),
        Container(
          height: screenHeight * 0.52,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "asset/images/illustration/mediaAudio.svg",
                width: screenWidth * 0.40,
              ),
              const Text(
                "You don't have any document added yet",
                style: TextStyle(fontSize: 18, color: placeholderTextColor),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column mediaAudioSection(double screenWidth, double screenHeight) {
    return Column(
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
                    "0 Audios",
                    style: TextStyle(
                      color: placeholderTextColor,
                      fontFamily: fontFamily,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const Icon(MyFlutterApp.fluent_add_circle_24_filled),
            ],
          ),
        ),
        Container(
          height: screenHeight * 0.52,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "asset/images/illustration/mediaAudio.svg",
                width: screenWidth * 0.40,
              ),
              const Text(
                "You don't have any audio added yet",
                style: TextStyle(
                  fontSize: 18,
                  color: placeholderTextColor,
                  fontFamily: fontFamily,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column mediaVideoSection(double screenWidth, double screenHeight) {
    return Column(
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
              const Icon(MyFlutterApp.fluent_add_circle_24_filled),
            ],
          ),
        ),
        Container(
          height: screenHeight * 0.52,
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: GridView.builder(
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
            itemCount: imageData.length - 3,
            itemBuilder: (context, index) => InkWell(
              onLongPress: () {
                newDialogDelete(context, screenHeight, screenWidth);
              },
              child: Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        imageData[index],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      color: Colors.white38,
                    ),
                    const Center(
                        child: Icon(
                      Icons.play_circle_outline_sharp,
                      size: 60,
                      color: Colors.white,
                    )),
                  ],
                ),
              ),
            ),
          ),
          // child: GridView.builder(
          //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     mainAxisSpacing: 15,
          //     crossAxisSpacing: 10,
          //     childAspectRatio: 1.66,
          //   ),
          //   itemCount: mediaVideoData.length,
          //   itemBuilder: (context, index) {
          //     return InkWell(
          //       onLongPress: () {
          //         newDialogDelete(context, screenHeight, screenWidth);
          //       },
          //       child: Stack(
          //         children: [
          //           Image.asset(
          //             mediaVideoData[index],
          //           ),
          //           const Center(
          //               child: Icon(
          //             Icons.play_circle_outline_sharp,
          //             size: 60,
          //             color: Colors.white,
          //           )),
          //         ],
          //       ),
          //     );
          //   },
          // ),
        ),
      ],
    );
  }

  Column mediaPhotoSection(double screenWidth, double screenHeight) {
    return Column(
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
                    MyFlutterApp.camera_2_fill,
                    color: placeholderTextColor,
                    size: 15,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "8 Pictures",
                    style: TextStyle(
                      color: placeholderTextColor,
                      fontFamily: fontFamily,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              const Icon(MyFlutterApp.fluent_add_circle_24_filled),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          height: screenHeight * 0.52,
          child: GridView.builder(
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
            itemCount: imageData.length,
            itemBuilder: (context, index) => InkWell(
              onLongPress: () {
                newDialogDelete(context, screenHeight, screenWidth);
              },
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.network(
                  imageData[index],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> newDialogDelete(
      BuildContext context, double screenHeight, double screenWidth) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.only(top: screenHeight * 0.20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              width: screenWidth * 0.80,
              height: screenHeight * 0.18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Delete",
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Edit",
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Change",
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
