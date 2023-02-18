import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/auth/other_services.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/myProfilePages/audioPlayer.dart';
import 'package:first_app/pages/myProfilePages/videoPlayer.dart';
import 'package:first_app/provider/studio_provider.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:first_app/utils/bottom_gallary_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

class MediaProfilePage extends StatefulWidget {
  const MediaProfilePage({Key? key}) : super(key: key);

  static const String routeName = "/mediaProfile-page";

  @override
  State<MediaProfilePage> createState() => _MediaProfilePageState();
}

class _MediaProfilePageState extends State<MediaProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  final OtherService otherService = OtherService();
  final AuthService authService = AuthService();

  final _firebaseStorage = FirebaseStorage.instance;

  // getWorkingJobs() async {
  //   _appliedJobs = await otherService.showWorkingJobs(
  //     context: context,
  //     working: "applied",
  //   );
  //   print(_appliedJobs);
  //   if (this.mounted) {
  //     setState(() {});
  //   }
  // }

  // void generateThumbnail(List<String> userVideos) async {
  //   for (var video in userVideos) {
  //     final ab = await VideoThumbnail.thumbnailFile(
  //         video: video,
  //         imageFormat: ImageFormat.JPEG,
  //         thumbnailPath: (await getTemporaryDirectory()).path);
  //     print("ab");
  //     print(ab);
  //     videoThumbnailList.add(ab);
  //   }
  //   setState(() {});
  // }

  // Future<void> generateThumbnail1(List<String> userVideos) async {
  //   if (videoThumbnailList.length > 0) {
  //     videoThumbnailList = [];
  //   }
  //   for (var video in userVideos) {
  //     final ab = await VideoThumbnail.thumbnailFile(
  //         video: video,
  //         imageFormat: ImageFormat.JPEG,
  //         thumbnailPath: (await getTemporaryDirectory()).path);
  //     print("ab");
  //     print(ab);
  //     videoThumbnailList.add(ab);
  //   }
  //   setState(() {});s
  // }

  Future<void> deleteMedia(List<String> media, String mediaType) async {
    print(media);
    if (mediaType == "videos") {
      await _firebaseStorage.refFromURL(media[0]).delete();
      await _firebaseStorage.refFromURL(media[1]).delete();

      await authService.deleteMedia(
          context: context, media: media[0], mediaType: mediaType);
      await authService.deleteMedia(
          context: context, media: media[1], mediaType: "thumbnails");
    } else if (mediaType == "photos") {
      await _firebaseStorage.refFromURL(media[0]).delete().whenComplete(() {});
      await authService.deleteMedia(
          context: context, media: media[0], mediaType: mediaType);
    } else if (mediaType == "audios") {
      await _firebaseStorage.refFromURL(media[0]).delete().whenComplete(() {});
      await authService.deleteMedia(
          context: context, media: media[0], mediaType: mediaType);
    } else if (mediaType == "documents") {
      await _firebaseStorage.refFromURL(media[0]).delete().whenComplete(() {});
      await authService.deleteMedia(
          context: context, media: media[0], mediaType: mediaType);
    }
  }

  @override
  void initState() {
    super.initState();
    // getWorkingJobs();
    // var vUser = Provider.of<UserProvider>(context, listen: false).user;
    // generateThumbnail(vUser.videos);

    _tabController = TabController(length: 4, vsync: this);
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
    var user = Provider.of<UserProvider>(context).user;
    var sUser = Provider.of<StudioProvider>(context).user;
    print(user.fname);
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
                Text(
                  user.fname,
                  style: const TextStyle(fontSize: 20),
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
                          child: user.profilePic.isEmpty
                              ? Container(
                                  color: Colors.black,
                                )
                              : CachedNetworkImage(
                                  imageUrl: user.profilePic,
                                  fit: BoxFit.cover,
                                ),
                          // Image.asset("asset/images/uiImages/actor.jpg",
                          //     fit: BoxFit.cover),
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
                                  child: Text(
                                    user.category,
                                    style: const TextStyle(
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
                                  children: [
                                    Text(
                                      user.applied.length.toString(),
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const Text(
                                      "Applied Jobs",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(
                                      user.following.length.toString(),
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const Text(
                                      "Following",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                // sUser.id.isEmpty
                                //     ?
                                SizedBox(
                                  width: screenWidth * 0.25,
                                  height: screenHeight * 0.025,
                                )
                                // : Container(
                                //     width: screenWidth * 0.25,
                                //     height: screenHeight * 0.025,
                                //     margin: EdgeInsets.only(
                                //         left: screenWidth * 0.05),
                                //     alignment: Alignment.center,
                                //     decoration: BoxDecoration(
                                //       borderRadius:
                                //           BorderRadius.circular(5),
                                //       color: secondoryColor,
                                //     ),
                                //     child: const Text("Follow"),
                                //   ),
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
                //   Tab(
                //     text: profileMediaData[4],
                //   ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight * 0.6,
            child: TabBarView(
              controller: _tabController,
              children: [
                mediaPhotoSection(screenWidth, screenHeight, user, sUser),
                // mediaVideoSection(screenWidth, screenHeight, user),
                mediaVideoSection(screenWidth, screenHeight, user, sUser),
                mediaAudioSection(screenWidth, screenHeight, user, sUser),
                mediaDocumentSection(screenWidth, screenHeight, user, sUser),
                // mediaDraftSection(screenWidth, screenHeight),
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

  Column mediaDocumentSection(
      double screenWidth, double screenHeight, user, sUser) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04, vertical: screenHeight * 0.025),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    MyFlutterApp.live_fill,
                    color: placeholderTextColor,
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${user.documents.length} Document",
                    style: const TextStyle(
                      color: placeholderTextColor,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              sUser.id.isNotEmpty
                  ? Container()
                  : InkWell(
                      onTap: () async {
                        print(user.documents.length);
                        navigatorPop() => Navigator.pop(context);
                        circularProgressIndicatorNew(context);
                        await BottomMediaUp()
                            .pickMedia(context, user.id, "documents");
                        navigatorPop();
                      },
                      child:
                          const Icon(MyFlutterApp.fluent_add_circle_24_filled)),
            ],
          ),
        ),
        emptyDocumentsContainer(screenWidth, screenHeight, user, "documents"),
      ],
    );
  }

  Column mediaAudioSection(
      double screenWidth, double screenHeight, user, sUser) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04, vertical: screenHeight * 0.025),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    MyFlutterApp.live_fill,
                    color: placeholderTextColor,
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${user.audios.length} Audios",
                    style: const TextStyle(
                      color: placeholderTextColor,
                      fontFamily: fontFamily,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              sUser.id.isNotEmpty
                  ? Container()
                  : InkWell(
                      onTap: () async {
                        print(user.audios.length);
                        navigatorPop() => Navigator.pop(context);
                        circularProgressIndicatorNew(context);
                        await BottomMediaUp()
                            .pickMedia(context, user.id, "audios");
                        navigatorPop();
                      },
                      child:
                          const Icon(MyFlutterApp.fluent_add_circle_24_filled)),
            ],
          ),
        ),
        emptyAudiosContainer(screenWidth, screenHeight, user, "audios"),
      ],
    );
  }

  Column mediaVideoSection(
      double screenWidth, double screenHeight, user, sUser) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04, vertical: screenHeight * 0.025),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    MyFlutterApp.live_fill,
                    color: placeholderTextColor,
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${user.videos.length} Videos",
                    style: const TextStyle(
                      color: placeholderTextColor,
                      fontFamily: fontFamily,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              sUser.id.isNotEmpty
                  ? Container()
                  : InkWell(
                      onTap: () async {
                        print(user.videos.length);
                        navigatorPop() => Navigator.pop(context);
                        circularProgressIndicatorNew(context);
                        await BottomMediaUp()
                            .pickMedia(context, user.id, "videos");
                        navigatorPop();
                      },
                      child:
                          const Icon(MyFlutterApp.fluent_add_circle_24_filled),
                    ),
            ],
          ),
        ),
        emptyVideosContainer(screenWidth, screenHeight, user, "videos"),
      ],
    );
  }

  Column mediaPhotoSection(
      double screenWidth, double screenHeight, user, sUser) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04, vertical: screenHeight * 0.025),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    MyFlutterApp.camera_2_fill,
                    color: placeholderTextColor,
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${user.photos.length} Pictures",
                    style: const TextStyle(
                      color: placeholderTextColor,
                      fontFamily: fontFamily,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              sUser.id.isNotEmpty
                  ? Container()
                  : InkWell(
                      onTap: () {
                        print(user.photos.length);
                        BottomMediaUp()
                            .showPickerMedia(context, user.id, "photos");
                      },
                      child: const Icon(
                        MyFlutterApp.fluent_add_circle_24_filled,
                      ),
                    ),
            ],
          ),
        ),
        emptyPhotosContainer(screenWidth, screenHeight, user, "photos", sUser),
      ],
    );
  }

  Container emptyPhotosContainer(
      double screenWidth, double screenHeight, user, String text, sUser) {
    return Container(
      // decoration: const BoxDecoration(
      //     border: Border(
      //   top: BorderSide(color: Colors.grey),
      // )),
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      height: screenHeight * 0.52,
      child: user.photos.isEmpty
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
                    sUser.id.isNotEmpty
                        ? "${user.fname} didn't added $text yet"
                        : "You don't have any $text added yet",
                    style: const TextStyle(
                      fontSize: 18,
                      color: placeholderTextColor,
                      fontFamily: fontFamily,
                    ),
                  ),
                ],
              ),
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
              itemCount: user.photos.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () async {
                  await showDialog(
                      // barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Center(
                          child: Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(5),
                            clipBehavior: Clip.antiAlias,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: screenHeight * 0.60,
                              width: screenWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: screenWidth,
                                    height: screenHeight * 0.50,
                                    child: PhotoViewGallery.builder(
                                      itemCount: user.photos.length,
                                      builder: (context, i) {
                                        // i = index;
                                        // print(i);
                                        // print("i = index");
                                        return PhotoViewGalleryPageOptions(
                                          imageProvider:
                                              CachedNetworkImageProvider(
                                            user.photos[index],
                                          ),
                                          minScale:
                                              PhotoViewComputedScale.contained *
                                                  0.8,
                                          maxScale:
                                              PhotoViewComputedScale.covered *
                                                  2,
                                        );
                                      },
                                      scrollPhysics:
                                          const NeverScrollableScrollPhysics(),
                                      backgroundDecoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        color: Theme.of(context).canvasColor,
                                      ),
                                      enableRotation: true,
                                      loadingBuilder: (context, event) =>
                                          Center(
                                        child: SizedBox(
                                          width: 30.0,
                                          height: 30.0,
                                          child: CircularProgressIndicator(
                                              backgroundColor: Colors.orange,
                                              value: event == null
                                                  ? 0
                                                  : (event.cumulativeBytesLoaded
                                                          .toDouble() /
                                                      event.expectedTotalBytes!
                                                          .toDouble())),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                onLongPress: sUser.id.isNotEmpty
                    ? () {}
                    : () {
                        newDialogDelete(context, screenHeight, screenWidth,
                            [user.photos[index]], "photos");
                      },
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.05,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: user.photos[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
    );
  }

  Container emptyVideosContainer(
      double screenWidth, double screenHeight, user, String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      height: screenHeight * 0.52,
      child: user.videos.isEmpty && user.thumbnailVideo.isEmpty
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
              itemCount: user.thumbnailVideo.length,
              itemBuilder: (context, index) {
                print("thumbnail length");
                print(user.thumbnailVideo.length);
                return InkWell(
                  onLongPress: () {
                    newDialogDelete(
                      context,
                      screenHeight,
                      screenWidth,
                      [user.videos[index], user.thumbnailVideo[index]],
                      "videos",
                    );
                  },
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (context) {
                        return VideoPlayerPage(videoUrl: user.videos[index]);
                      },
                    );
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
                        CachedNetworkImage(
                          imageUrl: user.thumbnailVideo[index],
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

  Container emptyAudiosContainer(
      double screenWidth, double screenHeight, user, String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      height: screenHeight * 0.52,
      child: user.audios.isEmpty
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
              itemCount: user.audios.length,
              itemBuilder: (context, index) => InkWell(
                onLongPress: () {
                  newDialogDelete(
                    context,
                    screenHeight,
                    screenWidth,
                    [user.audios[index]],
                    "audios",
                  );
                },
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AudioPlayerPage(audioUrl: user.audios[index]);
                    },
                  );
                },
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      )),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.audio_file,
                          size: 50,
                          color: Colors.grey,
                        ),
                        Text("Audio ${index + 1}"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Container emptyDocumentsContainer(
      double screenWidth, double screenHeight, user, String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      height: screenHeight * 0.52,
      child: user.documents.isEmpty
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
              itemCount: user.documents.length,
              itemBuilder: (context, index) => InkWell(
                onLongPress: () {
                  newDialogDelete(
                    context,
                    screenHeight,
                    screenWidth,
                    [user.documents[index]],
                    "documents",
                  );
                },
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.grey,
                      )),
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.file_present,
                          size: 50,
                          color: Colors.grey,
                        ),
                        Text("Document ${index + 1}"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Future<dynamic> newDialogDelete(BuildContext context, double screenHeight,
      double screenWidth, List<String> media, String mediaType) {
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
                      await deleteMedia(media, mediaType);
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
