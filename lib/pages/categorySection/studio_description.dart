import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/auth/other_services.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/provider/job_post_provider.dart';
import 'package:first_app/provider/studio_provider.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../common/common.dart';

class StudioDescriptionPage extends StatefulWidget {
  const StudioDescriptionPage({Key? key}) : super(key: key);

  static const String routeName = "/studioDescription-page";

  @override
  State<StudioDescriptionPage> createState() => _StudioDescriptionPageState();
}

class _StudioDescriptionPageState extends State<StudioDescriptionPage>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  final AuthService authService = AuthService();
  final OtherService otherService = OtherService();

  // void getStudioDetails() async {
  //   await authService.getStudioData(context, widget.studioId);
  // }

  Future<void> followStudio(followId, jobId) async {
    await otherService.followStudio(
        context: context, toFollowId: followId, jobId: jobId);
  }

  Future<void> unFollowStudio(followId, jobId) async {
    await otherService.unfollowStudio(
        context: context, toFollowId: followId, jobId: jobId);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getStudioDetails();
  }

  // final GlobalKey<State> _key = GlobalKey();
  // bool isVisible = false;
  // double x = 0;
  // double y = 2.8;

  int _activePage = 0;
  // double opacityValue = 1.0;

  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _scrollController = ScrollController();
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.userScrollDirection ==
  //         ScrollDirection.reverse) {
  //       setState(() {
  //         y = 1;
  //       });
  //     } else if (_scrollController.position.userScrollDirection ==
  //         ScrollDirection.forward) {
  //       setState(() {
  //         y = 2.8;
  //       });
  //     }

  // var currentContext = _key.currentContext;
  // var renderObject = currentContext?.findRenderObject();
  // var viewport = RenderAbstractViewport.of(renderObject);
  // var offsetToRevealBottom =
  //     viewport!.getOffsetToReveal(renderObject!, 1.0);
  // var offsetToRevealTop = viewport.getOffsetToReveal(renderObject, 0.0);

  // if (_scrollController.position.userScrollDirection ==
  //     ScrollDirection.reverse) {
  //   if (offsetToRevealTop.offset <= _scrollController.position.pixels) {
  //     setState(() {
  //       y = 1;
  //     });
  //   }
  // }
  // if (_scrollController.position.userScrollDirection ==
  //     ScrollDirection.forward) {
  //   if (-(offsetToRevealBottom.offset) >=
  //       _scrollController.position.pixels) {
  //     setState(() {
  //       y = 2.8;
  //     });
  //   }
  // }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var jobData = Provider.of<JobProvider>(context).job;
    bool isBookmarked = jobData.isBookmarked!;
    bool isfollowed = jobData.isFollowed!;
    bool isApplied = jobData.isApplied!;

    return Scaffold(
      appBar: AppBar(
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
                  icon: const Icon(MyFlutterApp.bi_arrow_down,
                      color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: jobData.studio['_id'].isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              // controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: screenHeight * 0.05),
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: screenHeight * 0.15,
                    child: jobData.studio["profilePic"].isEmpty
                        ? Container(
                            width: screenHeight * 0.15,
                            height: screenHeight * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black,
                            ),
                          )
                        : CircleAvatar(
                            radius: screenHeight * 0.145,
                            backgroundImage:
                                NetworkImage(jobData.studio["profilePic"]),
                          ),
                  ),
                  // sUser.profilePic.isEmpty
                  //     ? Container(
                  //         width: screenHeight * 0.30,
                  //         height: screenHeight * 0.30,
                  //         decoration: const BoxDecoration(
                  //           shape: BoxShape.circle,
                  //           color: Colors.black,
                  //         ),
                  //       )
                  //     : CircleAvatar(
                  //         radius: screenHeight * 0.15,
                  //         child: ClipRRect(
                  //           clipBehavior: Clip.hardEdge,
                  //           borderRadius: BorderRadius.circular(100),
                  //           child: sUser.profilePic.isEmpty
                  //               ? Container(
                  //                   color: Colors.black,
                  //                 )
                  //               : Image.network(
                  //                   sUser.profilePic,
                  //                   fit: BoxFit.cover,
                  //                 ),
                  //         ),
                  //       ),

                  SizedBox(height: screenHeight * 0.025),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              jobData.studio["fname"],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              jobData.studio["location"],
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Followers: ${jobData.studio['followers'].length}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            InkWell(
                              onTap: () async {
                                navigatorPop() => Navigator.pop(context);
                                // TODO: bookmark api connect
                                if (isfollowed == true) {
                                  print("completed true");
                                  circularProgressIndicatorNew(context);
                                  await unFollowStudio(
                                      jobData.studio["_id"], jobData.id);

                                  setState(() {
                                    navigatorPop();
                                  });
                                } else {
                                  print("completed false");
                                  circularProgressIndicatorNew(context);
                                  await followStudio(
                                      jobData.studio["_id"], jobData.id);

                                  setState(() {
                                    navigatorPop();
                                  });
                                }
                              },
                              child: Container(
                                width: screenWidth * 0.24,
                                height: screenHeight * 0.03,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: secondoryColor,
                                ),
                                child: Text(
                                  isfollowed ? "Unfollow" : "Follow",
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.03,
                      top: screenHeight * 0.022,
                      right: screenWidth * 0.06,
                      bottom: screenHeight * 0.022,
                    ),
                    child: ReadMoreText(
                      jobData.studio['aboutDesc'],
                      trimMode: TrimMode.Length,
                      trimCollapsedText: "\nREAD MORE",
                      trimExpandedText: "\nSHOW LESS",
                      trimLength: 413,
                      style: const TextStyle(
                        fontSize: 13,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  // const Divider(
                  //   thickness: 1,
                  //   height: 0,
                  //   color: Colors.black,
                  // ),
                  // SizedBox(height: screenHeight * 0.025),
                  // Padding(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  //   child: Row(
                  //     children: const [
                  //       Text(
                  //         "Production Details",
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     left: screenWidth * 0.03,
                  //     top: screenHeight * 0.02,
                  //     right: screenWidth * 0.06,
                  //     bottom: screenHeight * 0.02,
                  //   ),
                  //   child: Text(
                  //     descriptionData[1],
                  //     style: const TextStyle(
                  //       fontSize: 13,
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: screenHeight * 0.025),
                  // const Divider(
                  //   thickness: 1,
                  //   height: 0,
                  //   color: Colors.black,
                  // ),
                  // SizedBox(height: screenHeight * 0.025),
                  // Padding(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  //   child: Row(
                  //     children: const [
                  //       Text(
                  //         "Production Dates & Location",
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: screenHeight * 0.025),
                  // Container(
                  //   width: screenWidth,
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       RichText(
                  //         text: const TextSpan(
                  //           style: TextStyle(
                  //             color: Color(0xFF979797),
                  //             fontSize: 16,
                  //           ),
                  //           children: [
                  //             TextSpan(
                  //               text: "Date: ",
                  //               style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.black,
                  //               ),
                  //             ),
                  //             TextSpan(
                  //               text: "Date of the production",
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       SizedBox(height: screenHeight * 0.015),
                  //       RichText(
                  //         text: const TextSpan(
                  //           style: TextStyle(
                  //             color: Color(0xFF979797),
                  //             fontSize: 16,
                  //           ),
                  //           children: [
                  //             TextSpan(
                  //               text: "Location: ",
                  //               style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.black,
                  //               ),
                  //             ),
                  //             TextSpan(
                  //               text:
                  //                   "4517 Washington Ave.\nManchester, Kentucky 39495",
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(height: screenHeight * 0.025),
                  // const Divider(
                  //   thickness: 1,
                  //   height: 0,
                  //   color: Colors.black,
                  // ),
                  // SizedBox(height: screenHeight * 0.025),
                  // Padding(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  //   child: Row(
                  //     children: const [
                  //       Text(
                  //         "Compensation & Contract Details",
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     left: screenWidth * 0.03,
                  //     right: screenWidth * 0.03,
                  //     top: screenHeight * 0.02,
                  //     bottom: screenHeight * 0.025,
                  //   ),
                  //   child: Text(
                  //     descriptionData[2],
                  //     style: const TextStyle(
                  //       fontSize: 11,
                  //     ),
                  //   ),
                  // ),
                  // const Divider(
                  //   thickness: 1,
                  //   height: 0,
                  //   color: Colors.black,
                  // ),
                  // SizedBox(height: screenHeight * 0.02),
                  // Padding(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  //   child: Row(
                  //     children: const [
                  //       Text(
                  //         "Key Details",
                  //         style: TextStyle(
                  //           fontSize: 16,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(
                  //     left: screenWidth * 0.03,
                  //     right: screenWidth * 0.03,
                  //     top: screenHeight * 0.02,
                  //     bottom: screenHeight * 0.02,
                  //   ),
                  //   child: Text(
                  //     descriptionData[2],
                  //     style: const TextStyle(
                  //       fontSize: 11,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: AnimatedContainer(
      //   duration: const Duration(milliseconds: 300),
      //   width: 150,
      //   height: 100,
      //   alignment: Alignment(x, y),
      //   child: InkWell(
      //     onTap: () {
      //       Navigator.pushNamed(context, AppliedPage.routeName);
      //     },
      //     child: Container(
      //       alignment: Alignment.center,
      //       margin: const EdgeInsets.only(bottom: 5),
      //       width: 150,
      //       height: 40,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(8),
      //         color: const Color(0xFFF9D422),
      //       ),
      //       child: const Text(
      //         "APPLY",
      //         style: TextStyle(fontSize: 16),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}


// var renderObject = currentContext.findRenderObject();
//           var viewport = RenderAbstractViewport.of(renderObject);
//           var offsetToRevealBottom =
//               viewport!.getOffsetToReveal(renderObject!, 1.0);
//           var offsetToRevealTop = viewport.getOffsetToReveal(renderObject, 0.0);

//           print(scroll);

          // if (scroll.metrics.axisDirection == AxisDirection.down) {
          //   print("up");
          //   if (offsetToRevealTop.offset <= scroll.metrics.pixels) {
          //     setState(() {
          //       y = 1;
          //     });
          //   } else {
          //     setState(() {
          //       y = 2.8;
          //     });
          //   }
          // } else if (scroll.metrics.axisDirection == AxisDirection.up) {
          //   print("down");
          //   if (offsetToRevealTop.offset < scroll.metrics.pixels &&
          //       offsetToRevealBottom.offset >= scroll.metrics.pixels) {
          //     setState(() {
          //       y = 2.8;
          //     });
          //   } else {
          //     setState(() {
          //       y = 1;
          //     });
          //   }
          // }