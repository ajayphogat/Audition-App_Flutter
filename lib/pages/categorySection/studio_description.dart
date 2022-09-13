import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/categorySection/appliedPage.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:readmore/readmore.dart';

class StudioDescriptionPage extends StatefulWidget {
  const StudioDescriptionPage({Key? key}) : super(key: key);

  static const String routeName = "/studioDescription-page";

  @override
  State<StudioDescriptionPage> createState() => _StudioDescriptionPageState();
}

class _StudioDescriptionPageState extends State<StudioDescriptionPage>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;

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
                Row(
                  children: [
                    Icon(
                      MyFlutterApp.bookmark,
                      color: Colors.black,
                      size: screenHeight * 0.025,
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Icon(
                      MyFlutterApp.share_fill,
                      color: Colors.black,
                      size: screenHeight * 0.025,
                    ),
                    SizedBox(width: screenWidth * 0.05),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        // controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1.167,
              child: Stack(
                children: [
                  PageView(
                    children: [
                      Image.asset(
                        "asset/images/uiImages/1.png",
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        "asset/images/uiImages/2.png",
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        "asset/images/uiImages/3.png",
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
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       // InkWell(
            //       //   onTap: () {},
            //       //   child: Container(
            //       //     key: _key,
            //       //     alignment: Alignment.center,
            //       //     width: screenWidth * 0.25,
            //       //     height: screenHeight * 0.03,
            //       //     decoration: BoxDecoration(
            //       //       borderRadius: BorderRadius.circular(8),
            //       //       color: const Color(0xFFF9D422),
            //       //     ),
            //       //     child: const Text("APPLY"),
            //       //   ),
            //       // ),
            //       Row(
            //         children: [
            //           yellowCircleButton(screenHeight, MyFlutterApp.bookmark),
            //           SizedBox(width: screenWidth * 0.08),
            //           yellowCircleButton(screenHeight, MyFlutterApp.share_fill),
            //         ],
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
                      const Text(
                        "Studio Name",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      const Text(
                        "Location",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Followers: 2.5K",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Container(
                        width: screenWidth * 0.24,
                        height: screenHeight * 0.03,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: secondoryColor,
                        ),
                        child: const Text(
                          "Follow",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Row(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Container(
            //             width: screenWidth * 0.17,
            //             height: screenWidth * 0.17,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               color: Colors.black,
            //             ),
            //           ),
            //           SizedBox(width: screenWidth * 0.03),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: const [
            //               Text(
            //                 "Wade Warren",
            //                 style: TextStyle(
            //                   fontSize: 16,
            //                 ),
            //               ),
            //               SizedBox(height: 3),
            //               Text(
            //                 "200 Applicants",
            //                 style: TextStyle(
            //                   fontSize: 11,
            //                   color: Color(0xFFF9D422),
            //                 ),
            //               ),
            //               SizedBox(height: 3),
            //               Text(
            //                 "Eleifend neque at",
            //                 style: TextStyle(
            //                   fontSize: 11,
            //                 ),
            //               ),
            //               SizedBox(height: 3),
            //               Text(
            //                 "instagram.com/hdjdm",
            //                 style: TextStyle(
            //                   fontSize: 11,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //       Container(
            //         width: screenWidth * 0.18,
            //         height: screenHeight * 0.020,
            //         alignment: Alignment.center,
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.circular(5),
            //           border: Border.all(
            //             color: Colors.black,
            //           ),
            //         ),
            //         child: const Text(
            //           "Follow",
            //           style: TextStyle(
            //             fontSize: 12,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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