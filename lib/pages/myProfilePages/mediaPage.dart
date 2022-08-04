import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        children: [
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
          SizedBox(
            height: screenHeight * 0.45,
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
          height: screenHeight * 0.35,
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
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
          height: screenHeight * 0.35,
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
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
          height: screenHeight * 0.35,
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
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
          height: screenHeight * 0.35,
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 10,
              childAspectRatio: 1.66,
            ),
            itemCount: mediaVideoData.length,
            itemBuilder: (context, index) {
              return InkWell(
                onLongPress: () {
                  newDialogDelete(context, screenHeight, screenWidth);
                },
                child: Stack(
                  children: [
                    Image.asset(
                      mediaVideoData[index],
                    ),
                    const Center(
                        child: Icon(
                      Icons.play_circle_outline_sharp,
                      size: 60,
                      color: Colors.white,
                    )),
                  ],
                ),
              );
            },
          ),
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
          height: screenHeight * 0.35,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.83,
            ),
            itemCount: mediaPicData.length,
            itemBuilder: (context, index) {
              return InkWell(
                onLongPress: () {
                  newDialogDelete(context, screenHeight, screenWidth);
                },
                child: Image.asset(mediaPicData[index]),
              );
            },
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
                      print("Picture Deleted");
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Delete",
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print("Picture Edited");
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Edit",
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      print("Picture Changed");
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
