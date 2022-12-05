import 'package:first_app/auth/other_services.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/model/job_post_model.dart';
import 'package:first_app/pages/categorySection/appliedPage.dart';
import 'package:first_app/provider/job_post_provider.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({Key? key}) : super(key: key);

  static const String routeName = "/description-page";

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;

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

  Future<void> applyJob(jobId) async {
    await otherService.applyJob(context: context, jobId: jobId);
  }

  int status = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          y = 1;
        });
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          y = 2.8;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    var jobData = Provider.of<JobProvider>(context).job;
    print(jobData.id);
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
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () async {
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
                          },
                          child: yellowCircleButton(
                              screenHeight,
                              isBookmarked
                                  ? Icons.bookmark_remove
                                  : MyFlutterApp.bookmark)),
                      SizedBox(width: screenWidth * 0.08),
                      yellowCircleButton(screenHeight, MyFlutterApp.share_fill),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.167,
              child: Stack(
                children: [
                  PageView(
                    children: [
                      Image.network(
                        jobData.images[0],
                        fit: BoxFit.contain,
                      ),
                      Image.network(
                        jobData.images[0],
                        fit: BoxFit.contain,
                      ),
                      Image.network(
                        jobData.images[0],
                        fit: BoxFit.contain,
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
                    left: (screenWidth - 39) / 2,
                    child: Row(
                      children: List<Widget>.generate(3, (index) {
                        return Container(
                          margin: const EdgeInsets.all(3),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _activePage == index
                                ? Colors.white
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
            const Divider(
              thickness: 1,
              height: 0,
              color: Colors.black,
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
                        jobData.studioName,
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
                      const Text(
                        "Followers: 2.5K",
                        style: TextStyle(
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
                          height: screenHeight * 0.020,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.black,
                            ),
                            color: isfollowed ? secondoryColor : Colors.white,
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
            SizedBox(height: screenHeight * 0.015),
            Padding(
              padding: EdgeInsets.only(
                left: screenWidth * 0.03,
                top: screenHeight * 0.022,
                right: screenWidth * 0.06,
                bottom: screenHeight * 0.022,
              ),
              child: ReadMoreText(
                descriptionData[0],
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
            const Divider(
              thickness: 1,
              height: 0,
              color: Colors.black,
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
                descriptionData[1],
                style: const TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            const Divider(
              thickness: 1,
              height: 0,
              color: Colors.black,
            ),
            SizedBox(height: screenHeight * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Row(
                children: const [
                  Text(
                    "Production Dates & Location",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            Container(
              width: screenWidth,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Color(0xFF979797),
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: "Date: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: "Date of the production",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Color(0xFF979797),
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: "Location: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              "4517 Washington Ave.\nManchester, Kentucky 39495",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
            const Divider(
              thickness: 1,
              height: 0,
              color: Colors.black,
            ),
            SizedBox(height: screenHeight * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Row(
                children: const [
                  Text(
                    "Compensation & Contract Details",
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
                right: screenWidth * 0.03,
                top: screenHeight * 0.02,
                bottom: screenHeight * 0.025,
              ),
              child: Text(
                descriptionData[2],
                style: const TextStyle(
                  fontSize: 11,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              height: 0,
              color: Colors.black,
            ),
            SizedBox(height: screenHeight * 0.02),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Row(
                children: const [
                  Text(
                    "Key Details",
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
                right: screenWidth * 0.03,
                top: screenHeight * 0.02,
                bottom: screenHeight * 0.02,
              ),
              child: Text(
                descriptionData[2],
                style: const TextStyle(
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 150,
        height: 100,
        alignment: Alignment(x, y),
        child: InkWell(
          onTap: isApplied
              ? () {}
              : () async {
                  navigatorPop() => Navigator.pop(context);
                  navigatorPush() =>
                      Navigator.pushNamed(context, AppliedPage.routeName);
                  circularProgressIndicatorNew(context);
                  // function call
                  await applyJob(jobData.id);
                  navigatorPop();
                  navigatorPush();
                },
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 5),
            width: 150,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFF9D422),
            ),
            child: Text(
              isApplied ? "Applied" : "APPLY",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
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
