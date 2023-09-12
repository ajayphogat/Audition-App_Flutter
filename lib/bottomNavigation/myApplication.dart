import 'package:auto_size_text/auto_size_text.dart';
import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/myApplicationPages/acceptedJobPage.dart';
import 'package:first_app/pages/myApplicationPages/appliedJobPage.dart';
import 'package:first_app/pages/myApplicationPages/declinedJobPage.dart';
import 'package:first_app/pages/myApplicationPages/bookmarkJobPage.dart';
import 'package:first_app/pages/myApplicationPages/shortlistedJobPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../pages/categorySection/categoryDetailPage.dart';

class MyApplicationPage extends StatefulWidget {
  const MyApplicationPage({Key? key}) : super(key: key);

  static const String routeName = "/myApplication-page";

  @override
  State<MyApplicationPage> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplicationPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchEdit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
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
      body: SafeArea(
        child: Column(
          children: [
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
                    left: screenWidth * 0.05,
                    child: Row(
                      children: const [
                        // const Icon(Icons.arrow_back_ios_sharp),
                        // SizedBox(width: screenWidth * 0.04),
                        AutoSizeText(
                          "My Details",
                          maxFontSize: 22,
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: screenHeight * 0.015,
                    child: Container(
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // InkWell(
                          //   onTap: () {
                          //     Navigator.pop(context);
                          //   },
                          //   child: Padding(
                          //     padding: EdgeInsets.symmetric(
                          //         horizontal: screenWidth * 0.025),
                          //     child: Icon(
                          //       Icons.arrow_back_ios_sharp,
                          //       color: Colors.black,
                          //     ),
                          //   ),
                          // ),
                          const SizedBox(height: 24),
                          SizedBox(height: screenHeight * 0.015),

                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.05),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                width: screenWidth,
                                height: screenHeight * 0.045,
                                // padding: const EdgeInsets.only(left: 0, bottom: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  controller: _searchEdit,
                                  textAlignVertical: TextAlignVertical.center,
                                  onFieldSubmitted: (value) async {
                                    if (_searchEdit.text.isNotEmpty) {
                                      if (_tabController.previousIndex ==
                                          _tabController.index) {
                                        _tabController.animateTo(
                                            _tabController.length - 1);
                                        await Future.delayed(
                                            const Duration(milliseconds: 100));
                                        _tabController.animateTo(
                                            _tabController.previousIndex);
                                      } else {
                                        _tabController.animateTo(
                                            _tabController.previousIndex);
                                        await Future.delayed(
                                            const Duration(milliseconds: 100));
                                        _tabController.animateTo(
                                            _tabController.previousIndex);
                                      }
                                    } else {
                                      _tabController.animateTo(
                                          _tabController.previousIndex);
                                      await Future.delayed(
                                          const Duration(milliseconds: 100));
                                      _tabController.animateTo(
                                          _tabController.previousIndex);
                                    }
                                  },
                                  //   child: SvgPicture.asset(
                                  //     "asset/images/illustration/bytesize_search.svg",
                                  //     color: placeholderTextColor,
                                  //   ),
                                  // ),
                                  // IconButton(
                                  //     onPressed: () {
                                  //       _searchEdit.text = "";
                                  //     },
                                  //     icon: const Icon(
                                  //       MyFlutterApp.gridicons_cross,
                                  //       size: 20,
                                  //       color: placeholderTextColor,
                                  //     ),),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.zero,
                                    hintText: "Search here....",
                                    hintStyle: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: fontFamily,
                                      color: placeholderTextColor,
                                    ),
                                    isDense: true,
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: screenHeight * 0.01),
                                      child: Image.asset(
                                          "asset/icons/search.png",
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.035,
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
                    text: myApplicationData[0],
                  ),
                  Tab(
                    text: myApplicationData[1],
                  ),
                  Tab(
                    text: myApplicationData[2],
                  ),
                  Tab(
                    text: myApplicationData[3],
                  ),
                  Tab(
                    text: myApplicationData[4],
                  ),
                  // Tab(
                  //   text: data[5],
                  // ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  AppliedJobPage(
                    searchEdit: _searchEdit,
                  ),
                  ShortlistedJobPage(
                    searchEdit: _searchEdit,
                  ),
                  AcceptedJobPage(
                    searchEdit: _searchEdit,
                  ),
                  DeclinedJobPage(
                    searchEdit: _searchEdit,
                  ),
                  BookmarkJobPage(
                    searchEdit: _searchEdit,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
