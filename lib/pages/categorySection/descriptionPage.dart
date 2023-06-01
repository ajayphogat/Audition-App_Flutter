import 'package:auto_size_text/auto_size_text.dart';
import 'package:first_app/auth/other_services.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/categorySection/appliedPage.dart';
import 'package:first_app/provider/job_post_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';

import '../../constants.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({Key? key}) : super(key: key);

  static const String routeName = "/description-page";

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage>
    with TickerProviderStateMixin {
  // late ScrollController _scrollController;

  // final GlobalKey<State> _key = GlobalKey();
  bool isVisible = false;
  double x = 0;
  double y = 2.8;

  int _activePage = 0;
  double opacityValue = 1.0;

  final OtherService otherService = OtherService();

  Future<void> followStudio(followId, jobId) async {
    await otherService.followStudio(
        context: context, toFollowId: followId, jobId: jobId);
  }

  Future<void> unFollowStudio(followId, jobId) async {
    await otherService.unfollowStudio(
        context: context, toFollowId: followId, jobId: jobId);
  }

  Future<void> bookmarked(bookmarkedId) async {
    await otherService.bookmarked(context: context, toBookmarkId: bookmarkedId);
  }

  Future<void> undoBookmarked(bookmarkedId) async {
    await otherService.unBookmarked(
        context: context, toBookmarkId: bookmarkedId);
  }

  Future<void> applyJob(jobId, studioUserId) async {
    await otherService.applyJob(
        context: context, jobId: jobId, studioUserId: studioUserId);
  }

  int status = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _scrollController = ScrollController();
    // _scrollController.addListener(() {
    //   if (_scrollController.position.userScrollDirection ==
    //       ScrollDirection.reverse) {
    //     setState(() {
    //       y = 1;
    //     });
    //   } else if (_scrollController.position.userScrollDirection ==
    //       ScrollDirection.forward) {
    //     setState(() {
    //       y = 2.8;
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    // _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var jobData = Provider.of<JobProvider>(context).job;
    print("here is studio id => ${jobData.studio['_id']}");
    bool isBookmarked = jobData.isBookmarked!;
    bool isfollowed = jobData.isFollowed!;
    bool isApplied = jobData.isApplied!;
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: screenHeight * 0.07,
      //   backgroundColor: Colors.white,
      //   actions: [
      //     Container(
      //       width: screenWidth,
      //       margin: EdgeInsets.only(top: screenHeight * 0.02),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           IconButton(
      //             icon: const Icon(MyFlutterApp.bi_arrow_down,
      //                 color: Colors.black),
      //             onPressed: () {
      //               Navigator.pop(context);
      //             },
      //           ),
      //           Container(
      //             margin: const EdgeInsets.only(right: 15),
      //             child: Row(
      //               children: [
      //                 InkWell(
      //                     onTap: () async {
      //                       navigatorPop() => Navigator.pop(context);
      //                       if (isBookmarked == true) {
      //                         circularProgressIndicatorNew(context);
      //                         await undoBookmarked(jobData.id);

      //                         setState(() {
      //                           navigatorPop();
      //                         });
      //                       } else {
      //                         circularProgressIndicatorNew(context);
      //                         await bookmarked(jobData.id);

      //                         setState(() {
      //                           navigatorPop();
      //                         });
      //                       }
      //                     },
      //                     child: yellowCircleButton(
      //                         screenHeight,
      //                         isBookmarked
      //                             ? Icons.bookmark_remove
      //                             : MyFlutterApp.bookmark)),
      //                 SizedBox(width: screenWidth * 0.08),
      //                 InkWell(
      //                   onTap: () async {
      //                     await Share.share(
      //                         "Hey Check this Studio Job: \n\nStudio Name: ${jobData.studioName}\n\nLocation: ${jobData.location}\n\nsDescription: ${jobData.description}");
      //                   },
      //                   child: yellowCircleButton(
      //                       screenHeight, MyFlutterApp.share_fill),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          // controller: _scrollController,
          // physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                width: screenWidth,
                // height: screenHeight * 0.055,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
                decoration: const BoxDecoration(
                  // color: Colors.red,
                  image: DecorationImage(
                      image: AssetImage(
                        "asset/images/uiImages/descriptionbar.png",
                      ),
                      fit: BoxFit.cover),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_sharp,
                      ),
                    ),

                    // SizedBox(width: screenWidth * 0.04),
                    // const AutoSizeText(
                    //   "My Details",
                    //   maxFontSize: 22,
                    //   style: TextStyle(
                    //     fontSize: 22,
                    //     color: Colors.black,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    PopupMenuButton(
                      constraints: BoxConstraints(
                        maxWidth: screenWidth * 0.15,
                      ),
                      onSelected: (value) async {
                        if (value == "bookmark") {
                          navigatorPop() => Navigator.pop(context);
                          if (isBookmarked == true) {
                            circularProgressIndicatorNew(context);
                            await undoBookmarked(jobData.id);

                            setState(() {
                              navigatorPop();
                            });
                          } else {
                            circularProgressIndicatorNew(context);
                            await bookmarked(jobData.id);

                            setState(() {
                              navigatorPop();
                            });
                          }
                        } else {
                          await Share.share(
                              "Hey Check this Studio Job: \n\nStudio Name: ${jobData.studioName}\n\nLocation: ${jobData.location}\n\nsDescription: ${jobData.description}");
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          value: "bookmark",
                          child: Icon(
                            isBookmarked
                                ? Icons.bookmark_remove
                                : MyFlutterApp.bookmark,
                            color: greenColor,
                            size: screenHeight * 0.025,
                          ),
                          // child: yellowCircleButton(
                          //     screenHeight,
                          //     isBookmarked
                          //         ? Icons.bookmark_remove
                          //         : MyFlutterApp.bookmark),
                        ),
                        PopupMenuItem(
                          value: "share",
                          child: Icon(
                            MyFlutterApp.share_fill,
                            color: greenColor,
                            size: screenHeight * 0.025,
                          ),
                          // child: yellowCircleButton(
                          //   screenHeight,
                          //   MyFlutterApp.share_fill,
                          // ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 0.9,
                child: Stack(
                  children: [
                    PageView(
                      children: [
                        Image.network(
                          jobData.images[0],
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          jobData.images[0],
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          jobData.images[0],
                          fit: BoxFit.cover,
                        ),
                      ],
                      onPageChanged: (page) {
                        setState(() {
                          _activePage = page;
                        });
                      },
                    ),
                    Positioned(
                      bottom: 30,
                      left: (screenWidth - ((screenWidth * 0.1) + 10 + 10)) / 2,
                      child: Row(
                        children: List<Widget>.generate(3, (index) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.all(3),
                            width: _activePage == index
                                ? screenWidth * 0.1
                                : screenHeight * 0.008,
                            height: screenHeight * 0.008,
                            decoration: BoxDecoration(
                              borderRadius: _activePage == index
                                  ? BorderRadius.circular(5)
                                  : BorderRadius.circular(100),
                              color: _activePage == index
                                  ? secondoryColor
                                  : Colors.white60,
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: screenHeight * 0.025),
              // SizedBox(height: screenHeight * 0.025),
              Divider(
                thickness: 1,
                height: 0,
                indent: screenWidth * 0.03,
                endIndent: screenWidth * 0.03,
                color: Color(0xff706E72).withOpacity(0.28),
              ),
              SizedBox(height: screenHeight * 0.015),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jobData.studio['fname'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          jobData.location,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        // const SizedBox(height: 3),
                        // Text(
                        //   jobData.socialMedia,
                        //   style: const TextStyle(
                        //     fontSize: 11,
                        //   ),
                        // ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Followers: ${(jobData.studio['followers']).length}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
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
                            width: screenWidth * 0.18,
                            height: screenHeight * 0.025,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.black,
                              ),
                              color: isfollowed ? greenColor : Colors.white,
                            ),
                            child: Text(
                              isfollowed ? "Unfollow" : "Follow",
                              style: TextStyle(
                                fontSize: 12,
                                color: isfollowed ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.03,
                  top: screenHeight * 0.022,
                  right: screenWidth * 0.06,
                  bottom: screenHeight * 0.022,
                ),
                child: ReadMoreText(
                  jobData.description,
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
              Divider(
                thickness: 1,
                height: 0,
                indent: screenWidth * 0.03,
                endIndent: screenWidth * 0.03,
                color: Color(0xff706E72).withOpacity(0.28),
              ),
              SizedBox(height: screenHeight * 0.025),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Row(
                  children: const [
                    Text(
                      "Production Details",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.03,
                  top: screenHeight * 0.02,
                  right: screenWidth * 0.06,
                  bottom: screenHeight * 0.02,
                ),
                child: Text(
                  jobData.productionDetail,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 13,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.025),
              Divider(
                thickness: 1,
                height: 0,
                indent: screenWidth * 0.03,
                endIndent: screenWidth * 0.03,
                color: Color(0xff706E72).withOpacity(0.28),
              ),
              SizedBox(height: screenHeight * 0.025),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Row(
                  children: [
                    Icon(Icons.calendar_month_outlined),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      "Audition date",
                      style: TextStyle(
                        color: Color(0xff706E72),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Row(
                  children: [
                    // Icon(Icons.calendar_month_outlined),
                    // SizedBox(width: screenWidth * 0.02),
                    Text(
                      jobData.date,
                      style: TextStyle(
                        // color: Color(0xff706E72),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.025),
              Divider(
                thickness: 1,
                height: 0,
                indent: screenWidth * 0.03,
                endIndent: screenWidth * 0.03,
                color: Color(0xff706E72).withOpacity(0.28),
              ),
              SizedBox(height: screenHeight * 0.025),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      "Reach us at",
                      style: TextStyle(
                        color: Color(0xff706E72),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                child: Row(
                  children: [
                    // Icon(Icons.calendar_month_outlined),
                    // SizedBox(width: screenWidth * 0.02),
                    Text(
                      jobData.location,
                      style: TextStyle(
                        // color: Color(0xff706E72),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              InkWell(
                onTap: isApplied
                    ? () {}
                    : () async {
                        navigatorPop() => Navigator.pop(context);
                        navigatorPush() =>
                            Navigator.pushNamed(context, AppliedPage.routeName);
                        circularProgressIndicatorNew(context);
                        // function call
                        await applyJob(jobData.id, jobData.studio['_id']);
                        navigatorPop();
                        navigatorPush();
                      },
                child: Container(
                  width: screenWidth,
                  height: screenHeight * 0.05,
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: greenColor,
                  ),
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    isApplied ? "APPLIED" : "APPLY NOW",
                    maxFontSize: 16,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
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
              // Divider(
              //   thickness: 1,
              //   height: 0,
              //   indent: screenWidth * 0.03,
              //   endIndent: screenWidth * 0.03,
              //   color: Color(0xff706E72).withOpacity(0.28),
              // ),
              // SizedBox(height: screenHeight * 0.02),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
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
              //     jobData.keyDetails,
              //     style: const TextStyle(
              //       fontSize: 11,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: AnimatedContainer(
      //   duration: const Duration(milliseconds: 300),
      //   width: 150,
      //   height: 100,
      //   alignment: Alignment(x, y),
      //   child: InkWell(
      //     onTap: isApplied
      //         ? () {}
      //         : () async {
      //             navigatorPop() => Navigator.pop(context);
      //             navigatorPush() =>
      //                 Navigator.pushNamed(context, AppliedPage.routeName);
      //             circularProgressIndicatorNew(context);
      //             // function call
      //             await applyJob(jobData.id, jobData.studio['_id']);
      //             navigatorPop();
      //             navigatorPush();
      //           },
      //     child: Container(
      //       alignment: Alignment.center,
      //       margin: const EdgeInsets.only(bottom: 5),
      //       width: 150,
      //       height: 40,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(8),
      //         color: const Color(0xFFF9D422),
      //       ),
      //       child: Text(
      //         isApplied ? "Applied" : "APPLY",
      //         style: const TextStyle(fontSize: 16),
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
