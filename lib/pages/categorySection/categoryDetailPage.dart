import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/pages/categorySection/actorPageGrid.dart';
import 'package:first_app/pages/categorySection/chefPageGrid.dart';
import 'package:first_app/pages/categorySection/chirographerPageGrid.dart';
import 'package:first_app/pages/categorySection/dancerPageGrid.dart';
import 'package:first_app/pages/categorySection/designerPageGrid.dart';
import 'package:first_app/pages/categorySection/musicianPageGrid.dart';
import 'package:first_app/pages/categorySection/painterPageGrid.dart';
import 'package:first_app/pages/categorySection/singerPageGrid.dart';
import 'package:first_app/pages/categorySection/writerPageGrid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../bottomNavigation/bottomNavigationBar.dart';
import '../../constants.dart';
import '../../customize/my_flutter_app_icons.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({Key? key}) : super(key: key);

  static const String routeName = "/categoryDetail-page";

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchEdit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 9, vsync: this);
    _searchEdit = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchEdit.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> argument =
        ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    if (_searchEdit.text == "") {
      _tabController.index = argument[0];
      _searchEdit.text = argument[1];
    }

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: basicAppBar(screenHeight, screenWidth, context, _searchEdit,
      //     _tabController, categoryDataName),
      // appBar: AppBar(
      //   toolbarHeight: screenHeight * 0.13,
      //   backgroundColor: Colors.white,
      //   actions: [
      //     Padding(
      //       padding: EdgeInsets.only(top: screenHeight * 0.03),
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
      //                     // print(tabController.index);
      //                     if (categoryDataName == categoryData) {
      //                       Navigator.pop(context);
      //                     }
      //                     Navigator.pushReplacementNamed(
      //                         context, BottomNavigationPage.routeName);
      //                   },
      //                 ),
      //                 Material(
      //                   elevation: 5,
      //                   borderRadius: BorderRadius.circular(4),
      //                   child: Container(
      //                     width: screenWidth * 0.75,
      //                     height: screenHeight * 0.045,
      //                     padding: const EdgeInsets.only(left: 10, bottom: 2),
      //                     decoration: BoxDecoration(
      //                       borderRadius: BorderRadius.circular(4),
      //                       color: Colors.white,
      //                     ),
      //                     child: TextFormField(
      //                       controller: _searchEdit,
      //                       decoration: InputDecoration(
      //                         hintText: "Search here....",
      //                         hintStyle: const TextStyle(
      //                           fontSize: 15,
      //                           fontFamily: fontFamily,
      //                           color: placeholderTextColor,
      //                         ),
      //                         border: InputBorder.none,
      //                         suffixIcon: SizedBox(
      //                           width: screenWidth * 0.20,
      //                           child: Row(
      //                             children: [
      //                               InkWell(
      //                                 onTap: () {
      //                                   print(_tabController.index);
      //                                   print(_searchEdit.text);
      //                                   if (_searchEdit.text.isNotEmpty) {
      //                                     Navigator.pushNamed(context,
      //                                         CategoryDetailPage.routeName,
      //                                         arguments: [
      //                                           _tabController.index,
      //                                           _searchEdit.text
      //                                         ]);
      //                                   }
      //                                 },
      //                                 child: SvgPicture.asset(
      //                                   "asset/images/illustration/bytesize_search.svg",
      //                                   color: placeholderTextColor,
      //                                 ),
      //                               ),
      //                               IconButton(
      //                                   onPressed: () {
      //                                     _searchEdit.text = "";
      //                                   },
      //                                   icon: const Icon(
      //                                     MyFlutterApp.gridicons_cross,
      //                                     size: 20,
      //                                     color: placeholderTextColor,
      //                                   )),
      //                             ],
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 // IconButton(
      //                 //   onPressed: () {
      //                 //     showDialog(
      //                 //         context: context,
      //                 //         builder: (context) {
      //                 //           return AlertDialog(
      //                 //             shape: RoundedRectangleBorder(
      //                 //               borderRadius: BorderRadius.circular(8),
      //                 //             ),
      //                 //             title: Container(
      //                 //               width: screenWidth * 0.30,
      //                 //               height: screenHeight * 0.20,
      //                 //               alignment: Alignment.center,
      //                 //               decoration: BoxDecoration(
      //                 //                 borderRadius: BorderRadius.circular(8),
      //                 //                 color: Colors.white,
      //                 //               ),
      //                 //               child: const Text(
      //                 //                 "Filter area is under construction",
      //                 //                 textAlign: TextAlign.center,
      //                 //               ),
      //                 //             ),
      //                 //           );
      //                 //         });
      //                 //   },
      //                 //   icon: const Icon(MyFlutterApp.filter),
      //                 //   color: Colors.black,
      //                 //   iconSize: 33,
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
      //     child: SizedBox(
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
      //             text: categoryDataName[0],
      //           ),
      //           Tab(
      //             text: categoryDataName[1],
      //           ),
      //           Tab(
      //             text: categoryDataName[2],
      //           ),
      //           Tab(
      //             text: categoryDataName[3],
      //           ),
      //           Tab(
      //             text: categoryDataName[4],
      //           ),
      //           Tab(
      //             text: categoryDataName[5],
      //           ),
      //           Tab(
      //             text: categoryDataName[6],
      //           ),
      //           Tab(
      //             text: categoryDataName[7],
      //           ),
      //           Tab(
      //             text: categoryDataName[8],
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
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
                    top: screenHeight * 0.015,
                    child: Container(
                      width: screenWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.025),
                              child: Icon(
                                Icons.arrow_back_ios_sharp,
                                color: Colors.black,
                              ),
                            ),
                          ),
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
                                    // print(_tabController.index);
                                    // print(_searchEdit.text);
                                    // if (_searchEdit.text.isNotEmpty) {
                                    //   Navigator.pushNamed(
                                    //       context, CategoryDetailPage.routeName,
                                    //       arguments: [
                                    //         _tabController.index,
                                    //         _searchEdit.text
                                    //       ]);
                                    // }
                                    if (_searchEdit.text.isNotEmpty) {
                                      print("ab");

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

                                      print("Search");
                                      print(_searchEdit.text);
                                    } else {
                                      _tabController.animateTo(
                                          _tabController.previousIndex);
                                      await Future.delayed(
                                          const Duration(milliseconds: 100));
                                      _tabController.animateTo(
                                          _tabController.previousIndex);
                                    }
                                    // if (_searchEdit.text.isNotEmpty) {
                                    //   print("ab");

                                    //   if (_tabController.previousIndex ==
                                    //       _tabController.index) {
                                    //     _tabController.animateTo(
                                    //         _tabController.length - 1);
                                    //     await Future.delayed(
                                    //         const Duration(milliseconds: 100));
                                    //     _tabController.animateTo(
                                    //         _tabController.previousIndex);
                                    //   } else {
                                    //     _tabController.animateTo(
                                    //         _tabController.previousIndex);
                                    //     await Future.delayed(
                                    //         const Duration(milliseconds: 100));
                                    //     _tabController.animateTo(
                                    //         _tabController.previousIndex);
                                    //   }

                                    //   print("Search");
                                    // } else {
                                    //   _tabController.animateTo(
                                    //       _tabController.previousIndex);
                                    //   await Future.delayed(
                                    //       const Duration(milliseconds: 100));
                                    //   _tabController.animateTo(
                                    //       _tabController.previousIndex);
                                    // }
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

                                    // suffixIcon: SizedBox(
                                    //   width: screenWidth * 0.20,
                                    //   child: Row(
                                    //     children: [
                                    //       InkWell(
                                    //         onTap: () async {
                                    //           if (_searchEdit.text.isNotEmpty) {
                                    //             print("ab");

                                    //             if (_tabController.previousIndex ==
                                    //                 _tabController.index) {
                                    //               _tabController.animateTo(
                                    //                   _tabController.length - 1);
                                    //               await Future.delayed(
                                    //                   const Duration(
                                    //                       milliseconds: 100));
                                    //               _tabController.animateTo(
                                    //                   _tabController.previousIndex);
                                    //             } else {
                                    //               _tabController.animateTo(
                                    //                   _tabController.previousIndex);
                                    //               await Future.delayed(
                                    //                   const Duration(
                                    //                       milliseconds: 100));
                                    //               _tabController.animateTo(
                                    //                   _tabController.previousIndex);
                                    //             }

                                    //             print("Search");
                                    //           } else {
                                    //             _tabController.animateTo(
                                    //                 _tabController.previousIndex);
                                    //             await Future.delayed(const Duration(
                                    //                 milliseconds: 100));
                                    //             _tabController.animateTo(
                                    //                 _tabController.previousIndex);
                                    //           }
                                    //         },
                                    //         child: SvgPicture.asset(
                                    //           "asset/images/illustration/bytesize_search.svg",
                                    //           color: placeholderTextColor,
                                    //         ),
                                    //       ),
                                    //       IconButton(
                                    //           onPressed: () {
                                    //             _searchEdit.text = "";
                                    //           },
                                    //           icon: const Icon(
                                    //             MyFlutterApp.gridicons_cross,
                                    //             size: 20,
                                    //             color: placeholderTextColor,
                                    //           )),
                                    //     ],
                                    //   ),
                                    // ),
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
                    text: categoryDataName[0],
                  ),
                  Tab(
                    text: categoryDataName[1],
                  ),
                  Tab(
                    text: categoryDataName[2],
                  ),
                  Tab(
                    text: categoryDataName[3],
                  ),
                  Tab(
                    text: categoryDataName[4],
                  ),
                  Tab(
                    text: categoryDataName[5],
                  ),
                  Tab(
                    text: categoryDataName[6],
                  ),
                  Tab(
                    text: categoryDataName[7],
                  ),
                  Tab(
                    text: categoryDataName[8],
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
                  ActorGridPage(searchEdit: _searchEdit),
                  DancerGridPage(searchEdit: _searchEdit),
                  WriterGridpage(searchEdit: _searchEdit),
                  MusicianGridPage(searchEdit: _searchEdit),
                  PainterGridPage(searchEdit: _searchEdit),
                  ChirographerGridPage(searchEdit: _searchEdit),
                  SingerGridPage(searchEdit: _searchEdit),
                  DesignerGridPage(searchEdit: _searchEdit),
                  ChefGridPage(searchEdit: _searchEdit),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
