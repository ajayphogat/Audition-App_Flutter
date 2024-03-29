// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/auth/other_services.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/myProfilePages/audioPlayer.dart';
import 'package:first_app/pages/myProfilePages/myProfilePage.dart';
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
import 'package:blurrycontainer/blurrycontainer.dart';

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

  bool _photo = true;
  bool _video = false;
  bool _audio = false;

  Future<void> switchToStudio() async {
    await authService.switchToStudio(context: context);
  }

  Future<void> deleteMedia(List<String> media, String mediaType) async {
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

    _tabController = TabController(length: 3, vsync: this);
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset("asset/images/uiImages/Home.png"),
                  Column(
                    children: [
                      SizedBox(
                        width: screenWidth,
                        height: screenHeight * 0.75,
                        child: Stack(
                          children: [
                            Container(
                              width: screenWidth,
                              height: screenHeight * 0.56,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(150),
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(150),
                                ),
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
                            Container(
                              width: screenWidth,
                              height: screenHeight * 0.07,
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.025),
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: AssetImage(
                                    "asset/images/uiImages/media_appbar.png",
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(width: screenWidth * 0.04),
                                      const AutoSizeText(
                                        "My Profile",
                                        maxFontSize: 22,
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    icon: const Icon(MyFlutterApp.arrow_down_2,
                                        color: Colors.black),
                                    onPressed: () {
                                      bottomPageUp(
                                        context,
                                        screenHeight,
                                        screenWidth,
                                        user.fname,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: screenWidth * 0.025,
                              child: BlurryContainer(
                                blur: 5,
                                width: screenWidth * 0.95,
                                height: screenHeight * 0.25,
                                elevation: 5,
                                color: Colors.white.withOpacity(
                                  0.7,
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(height: screenHeight * 0.03),
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            AutoSizeText(
                                              user.fname,
                                              maxFontSize: 25,
                                              style: const TextStyle(
                                                fontSize: 25,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(context,
                                                    MyProfilePage.routeName);
                                              },
                                              child: Container(
                                                width: screenWidth * 0.25,
                                                height: screenHeight * 0.03,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: greenColor,
                                                ),
                                                alignment: Alignment.center,
                                                child: AutoSizeText(
                                                  sUser.id.isNotEmpty
                                                      ? "View more"
                                                      : "Edit",
                                                  maxFontSize: 12,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            AutoSizeText(
                                              user.bio.isEmpty
                                                  ? "Empty"
                                                  : user.bio,
                                              maxFontSize: 12,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    const Divider(
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: screenWidth * 0.05),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const AutoSizeText(
                                                "Age",
                                                maxFontSize: 12,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black26,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              AutoSizeText(
                                                user.age.isEmpty
                                                    ? "Empty"
                                                    : "${user.age} years",
                                                maxFontSize: 16,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const AutoSizeText(
                                                "Height",
                                                maxFontSize: 12,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black26,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              AutoSizeText(
                                                user.height.isEmpty
                                                    ? "Empty"
                                                    : user.height,
                                                maxFontSize: 16,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const AutoSizeText(
                                                "Weight",
                                                maxFontSize: 12,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black26,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              AutoSizeText(
                                                user.weight.isEmpty
                                                    ? "Empty"
                                                    : "${user.weight} KG",
                                                maxFontSize: 16,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Container(
                        width: screenWidth,
                        height: screenHeight * 0.06,
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xffFADA43),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                _tabController.animateTo(0);
                                setState(() {
                                  _photo = true;
                                  _video = false;
                                  _audio = false;
                                });
                              },
                              child: Container(
                                width: screenWidth * 0.28,
                                height: screenHeight * 0.04,
                                decoration: BoxDecoration(
                                  color: _photo
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: const AutoSizeText(
                                  "Photos",
                                  maxFontSize: 14,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _tabController.animateTo(1);
                                setState(() {
                                  _video = true;
                                  _photo = false;
                                  _audio = false;
                                });
                              },
                              child: Container(
                                width: screenWidth * 0.28,
                                height: screenHeight * 0.04,
                                decoration: BoxDecoration(
                                  color: _video
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: const AutoSizeText(
                                  "Videos",
                                  maxFontSize: 14,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _tabController.animateTo(2);
                                setState(() {
                                  _photo = false;
                                  _video = false;
                                  _audio = true;
                                });
                              },
                              child: Container(
                                width: screenWidth * 0.28,
                                height: screenHeight * 0.04,
                                decoration: BoxDecoration(
                                  color: _audio
                                      ? Colors.white
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: const AutoSizeText(
                                  "Audio",
                                  maxFontSize: 14,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: screenWidth,
                        height: screenHeight * 0.001,
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.02),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          // color: const Color(0xffFADA43),
                          color: Colors.transparent,
                        ),
                        child: TabBar(
                          controller: _tabController,
                          physics: const NeverScrollableScrollPhysics(),
                          labelStyle: const TextStyle(
                            fontFamily: fontFamily,
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                          ),
                          isScrollable: true,
                          indicatorColor: Colors.transparent,
                          labelColor: Colors.transparent,
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: screenHeight,
                        child: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: _tabController,
                          children: [
                            mediaPhotoSection(
                                screenWidth, screenHeight, user, sUser),
                            // mediaVideoSection(screenWidth, screenHeight, user),
                            mediaVideoSection(
                                screenWidth, screenHeight, user, sUser),
                            mediaAudioSection(
                                screenWidth, screenHeight, user, sUser),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column mediaDraftSection(double screenWidth, double screenHeight) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04, vertical: screenHeight * 0.025),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
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
              Icon(MyFlutterApp.fluent_add_circle_24_filled),
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
                        navigatorPop() => Navigator.pop(context);
                        circularProgressIndicatorNew(context);
                        await BottomMediaUp().pickMedia(
                          context: context,
                          userId: user.id,
                          mediaType: "documents",
                        );
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
                        navigatorPop() => Navigator.pop(context);
                        circularProgressIndicatorNew(context);
                        await BottomMediaUp().pickMedia(
                          context: context,
                          userId: user.id,
                          mediaType: "audios",
                        );
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
                        navigatorPop() => Navigator.pop(context);
                        circularProgressIndicatorNew(context);
                        await BottomMediaUp().pickMedia(
                          context: context,
                          userId: user.id,
                          mediaType: "videos",
                        );
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
              physics: const BouncingScrollPhysics(),
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
              findChildIndexCallback: (key) {
                final valueKey = key as ValueKey;
                final index = user.photos
                    .indexWhere((element) => element == valueKey.value);
                if (index == -1) return null;
                return index;
              },
              itemBuilder: (context, index) => StatefulBuilder(
                builder: (context, setState) => InkWell(
                  key: ValueKey(user.photos[index]),
                  onTap: () async {
                    PageController photoViewController =
                        PageController(initialPage: index);
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
                                height: screenHeight * 0.62,
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
                                        builder: (context, i) =>
                                            PhotoViewGalleryPageOptions(
                                          imageProvider:
                                              CachedNetworkImageProvider(
                                            user.photos[i],
                                          ),
                                          minScale:
                                              PhotoViewComputedScale.contained *
                                                  0.8,
                                          maxScale:
                                              PhotoViewComputedScale.covered *
                                                  2,
                                        ),
                                        pageController: photoViewController,
                                        // onPageChanged: (idx) {
                                        //   setState(() {
                                        //     //FIXME: not working
                                        //     index = idx;
                                        //   });
                                        // },
                                        // pageOptions: [
                                        //   PhotoViewGalleryPageOptions(
                                        //     imageProvider:
                                        //         CachedNetworkImageProvider(
                                        //       user.photos[index],
                                        //     ),
                                        //     minScale: PhotoViewComputedScale
                                        //             .contained *
                                        //         0.8,
                                        //     maxScale:
                                        //         PhotoViewComputedScale.covered *
                                        //             2,
                                        //   ),
                                        // ],
                                        // scrollPhysics:
                                        //     const NeverScrollableScrollPhysics(),
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
                                                        event
                                                            .expectedTotalBytes!
                                                            .toDouble())),
                                          ),
                                        ),
                                      ),
                                      // child: PhotoViewGallery.builder(
                                      //   itemCount: user.photos.length,
                                      //   pageController: photoViewController,
                                      //   onPageChanged: (idx) {
                                      //     // setState(() {
                                      //     //   print("page change");
                                      //     //   index = idx;
                                      //     // });
                                      //   },
                                      //   builder: (context, i) {
                                      //     print("initial page");
                                      //     var aa = index;
                                      //     index = i;
                                      //     i = aa;

                                      //     return PhotoViewGalleryPageOptions(
                                      //       imageProvider:
                                      //           CachedNetworkImageProvider(
                                      //         user.photos[i],
                                      //       ),
                                      //       minScale:
                                      //           PhotoViewComputedScale.contained *
                                      //               0.8,
                                      //       maxScale:
                                      //           PhotoViewComputedScale.covered *
                                      //               2,
                                      //     );
                                      //   },
                                      //   // scrollPhysics:
                                      //   //     const NeverScrollableScrollPhysics(),
                                      //   backgroundDecoration: BoxDecoration(
                                      //     borderRadius: const BorderRadius.all(
                                      //       Radius.circular(20),
                                      //     ),
                                      //     color: Theme.of(context).canvasColor,
                                      //   ),
                                      //   enableRotation: true,
                                      //   loadingBuilder: (context, event) =>
                                      //       Center(
                                      //     child: SizedBox(
                                      //       width: 30.0,
                                      //       height: 30.0,
                                      //       child: CircularProgressIndicator(
                                      //           backgroundColor: Colors.orange,
                                      //           value: event == null
                                      //               ? 0
                                      //               : (event.cumulativeBytesLoaded
                                      //                       .toDouble() /
                                      //                   event.expectedTotalBytes!
                                      //                       .toDouble())),
                                      //     ),
                                      //   ),
                                      // ),
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: user.photos[index],
                        fit: BoxFit.cover,
                      ),
                    ),
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
              itemCount: user.videos.length,
              itemBuilder: (context, index) {
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

  Future<dynamic> bottomPageUp(BuildContext context, double screenHeight,
      double screenWidth, String text) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        builder: (BuildContext contxt) {
          return Container(
            height: screenHeight * 0.15,
            width: screenWidth,
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              color: Color(0xFFFDF5F2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: screenWidth,
                  height: 2,
                  margin: EdgeInsets.only(
                      top: 10,
                      left: (screenWidth / 2.5),
                      right: (screenWidth / 2.5),
                      bottom: screenHeight * 0.045),
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Icon(
                      Icons.check,
                      color: Colors.blue,
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    navPop() => Navigator.pop(context);
                    circularProgressIndicatorNew(context);
                    await switchToStudio();
                    navPop();

                    // Navigator.pushNamedAndRemoveUntil(context,
                    //     BottomNavigationPage.routeName, (route) => false);
                  },
                  child: const Row(
                    children: [
                      Icon(MyFlutterApp.switchuser),
                      SizedBox(width: 15),
                      Text("Switch Account"),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
