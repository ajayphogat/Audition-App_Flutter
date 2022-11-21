import 'package:first_app/auth/other_services.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/model/job_post_model.dart';
import 'package:first_app/pages/categorySection/appliedPage.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

  bool isfollowed = false;
  bool isBookmarked = false;
  final OtherService otherService = OtherService();

  Future<void> followStudio(followId) async {
    await otherService.followStudio(context: context, toFollowId: followId);
  }

  Future<void> unFollowStudio(followId) async {
    await otherService.unfollowStudio(context: context, toFollowId: followId);
  }

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
  Widget build(BuildContext context) {
    JobModel _argument = ModalRoute.of(context)!.settings.arguments as JobModel;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                        _argument.images[0],
                        fit: BoxFit.contain,
                      ),
                      Image.network(
                        _argument.images[0],
                        fit: BoxFit.contain,
                      ),
                      Image.network(
                        _argument.images[-0],
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
            SizedBox(height: screenHeight * 0.025),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // InkWell(
                  //   onTap: () {},
                  //   child: Container(
                  //     key: _key,
                  //     alignment: Alignment.center,
                  //     width: screenWidth * 0.25,
                  //     height: screenHeight * 0.03,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(8),
                  //       color: const Color(0xFFF9D422),
                  //     ),
                  //     child: const Text("APPLY"),
                  //   ),
                  // ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            isBookmarked = !isBookmarked;
                            setState(() {});
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenWidth * 0.17,
                        height: screenWidth * 0.17,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.03),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _argument.studioName,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "${_argument.applicants.length} Applicants",
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFFF9D422),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _argument.jobType,
                            style: const TextStyle(
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _argument.socialMedia,
                            style: const TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      navigatorPop() => Navigator.pop(context);
                      // TODO: bookmark api connect
                      if (isfollowed == true) {
                        CircularProgressIndicator();
                        await unFollowStudio(_argument.studio);
                        navigatorPop();
                      } else {
                        CircularProgressIndicator();
                        await followStudio(_argument.studio);
                        navigatorPop();
                      }
                      isfollowed = !isfollowed;
                      setState(() {});
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
            ),
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
          onTap: () {
            Navigator.pushNamed(context, AppliedPage.routeName);
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
            child: const Text(
              "APPLY",
              style: TextStyle(fontSize: 16),
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