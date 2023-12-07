import 'package:auto_size_text/auto_size_text.dart';
import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/bottomNavigation/notificationPage.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/inboxPages/inboxPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InboxPage extends StatefulWidget {
  final int? page;
  const InboxPage({
    Key? key,
    this.page,
  }) : super(key: key);

  static const String routeName = "/inbox-page";

  @override
  State<InboxPage> createState() => _InboxState();
}

class _InboxState extends State<InboxPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchEdit;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.page ?? 0);
    _searchEdit = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _searchEdit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      //we have not used basicAppBar() because this inbox has only 2 Tabs and basicAppBar() have 5 by default
      // appBar: AppBar(
      //   toolbarHeight: screenHeight * 0.10,
      //   backgroundColor: Colors.white,
      //   actions: [
      //     Padding(
      //       padding: EdgeInsets.only(top: screenHeight * 0.01),
      //       child: Column(
      //         children: [
      //           SizedBox(
      //             width: screenWidth,
      //             child: Row(
      //               children: [
      //                 IconButton(
      //                   icon: const Icon(MyFlutterApp.bi_arrow_down,
      //                       color: Colors.black),
      //                   onPressed: () {
      //                     Navigator.pushReplacementNamed(
      //                         context, BottomNavigationPage.routeName);
      //                   },
      //                 ),
      //                 // Material(
      //                 //   elevation: 5,
      //                 //   borderRadius: BorderRadius.circular(4),
      //                 //   child: Container(
      //                 //     width: screenWidth * 0.75,
      //                 //     height: screenHeight * 0.045,
      //                 //     padding: const EdgeInsets.only(bottom: 2),
      //                 //     decoration: BoxDecoration(
      //                 //       borderRadius: BorderRadius.circular(4),
      //                 //       color: Colors.white,
      //                 //     ),
      //                 //     child: TextFormField(
      //                 //       controller: _searchEdit,
      //                 //       decoration: InputDecoration(
      //                 //         hintText: "Search here....",
      //                 //         hintStyle: const TextStyle(
      //                 //           fontSize: 15,
      //                 //           fontFamily: fontFamily,
      //                 //           color: placeholderTextColor,
      //                 //         ),
      //                 //         border: InputBorder.none,
      //                 //         prefixIcon: Padding(
      //                 //           padding: const EdgeInsets.all(8.0),
      //                 //           child: SvgPicture.asset(
      //                 //               "asset/images/illustration/bytesize_search.svg"),
      //                 //         ),
      //                 //         suffixIcon: IconButton(
      //                 //             onPressed: () {
      //                 //               _searchEdit.text = "";
      //                 //             },
      //                 //             icon: const Icon(
      //                 //               MyFlutterApp.gridicons_cross,
      //                 //               size: 20,
      //                 //               color: placeholderTextColor,
      //                 //             )),
      //                 //       ),
      //                 //     ),
      //                 //   ),
      //                 // ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      //   bottom: PreferredSize(
      //     preferredSize: Size.fromHeight(screenHeight * 0.01),
      //     child: Container(
      //       alignment: Alignment.centerLeft,
      //       height: screenHeight * 0.035,
      //       child: TabBar(
      //         controller: _tabController,
      //         isScrollable: true,
      //         indicatorColor: thirdColor,
      //         labelColor: thirdColor,
      //         unselectedLabelColor: Colors.black,
      //         indicatorSize: TabBarIndicatorSize.label,
      //         padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
      //         labelPadding: EdgeInsets.symmetric(
      //           horizontal: screenWidth * 0.03,
      //         ),
      //         labelStyle: const TextStyle(
      //           fontFamily: fontFamily,
      //           fontSize: 16,
      //         ),
      //         tabs: [
      //           Tab(
      //             text: inboxData[0],
      //           ),
      //           Tab(
      //             text: inboxData[1],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            // Container(
            //   width: screenWidth,
            //   height: screenHeight * 0.0689,
            //   padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
            //   decoration: const BoxDecoration(
            //     // color: Colors.red,
            //     image: DecorationImage(
            //       image: AssetImage(
            //         "asset/images/uiImages/media_appbar.png",
            //       ),
            //     ),
            //   ),
            //   child: Row(
            //     children: [
            //       Container(
            //         child: Row(
            //           children: [
            //             const Icon(Icons.arrow_back_ios_sharp),
            //             SizedBox(width: screenWidth * 0.04),
            //             const AutoSizeText(
            //               "My Profile",
            //               maxFontSize: 22,
            //               style: TextStyle(
            //                 fontSize: 22,
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.w600,
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //       // Icon(Icons.search)
            //     ],
            //   ),
            // ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.15,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    color: Color(0xff000000).withOpacity(0.13),
                    blurRadius: 2,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Image.asset("asset/images/uiImages/application_appbar.png"),
                  Positioned(
                    top: screenHeight * 0.05,
                    left: screenWidth * 0.05,
                    child: AutoSizeText(
                      "Inbox",
                      maxFontSize: 22,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Positioned(
                  //   left: screenWidth * 0.05,
                  //   child: Row(
                  //     children: const [
                  //       // const Icon(Icons.arrow_back_ios_sharp),
                  //       // SizedBox(width: screenWidth * 0.04),
                  //       AutoSizeText(
                  //         "My Details",
                  //         maxFontSize: 22,
                  //         style: TextStyle(
                  //           fontSize: 22,
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    width: screenWidth,
                    // margin: EdgeInsets.only(left: screenWidth * 0.025),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        SizedBox(height: screenHeight * 0.015),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screenWidth,
              // height: screenHeight * 0.1,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: greenColor,
                labelColor: Colors.black,
                unselectedLabelColor: const Color(0xff898989),
                indicatorSize: TabBarIndicatorSize.label,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                ),
                labelStyle: const TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 16,
                ),
                tabs: [
                  Tab(
                    text: inboxData[0],
                  ),
                  Tab(
                    text: inboxData[1],
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  InboxMessagePage(),
                  // Center(child: CircularProgressIndicator()),
                  NotificationPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
