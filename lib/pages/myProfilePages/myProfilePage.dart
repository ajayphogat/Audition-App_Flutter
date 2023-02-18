import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/login/mainPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/appearancePage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/basicInfoPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/creditsPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/membershipPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/skillsPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/socialMediaPage.dart';
import 'package:first_app/pages/myProfilePages/detailPages/subscriptionPage.dart';
import 'package:first_app/pages/myProfilePages/mediaPage.dart';
import 'package:first_app/provider/studio_provider.dart';
import 'package:first_app/utils/bottom_gallary_up.dart';
import 'package:first_app/utils/showSnackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../provider/user_provider.dart';
import 'package:path/path.dart' as p;

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  static const String routeName = "/myProfile-page";

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool short = true;
  File? profilePic;

  late TextEditingController _bioController;
  final AuthService authService = AuthService();

  final _firebaseStorage = FirebaseStorage.instance;

  Future<void> changeBio() async {
    await authService.changeBio(bio: _bioController.text, context: context);
  }

  Future<void> switchToStudio() async {
    await authService.switchToStudio(context: context);
  }

  // Future pickImages(String userId) async {
  //   showsnack(e) => showSnackBar(context, e.toString());
  //   try {
  //     var files = await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       allowMultiple: false,
  //       allowedExtensions: ['jpeg', 'jpg', 'png'],
  //     );
  //     if (files != null && files.files.isNotEmpty) {
  //       profilePic = File(files.files[0].path!);
  //       final fileName = p.basename(profilePic!.path);
  //       try {
  //         //Upload to Firebase
  //         var snapshot = await _firebaseStorage
  //             .ref()
  //             .child('images/$userId/${userId}_${DateTime.now()}_$fileName')
  //             .putFile(profilePic!)
  //             .whenComplete(() {});
  //         var downloadUrl = await snapshot.ref.getDownloadURL();
  //         print(snapshot.state);
  //         print(downloadUrl);
  //         await uploadProfilePic(downloadUrl);
  //       } catch (e) {
  //         showsnack(e);
  //       }
  //     } else {
  //       showsnack("No Image Selected");
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // Future<void> uploadImageGallary(String userId) async {
  //   final imagePicker = ImagePicker();
  //   // File? image;
  //   showsnack(e) => showSnackBar(context, e.toString());

  //   final image = await imagePicker.pickImage(source: ImageSource.gallery);
  //   var file = File(image!.path);

  //   if (image != null) {
  //     final fileName = p.basename(file.path);
  //     // setState(() {
  //     //   profilePic = file;
  //     // });

  //     try {
  //       //Upload to Firebase
  //       var snapshot = await _firebaseStorage
  //           .ref()
  //           .child('images/$userId/${userId}_${DateTime.now()}_$fileName')
  //           .putFile(file);
  //       var downloadUrl = await snapshot.ref.getDownloadURL();
  //       print(downloadUrl);
  //       await uploadProfilePic(downloadUrl);
  //     } catch (e) {
  //       showsnack(e);
  //     }
  //   } else {
  //     showsnack("No Image Selected");
  //   }
  // }

  // Future imgFromCamera(String userId) async {
  //   final imagePicker = ImagePicker();
  //   final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
  //   showsnack(e) => showSnackBar(context, e.toString());

  //   if (pickedFile != null) {
  //     var file = File(pickedFile.path);
  //     final fileName = p.basename(file.path);
  //     setState(() {
  //       profilePic = file;
  //     });

  //     try {
  //       //Upload to Firebase
  //       var snapshot = await _firebaseStorage
  //           .ref()
  //           .child('images/$userId/${userId}_${DateTime.now()}_$fileName')
  //           .putFile(file)
  //           .whenComplete(() {
  //         print("completed");
  //       });
  //       var downloadUrl = await snapshot.ref.getDownloadURL();
  //       print(snapshot.state);
  //       print(downloadUrl);
  //       await uploadProfilePic(downloadUrl);
  //     } catch (e) {
  //       showsnack(e.toString());
  //     }
  //   } else {
  //     showsnack("No image selected");
  //   }
  // }

  // Future<void> uploadProfilePic(String url) async {
  //   await authService.updateProfilePic(context: context, profilePicUrl: url);
  // }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _bioController = TextEditingController();
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
    var studioUser = Provider.of<StudioProvider>(context).user;
    print("profile pic");
    print(user.profilePic.isEmpty);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(children: [
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.55,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                    ),
                    child: user.profilePic.isEmpty
                        ? Container(
                            color: Colors.black,
                          )
                        : Image.network(
                            user.profilePic,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: screenHeight * 0.02,
                  child: InkWell(
                    onTap: () async {
                      BottomMediaUp().showPicker(context, user.id, "audition");
                    },
                    child: const Icon(
                      MyFlutterApp.camera_black,
                      color: placeholderTextColor,
                    ),
                  ),
                )
              ]),
              Container(
                height: screenHeight * 0.03,
                margin: EdgeInsets.only(
                    top: screenHeight * 0.02,
                    left: screenWidth * 0.20,
                    right: screenWidth * 0.20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      child: const Text(
                        "Detail",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, MediaProfilePage.routeName);
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        child: const Text(
                          "Media",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Row(
                      //   children: [
                      //     const Icon(
                      //       Icons.bookmark_border_rounded,
                      //       color: placeholderTextColor,
                      //       size: 30,
                      //     ),
                      //     SizedBox(
                      //       width: screenWidth * 0.01,
                      //     ),
                      //     const Text(
                      //       "Save",
                      //       style: TextStyle(
                      //         color: placeholderTextColor,
                      //         fontSize: 15,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      InkWell(
                        onTap: () async {
                          await Share.share(
                              "Hey Check my Profile details: \n\nName: ${user.fname}\n\nWorking Title: ${user.category}\n\nLocation: ${user.location}\n\nProfileUrl: www.audition-example.com/${user.profileUrl}");
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.file_upload_outlined,
                              color: placeholderTextColor,
                              size: 30,
                            ),
                            SizedBox(
                              width: screenWidth * 0.01,
                            ),
                            const Text(
                              "Share",
                              style: TextStyle(
                                color: placeholderTextColor,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          circularProgressIndicatorNew(context);
                          await switchToStudio();
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              "asset/icons/switchuser.svg",
                              color: placeholderTextColor,
                            ),
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            const Text(
                              "Switch Account",
                              style: TextStyle(
                                color: placeholderTextColor,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          user.fname,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.005),
                        Text(
                          "(${user.category})",
                          style: const TextStyle(
                            color: placeholderTextColor,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        user.bio.isEmpty
                            ? InkWell(
                                onTap: () {
                                  _bioController.text = "";
                                  showBio(context, screenWidth, screenHeight);
                                },
                                child: SizedBox(
                                  height: screenHeight * 0.05,
                                  child: const Text(
                                    "Click to add Bio",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: placeholderTextColor,
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      width: screenWidth,
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                        onTap: () {
                                          _bioController.text = user.bio;
                                          showBio(context, screenWidth,
                                              screenHeight);
                                        },
                                        child: Icon(
                                          MyFlutterApp.edit_black,
                                          size: screenHeight * 0.02,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      user.bio,
                                      style: const TextStyle(
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: short,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          short = !short;
                        });
                      },
                      child: Container(
                        width: screenWidth,
                        height: screenHeight * 0.08,
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              "Read More",
                              style: TextStyle(fontSize: 18),
                            ),
                            Icon(
                              MyFlutterApp.arrow_down_2,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: short
                        ? []
                        : [
                            SizedBox(height: screenHeight * 0.01),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight * 0.02,
                                  left: screenWidth * 0.0636,
                                  right: screenWidth * 0.0636),
                              child: Column(
                                children: [
                                  normalTitles(screenHeight, context,
                                      "Basic Info", BasicInfoPage.routeName),
                                  SizedBox(height: screenHeight * 0.008),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Name", user.fname),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Gender", user.gender),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Location", user.location),
                                  SizedBox(height: screenHeight * 0.005),
                                  // TODO: A way to give profile url
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Profile URL", user.profileUrl),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Working Title", user.category),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.0636,
                                  right: screenWidth * 0.0636),
                              child: Column(
                                children: [
                                  normalTitles(screenHeight, context,
                                      "Appearance", AppearancePage.routeName),
                                  SizedBox(height: screenHeight * 0.008),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Age", user.age),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Height", user.height),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Weight", "${user.weight} kg"),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Body type", user.bodyType),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Hair Color", user.hairColor),
                                  SizedBox(height: screenHeight * 0.005),
                                  smallSubTitles(screenWidth, screenHeight,
                                      "Eye Color", user.eyeColor),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.0636,
                                  right: screenWidth * 0.0636),
                              child: Column(
                                children: [
                                  normalTitles(
                                      screenHeight,
                                      context,
                                      "Website/Social Media",
                                      SocialMediaPage.routeName),
                                  SizedBox(height: screenHeight * 0.008),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: user.socialMedia.map((e) {
                                        return Text(e.toString());
                                      }).toList()
                                      // [

                                      // const Text(
                                      //   "http://clementina.info",
                                      //   style: TextStyle(
                                      //     fontSize: 16,
                                      //     color: Colors.blue,
                                      //   ),
                                      // ),
                                      // SizedBox(height: screenHeight * 0.005),
                                      // const Text(
                                      //   "https://axel.biz",
                                      //   style: TextStyle(
                                      //     fontSize: 16,
                                      //     color: Colors.blue,
                                      //   ),
                                      // ),
                                      // SizedBox(height: screenHeight * 0.005),
                                      // const Text(
                                      //   "https://elliot.name",
                                      //   style: TextStyle(
                                      //     fontSize: 16,
                                      //     color: Colors.blue,
                                      //   ),
                                      // ),
                                      // SizedBox(height: screenHeight * 0.005),
                                      // const Text(
                                      //   "https://esteil.name",
                                      //   style: TextStyle(
                                      //     fontSize: 16,
                                      //     color: Colors.blue,
                                      //   ),
                                      // ),
                                      // ],
                                      ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.0636,
                                  right: screenWidth * 0.0636),
                              child: Column(
                                children: [
                                  normalTitles(
                                      screenHeight,
                                      context,
                                      "Union Membership",
                                      MembershipPage.routeName),
                                  SizedBox(height: screenHeight * 0.008),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: user.unionMembership.map((e) {
                                      return Text(e.toString());
                                    }).toList(),
                                    // children: const [
                                    //   Text("Equity (U.S.)", style: textStyle),
                                    // ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.0636,
                                  right: screenWidth * 0.0636),
                              child: Column(
                                children: [
                                  normalTitles(screenHeight, context, "Skills",
                                      SkillsPage.routeName),
                                  SizedBox(height: screenHeight * 0.008),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: user.skills.map((e) {
                                      return Text(e.toString());
                                    }).toList(),
                                    // children: [
                                    //   const Text("Ability to take direction",
                                    //       style: textStyle),
                                    //   SizedBox(height: screenHeight * 0.005),
                                    //   const Text(
                                    //       "Ability to work as a team and also individually",
                                    //       style: textStyle),
                                    //   SizedBox(height: screenHeight * 0.005),
                                    //   const Text("Reliability",
                                    //       style: textStyle),
                                    //   SizedBox(height: screenHeight * 0.005),
                                    //   const Text("Good time keeping skills",
                                    //       style: textStyle),
                                    // ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.0636,
                                  right: screenWidth * 0.0636),
                              child: Column(
                                children: [
                                  normalTitles(screenHeight, context, "Credits",
                                      CreditsPage.routeName),
                                  SizedBox(height: screenHeight * 0.008),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: user.credits.map((e) {
                                      return Text(e.toString());
                                    }).toList(),
                                  )
                                  // const SizedBox(
                                  //   child: Text(
                                  //       "Add credits from your past performance and jobs in the entertainment industry.",
                                  //       style: textStyle),
                                  // ),
                                ],
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, SubscriptionPage.routeName);
                              },
                              child: simpleArrowColumn(
                                  screenHeight, screenWidth, "Subscription"),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            InkWell(
                              onTap: () async {
                                circularProgressIndicatorNew(context);
                                await AuthService().logoutUser(context);
                              },
                              child: simpleArrowColumn(
                                  screenHeight, screenWidth, "Log Out"),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 10,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  short = !short;
                                });
                              },
                              child: Container(
                                width: screenWidth,
                                height: screenHeight * 0.08,
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Read Less",
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_up_outlined,
                                      size: 28,
                                    ),
                                  ],
                                ),
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

  Future<dynamic> showBio(
      BuildContext context, double screenWidth, double screenHeight) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Container(
            width: screenWidth * 0.80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  width: screenWidth * 0.60,
                  height: screenHeight * 0.30,
                  // color: Colors.yellow[50],
                  decoration: BoxDecoration(
                      color: Colors.yellow[100],
                      border: Border.all(
                        color: secondoryColor,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: TextField(
                    controller: _bioController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none,
                      hintText: "Write your bio here...",
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        navigatePop() => Navigator.pop(context);
                        circularProgressIndicatorNew(context);
                        await changeBio();
                        navigatePop();
                        navigatePop();
                      },
                      child: const Text(
                        "Add",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Column simpleArrowColumn(
      double screenHeight, double screenWidth, String text) {
    return Column(
      children: [
        SizedBox(height: screenHeight * 0.01),
        Padding(
          padding: EdgeInsets.only(
              left: screenWidth * 0.0636, right: screenWidth * 0.0636),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(fontSize: screenHeight * 0.0235),
              ),
              const Icon(MyFlutterApp.arrow_right_2),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
      ],
    );
  }

  Row smallSubTitles(
      double screenWidth, double screenHeight, String text1, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: ((screenWidth - ((screenWidth * 0.0636) * 2)) / 2) -
              screenWidth * 0.0636,
          alignment: Alignment.centerLeft,
          child: Text(text1, style: textStyle),
        ),
        Container(
          width: ((screenWidth - ((screenWidth * 0.0636) * 2)) / 2) +
              screenWidth * 0.0636,
          alignment: Alignment.centerLeft,
          child: Text(text2, style: textStyle),
        ),
      ],
    );
  }

  Row normalTitles(double screenHeight, BuildContext context, String text,
      String routeName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: screenHeight * 0.0235),
        ),
        IconButton(
          icon: Icon(MyFlutterApp.edit_black, size: screenHeight * 0.02),
          onPressed: () {
            Navigator.pushNamed(context, routeName);
          },
        ),
      ],
    );
  }
}
