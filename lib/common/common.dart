import 'package:auto_size_text/auto_size_text.dart';
import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/auth/other_services.dart';
import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/categorySection/categoryDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

Widget commonTextField(double screenWidth, double screenHeight,
    BuildContext context, controller, String hintText, icon, bool isPassword) {
  return Container(
    // height: screenHeight * 0.05,
    width: screenWidth,
    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: const Color(0xffDADADA),
      ),
    ),
    child: TextFormField(
      controller: controller,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Please fill this";
        } else {
          return null;
        }
      },
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(
        fontSize: 14,
        fontFamily: fontFamily,
      ),
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontFamily: fontFamily,
          color: placeholderTextColor,
        ),
        errorStyle: const TextStyle(
          fontFamily: fontFamily,
          height: 0.1,
        ),
        border: InputBorder.none,
        prefixIcon: Container(
          width: screenWidth * 0.025,
          height: screenHeight * 0.025,
          padding: const EdgeInsets.all(12),
          child: SvgPicture.asset(
            icon,
            color: const Color(0xff0A4C7E),
          ),
        ),
        // prefixIcon: Padding(
        //   padding: const EdgeInsets.only(left: 20, right: 5, bottom: 0),
        //   child: Icon(icon,
        //       color: Color(0xff0A4C7E),
        //       size: icon == MyFlutterApp.message ? 28 : 35),
        // ),
      ),
    ),
  );
  // return SizedBox(
  //   width: screenWidth - screenWidth * 0.305,
  //   child: Stack(
  //     alignment: AlignmentDirectional.bottomCenter,
  //     children: [
  //       Material(
  //         elevation: 5,
  //         borderRadius: BorderRadius.circular(8),
  //         child: Container(
  //           width: screenWidth - screenWidth * 0.305,
  //           height: screenHeight * 0.06,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(8),
  //             color: placeholderColor,
  //           ),
  //         ),
  //       ),
  //       TextFormField(
  //         controller: controller,
  //         validator: (String? value) {
  //           if (value == null || value.isEmpty) {
  //             return "Please fill this";
  //           } else {
  //             return null;
  //           }
  //         },
  //         style: const TextStyle(
  //           fontSize: 18,
  //           fontFamily: fontFamily,
  //         ),
  //         obscureText: isPassword,
  //         decoration: InputDecoration(
  //           hintText: hintText,
  //           hintStyle: const TextStyle(
  //             fontSize: 18,
  //             fontFamily: fontFamily,
  //             color: placeholderTextColor,
  //           ),
  //           errorStyle: const TextStyle(
  //             fontFamily: fontFamily,
  //             height: 0.1,
  //           ),
  //           border: InputBorder.none,
  //           prefixIcon: Padding(
  //             padding: EdgeInsets.only(
  //                 left: 20,
  //                 right: icon == MyFlutterApp.message ? 12 : 5,
  //                 bottom: 2),
  //             child: Icon(icon,
  //                 color: Colors.black,
  //                 size: icon == MyFlutterApp.message ? 28 : 35),
  //           ),
  //         ),
  //       ),
  //     ],
  //   ),
  // );
}

Widget commonTextField1(double screenWidth, double screenHeight,
    BuildContext context, controller, String hintText, icon, bool isPassword) {
  return Container(
    // height: screenHeight * 0.05,
    width: screenWidth,
    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: const Color(0xffDADADA),
      ),
    ),
    child: TextFormField(
      controller: controller,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Please fill this";
        } else {
          return null;
        }
      },
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(
        fontSize: 14,
        fontFamily: fontFamily,
      ),
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontFamily: fontFamily,
          color: placeholderTextColor,
        ),
        errorStyle: const TextStyle(
          fontFamily: fontFamily,
          height: 0.1,
        ),
        border: InputBorder.none,
        prefixIcon: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: icon == MyFlutterApp.message ? 12 : 5,
            bottom: 2,
          ),
          child: Icon(icon,
              color: Colors.black,
              size: icon == MyFlutterApp.message ? 28 : 35),
        ),
        // prefixIcon: Padding(
        //   padding: const EdgeInsets.only(left: 20, right: 5, bottom: 0),
        //   child: Icon(icon,
        //       color: Color(0xff0A4C7E),
        //       size: icon == MyFlutterApp.message ? 28 : 35),
        // ),
      ),
    ),
  );
  // return SizedBox(
  //   width: screenWidth - screenWidth * 0.305,
  //   child: Stack(
  //     alignment: AlignmentDirectional.bottomCenter,
  //     children: [
  //       Material(
  //         elevation: 5,
  //         borderRadius: BorderRadius.circular(8),
  //         child: Container(
  //           width: screenWidth - screenWidth * 0.305,
  //           height: screenHeight * 0.06,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(8),
  //             color: placeholderColor,
  //           ),
  //         ),
  //       ),
  //       TextFormField(
  //         controller: controller,
  //         validator: (String? value) {
  //           if (value == null || value.isEmpty) {
  //             return "Please fill this";
  //           } else {
  //             return null;
  //           }
  //         },
  //         style: const TextStyle(
  //           fontSize: 18,
  //           fontFamily: fontFamily,
  //         ),
  //         obscureText: isPassword,
  //         decoration: InputDecoration(
  //           hintText: hintText,
  //           hintStyle: const TextStyle(
  //             fontSize: 18,
  //             fontFamily: fontFamily,
  //             color: placeholderTextColor,
  //           ),
  //           errorStyle: const TextStyle(
  //             fontFamily: fontFamily,
  //             height: 0.1,
  //           ),
  //           border: InputBorder.none,
  //           prefixIcon: Padding(
  //             padding: EdgeInsets.only(
  //                 left: 20,
  //                 right: icon == MyFlutterApp.message ? 12 : 5,
  //                 bottom: 2),
  //             child: Icon(icon,
  //                 color: Colors.black,
  //                 size: icon == MyFlutterApp.message ? 28 : 35),
  //           ),
  //         ),
  //       ),
  //     ],
  //   ),
  // );
}

InkWell basicButton(
    BuildContext context, formKey, routeName, String text, password) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.width;
  return InkWell(
    onTap: () {
      if (formKey.currentState!.validate()) {}
    },
    child: Container(
      alignment: Alignment.center,
      width: screenWidth * 0.383,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: secondoryColor,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: fontFamily,
        ),
      ),
    ),
  );
}

InkWell longBasicButton(BuildContext context, routeName, String text) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.width;
  return InkWell(
    onTap: () {
      Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
    },
    child: Container(
      alignment: Alignment.center,
      width: screenWidth * 0.59,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: greenColor,
      ),
      child: AutoSizeText(
        text,
        maxLines: 1,
        maxFontSize: 15,
        minFontSize: 10,
        style: const TextStyle(
          fontFamily: fontFamily,
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Widget textContainer(double screenWidth, double screenHeight, String s1,
    String s2, String s3, List<dynamic> picture, String location) {
  return Padding(
    padding: EdgeInsets.only(right: screenWidth * 0.02),
    child: Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: screenWidth * 0.85,
        height: screenHeight * 0.425,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        // clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth * 0.85,
              height: screenHeight * 0.08,
              decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: screenHeight * 0.02,
                    child: Image.asset(
                      "asset/images/uiImages/studio_profile.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s2,
                        style: const TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        s3,
                        style: const TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 12,
                          color: Color(0xff706E72),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.26,
              width: screenWidth * 0.85,
              child: Image.network(
                picture[0],
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    s1,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: fontFamily,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff706E72),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<void> getJobDetails(String jobId, BuildContext context) async {
  final OtherService otherService = OtherService();
  print("heyyyy");
  await otherService.getJobDetails1(context: context, jobId: jobId);
}

Widget gridViewContainer(
  BuildContext context,
  double screenWidth,
  double screenHeight,
  String s1,
  String s2,
  String s3,
  String s4,
  String jobId,
  String studioId,
  bool isApplied,
  Function updateList,
) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [
        SizedBox(height: screenHeight * 0.02),
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: screenWidth * 0.06,
            backgroundImage: NetworkImage(s4),
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              // s3,
              s3.length > 40 ? s3.substring(0, 40) : s3,
              // data.studioName,
              style: const TextStyle(
                fontFamily: fontFamily,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s1,
                // data.studioName,
                // data.description,
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: fontFamily,
                  color: const Color(0xff131212).withOpacity(0.8),
                ),
              ),
              Text(
                s2,
                // data.location,
                // data.description,
                style: const TextStyle(
                  fontSize: 10,
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff706E72),
                ),
              ),
            ],
          ),
          isThreeLine: true,
        ),
        SizedBox(height: screenHeight * 0.01),
        const Divider(
          thickness: 1,
          height: 0,
          color: Color(0xFF979797),
          // indent: 20,
          // endIndent: 20,
        ),
        SizedBox(height: screenHeight * 0.015),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: screenWidth * 0.25,
              height: screenHeight * 0.035,
              alignment: Alignment.center,
              child: AutoSizeText(
                "View Details",
                maxFontSize: 15,
                minFontSize: 10,
                style: TextStyle(
                  fontSize: 15,
                  color: greenColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.05),
            InkWell(
              onTap: isApplied
                  ? () {}
                  : () async {
                      print("here is studio id => $studioId");
                      circularProgressIndicatorNew(context);
                      OtherService().applyJob(
                        context: context,
                        jobId: jobId,
                        studioUserId: studioId,
                      );
                      await updateList();
                      Navigator.pop(context);
                    },
              child: Container(
                width: screenWidth * 0.3,
                height: screenHeight * 0.035,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: Colors.red,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: greenColor, width: 1.5),
                ),
                child: AutoSizeText(
                  isApplied ? "APPLIED" : "APPLY NOW",
                  maxFontSize: 14,
                  minFontSize: 10,
                  style: TextStyle(
                    fontSize: 14,
                    color: greenColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
          ],
        ),
        SizedBox(height: screenHeight * 0.015),
      ],
    ),
  );
  // return Material(
  //   elevation: 5,
  //   borderRadius: BorderRadius.circular(5),
  //   child: Container(
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(5),
  //       color: Colors.white,
  //     ),
  //     clipBehavior: Clip.antiAlias,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Container(
  //           height: screenHeight * 0.25,
  //           width: screenWidth * 0.50,
  //           decoration: const BoxDecoration(
  //             borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(5), topRight: Radius.circular(5)),
  //           ),
  //           child: Image.network(
  //             s4,
  //             isAntiAlias: true,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         Container(
  //           padding:
  //               EdgeInsets.only(left: 5, right: 5, top: screenHeight * 0.01),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 s3.length > 60 ? s3.substring(0, 60) : s3,
  //                 style: const TextStyle(
  //                   fontSize: 12,
  //                 ),
  //               ),
  //               Divider(
  //                 color: placeholderTextColor,
  //                 height: screenHeight * 0.02,
  //               ),
  //               InkWell(
  //                 onTap: () async {
  //                   circularProgressIndicatorNew(context);
  //                   await getJobDetails(jobId, context);
  //                   // Navigator.push(context, MaterialPageRoute(
  //                   //   builder: (context) {
  //                   //     return StudioDescriptionPage(studioId: studioId);
  //                   //   },
  //                   // ));
  //                 },
  //                 child: Row(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Image.asset("asset/images/uiImages/logo.png"),
  //                       ],
  //                     ),
  //                     SizedBox(width: screenWidth * 0.02),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           s1,
  //                           style: const TextStyle(
  //                             fontFamily: fontFamily,
  //                             fontSize: 12,
  //                           ),
  //                         ),
  //                         Text(
  //                           s2,
  //                           style: const TextStyle(
  //                             fontFamily: fontFamily,
  //                             fontSize: 9,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // );
}

Material gridFollowerView(
  BuildContext context,
  double screenWidth,
  double screenHeight,
  String profilePic,
  String fname,
) {
  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(5),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,
            radius: screenHeight * 0.08,
            child: profilePic.isEmpty
                ? Container(
                    width: screenHeight * 0.15,
                    height: screenHeight * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  )
                : CircleAvatar(
                    radius: screenHeight * 0.075,
                    backgroundImage: NetworkImage(profilePic),
                  ),
          ),
          Divider(
            color: placeholderTextColor,
            height: screenHeight * 0.02,
          ),
          Text(fname,
              style: const TextStyle(
                fontSize: 20,
              )),
        ],
      ),
    ),
  );
}

AppBar basicAppBar(
    double screenHeight,
    double screenWidth,
    BuildContext context,
    TextEditingController searchEdit,
    TabController tabController,
    List<String> data) {
  return AppBar(
    toolbarHeight: screenHeight * 0.13,
    backgroundColor: Colors.white,
    actions: [
      Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.03),
        child: Column(
          children: [
            SizedBox(
              width: screenWidth,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(MyFlutterApp.bi_arrow_down,
                        color: Colors.black),
                    onPressed: () {
                      // print(tabController.index);
                      if (data == categoryData) {
                        Navigator.pop(context);
                      }
                      Navigator.pushReplacementNamed(
                          context, BottomNavigationPage.routeName);
                    },
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      width: screenWidth * 0.75,
                      height: screenHeight * 0.045,
                      padding: const EdgeInsets.only(left: 10, bottom: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: searchEdit,
                        decoration: InputDecoration(
                          hintText: "Search here....",
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            fontFamily: fontFamily,
                            color: placeholderTextColor,
                          ),
                          border: InputBorder.none,
                          suffixIcon: SizedBox(
                            width: screenWidth * 0.20,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    print(tabController.index);
                                    print(searchEdit.text);
                                    if (searchEdit.text.isNotEmpty) {
                                      Navigator.pushNamed(
                                          context, CategoryDetailPage.routeName,
                                          arguments: [
                                            tabController.index,
                                            searchEdit.text
                                          ]);
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    "asset/images/illustration/bytesize_search.svg",
                                    color: placeholderTextColor,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      searchEdit.text = "";
                                    },
                                    icon: const Icon(
                                      MyFlutterApp.gridicons_cross,
                                      size: 20,
                                      color: placeholderTextColor,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     showDialog(
                  //         context: context,
                  //         builder: (context) {
                  //           return AlertDialog(
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(8),
                  //             ),
                  //             title: Container(
                  //               width: screenWidth * 0.30,
                  //               height: screenHeight * 0.20,
                  //               alignment: Alignment.center,
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(8),
                  //                 color: Colors.white,
                  //               ),
                  //               child: const Text(
                  //                 "Filter area is under construction",
                  //                 textAlign: TextAlign.center,
                  //               ),
                  //             ),
                  //           );
                  //         });
                  //   },
                  //   icon: const Icon(MyFlutterApp.filter),
                  //   color: Colors.black,
                  //   iconSize: 33,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(screenHeight * 0.01),
      child: SizedBox(
        height: screenHeight * 0.035,
        child: TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorColor: thirdColor,
          labelColor: thirdColor,
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
          labelPadding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
          ),
          labelStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
          ),
          tabs: [
            Tab(
              text: data[0],
            ),
            Tab(
              text: data[1],
            ),
            Tab(
              text: data[2],
            ),
            Tab(
              text: data[3],
            ),
            Tab(
              text: data[4],
            ),
            Tab(
              text: data[5],
            ),
            Tab(
              text: data[6],
            ),
            Tab(
              text: data[7],
            ),
            Tab(
              text: data[8],
            ),
          ],
        ),
      ),
    ),
  );
}

AppBar basicAppBarApp(
    double screenHeight,
    double screenWidth,
    BuildContext context,
    TextEditingController searchEdit,
    TabController tabController,
    List<String> data) {
  return AppBar(
    toolbarHeight: screenHeight * 0.13,
    backgroundColor: Colors.white,
    actions: [
      Padding(
        padding: EdgeInsets.only(top: screenHeight * 0.03),
        child: Column(
          children: [
            SizedBox(
              width: screenWidth,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(MyFlutterApp.bi_arrow_down,
                        color: Colors.black),
                    onPressed: () {
                      // print(tabController.index);
                      if (data == categoryData) {
                        Navigator.pop(context);
                      }
                      Navigator.pushReplacementNamed(
                          context, BottomNavigationPage.routeName);
                    },
                  ),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      width: screenWidth * 0.75,
                      height: screenHeight * 0.045,
                      padding: const EdgeInsets.only(left: 10, bottom: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: searchEdit,
                        decoration: InputDecoration(
                          hintText: "Search here....",
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            fontFamily: fontFamily,
                            color: placeholderTextColor,
                          ),
                          border: InputBorder.none,
                          suffixIcon: SizedBox(
                            width: screenWidth * 0.20,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    print(tabController.index);
                                    print(searchEdit.text);
                                    if (searchEdit.text.isNotEmpty) {
                                      Navigator.pushNamed(
                                          context, CategoryDetailPage.routeName,
                                          arguments: [
                                            tabController.index,
                                            searchEdit.text
                                          ]);
                                    }
                                  },
                                  child: SvgPicture.asset(
                                    "asset/images/illustration/bytesize_search.svg",
                                    color: placeholderTextColor,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      searchEdit.text = "";
                                    },
                                    icon: const Icon(
                                      MyFlutterApp.gridicons_cross,
                                      size: 20,
                                      color: placeholderTextColor,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     showDialog(
                  //         context: context,
                  //         builder: (context) {
                  //           return AlertDialog(
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(8),
                  //             ),
                  //             title: Container(
                  //               width: screenWidth * 0.30,
                  //               height: screenHeight * 0.20,
                  //               alignment: Alignment.center,
                  //               decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(8),
                  //                 color: Colors.white,
                  //               ),
                  //               child: const Text(
                  //                 "Filter area is under construction",
                  //                 textAlign: TextAlign.center,
                  //               ),
                  //             ),
                  //           );
                  //         });
                  //   },
                  //   icon: const Icon(MyFlutterApp.filter),
                  //   color: Colors.black,
                  //   iconSize: 33,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(screenHeight * 0.01),
      child: SizedBox(
        height: screenHeight * 0.035,
        child: TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorColor: thirdColor,
          labelColor: thirdColor,
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
          labelPadding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
          ),
          labelStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
          ),
          tabs: [
            Tab(
              text: data[0],
            ),
            Tab(
              text: data[1],
            ),
            Tab(
              text: data[2],
            ),
            Tab(
              text: data[3],
            ),
            Tab(
              text: data[4],
            ),
            // Tab(
            //   text: data[5],
            // ),
          ],
        ),
      ),
    ),
  );
}

AppBar basicAppBar2(
    double screenHeight,
    double screenWidth,
    BuildContext context,
    TextEditingController searchEdit,
    TabController tabController,
    List<String> data) {
  return AppBar(
    toolbarHeight: screenHeight * 0.10,
    backgroundColor: Colors.white,
    actions: [
      Container(
        width: screenWidth,
        height: screenHeight * 0.10,
        padding: EdgeInsets.only(
          left: screenWidth * 0.05,
          right: screenWidth * 0.01,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                width: screenWidth * 0.80,
                height: screenHeight * 0.045,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: searchEdit,
                  decoration: InputDecoration(
                    hintText: "Search here....",
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF979797),
                    ),
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                          "asset/images/illustration/bytesize_search.svg"),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          searchEdit.text = "";
                        },
                        icon: const Icon(
                          MyFlutterApp.gridicons_cross,
                          size: 20,
                          color: Color(0xFF979797),
                        )),
                  ),
                ),
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(MyFlutterApp.filter),
              color: Colors.black,
              iconSize: 33,
            ),
          ],
        ),
      ),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(screenHeight * 0.01),
      child: SizedBox(
        height: screenHeight * 0.035,
        child: TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorColor: const Color(0xFF30319D),
          labelColor: const Color(0xFF30319D),
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
          labelPadding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
          ),
          labelStyle: const TextStyle(
            fontSize: 16,
          ),
          tabs: [
            Tab(
              text: data[0],
            ),
            Tab(
              text: data[1],
            ),
            Tab(
              text: data[2],
            ),
            Tab(
              text: data[3],
            ),
            Tab(
              text: data[4],
            ),
            Tab(
              text: data[5],
            ),
          ],
        ),
      ),
    ),
  );
}

Material basicTextFormField(double screenWidth, double screenHeight,
    TextEditingController controller, String hintText) {
  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      width: screenWidth,
      height: screenHeight * 0.05,
      alignment: Alignment.center,
      padding:
          EdgeInsets.only(left: screenWidth * 0.04, bottom: screenWidth * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: placeholderColor,
      ),
      child: TextFormField(
        controller: controller,
        // validator: (String? value) {
        //   if (value == null || value.isEmpty) {
        //     return "Please fill this";
        //   } else {
        //     return null;
        //   }
        // },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 15,
            color: placeholderTextColor,
          ),
          border: InputBorder.none,
        ),
      ),
    ),
  );
}

Container basicDropDown(double screenHeight, String title, String subTitle) {
  return Container(
    margin: EdgeInsets.only(bottom: screenHeight * 0.03),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: fontFamily,
                fontSize: 18,
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            Text(
              subTitle,
              style: const TextStyle(
                fontFamily: fontFamily,
                color: placeholderTextColor,
              ),
            ),
          ],
        ),
        const Icon(MyFlutterApp.arrow_right_2),
      ],
    ),
  );
}

TextButton appBarTextButton(String text) {
  return TextButton(
    onPressed: () {},
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: fontFamily,
        color: thirdColor,
      ),
    ),
  );
}

TextButton appBarTextButton1(String text, Future<void> Function() onSave,
    BuildContext context, double screenWidth, double screenHeight) {
  void navigatePop() => Navigator.pop(context);
  return TextButton(
    onPressed: () async {
      if (text == "Save") {
        // print(screenHeight);
        circularProgressIndicatorNew(context);
        await onSave();
        navigatePop();
        navigatePop();
      } else {
        navigatePop();
      }
    },
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: fontFamily,
        color: thirdColor,
      ),
    ),
  );
}

Future<dynamic> circularProgressIndicatorNew(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(5),
            clipBehavior: Clip.antiAlias,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: const CircularProgressIndicator(),
            ),
          ),
        );
      });
}

Widget detailsMenu(BuildContext context, double screenWidth,
    double screenHeight, String text, String routeName) {
  return Container(
    margin: const EdgeInsets.only(top: 19, left: 15, right: 15),
    child: Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Container(
          alignment: Alignment.center,
          width: screenWidth,
          height: screenHeight * 0.042,
          padding: const EdgeInsets.only(left: 15, right: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFFDF5F2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontFamily: fontFamily,
                ),
              ),
              const Icon(MyFlutterApp.arrow_right_2),
            ],
          ),
        ),
      ),
    ),
  );
}

AppBar profileAppBar(double screenHeight, double screenWidth,
    BuildContext context, String headline) {
  return AppBar(
    backgroundColor: Colors.white,
    toolbarHeight: screenHeight * 0.105,
    actions: [
      SizedBox(
        width: screenWidth,
        height: screenHeight * 0.08,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                  top: screenHeight * 0.02,
                  bottom: screenHeight * 0.005),
              height: screenHeight * 0.02,
              child: IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  MyFlutterApp.bi_arrow_down,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  appBarTextButton("Cancel"),
                  Text(
                    headline,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: fontFamily,
                      color: Colors.black,
                    ),
                  ),
                  appBarTextButton("Save"),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

AppBar profileAppBar1(double screenHeight, double screenWidth,
    BuildContext context, String headline, Future<void> Function() onSave) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    toolbarHeight: screenHeight * 0.105,
    actions: [
      SizedBox(
        width: screenWidth,
        height: screenHeight * 0.08,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                  top: screenHeight * 0.02,
                  bottom: screenHeight * 0.005),
              height: screenHeight * 0.02,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  appBarTextButton1(
                      "Cancel", onSave, context, screenWidth, screenHeight),
                  Text(
                    headline,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: fontFamily,
                      color: Colors.black,
                    ),
                  ),
                  appBarTextButton1(
                      "Save", onSave, context, screenWidth, screenHeight),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Column newColumn(double screenHeight, double screenWidth, String text1,
    String text2, String buttonText) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AspectRatio(
        aspectRatio: 2,
        child: SvgPicture.asset("asset/images/illustration/innovation.svg"),
      ),
      SizedBox(height: screenHeight * 0.03),
      Text(
        text1,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: fontFamily,
          color: placeholderTextColor,
        ),
      ),
      SizedBox(height: screenHeight * 0.015),
      Text(
        text2,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: fontFamily,
          color: placeholderTextColor,
        ),
      ),
      SizedBox(height: screenHeight * 0.03),
      InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          width: screenWidth * 0.383,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: secondoryColor,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 16, fontFamily: fontFamily),
          ),
        ),
      ),
    ],
  );
}

AppBar descriptionAppBar(
    double screenHeight, double screenWidth, BuildContext context) {
  return AppBar(
    toolbarHeight: screenHeight * 0.07,
    backgroundColor: Colors.white,
    actions: [
      Container(
        width: screenWidth,
        margin: EdgeInsets.only(top: screenHeight * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(MyFlutterApp.bi_arrow_down, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(MyFlutterApp.bookmark, color: Colors.black),
                ),
                IconButton(
                  onPressed: () {},
                  icon:
                      const Icon(MyFlutterApp.share_fill, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Container yellowCircleButton(double screenHeight, IconData icon) {
  return Container(
    width: screenHeight * 0.03,
    height: screenHeight * 0.03,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFFF9D422),
    ),
    child: Icon(
      icon,
      color: Colors.black,
      size: screenHeight * 0.025,
    ),
  );
}

Future<dynamic> newDialogBox(BuildContext context, double screenWidth,
    double screenHeight, String text, String text2, bool a, String routeName) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Container(
          width: screenWidth * 0.50,
          height: screenHeight * 0.30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenWidth * 0.40,
                height: screenWidth * 0.40,
                child: Lottie.asset(
                  "asset/lottie/successfully_done.json",
                  fit: BoxFit.contain,
                ),
              ),
              Text(text),
              InkWell(
                onTap: () {
                  a
                      ? Navigator.pushNamed(context, routeName)
                      : Navigator.pop(context);
                },
                child: Container(
                  width: screenWidth * 0.38,
                  height: screenHeight * 0.047,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: secondoryColor,
                  ),
                  child: Text(
                    text2,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
