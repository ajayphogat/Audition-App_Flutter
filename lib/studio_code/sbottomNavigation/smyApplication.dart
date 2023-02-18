import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/studio_code/sbottomNavigation/sbottomNavigationBar.dart';
import 'package:first_app/studio_code/scommon/sdata.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sAcceptedJob.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sAppliedJob.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sShortlistedJob.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sallJobs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SMyApplicationPage extends StatefulWidget {
  const SMyApplicationPage({
    Key? key,
  }) : super(key: key);

  static const String routeName = "/smyApplication-page";

  @override
  State<SMyApplicationPage> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<SMyApplicationPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchEdit;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.10,
        backgroundColor: Colors.white,
        actions: [
          SizedBox(
            width: screenWidth,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(MyFlutterApp.bi_arrow_down,
                      color: Colors.black),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, SBottomNavigationPage.routeName);
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
                      controller: _searchEdit,
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
                                onTap: () async {
                                  if (_searchEdit.text.isNotEmpty) {
                                    print("ab");

                                    if (_tabController.previousIndex ==
                                        _tabController.index) {
                                      _tabController
                                          .animateTo(_tabController.length - 1);
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
                                  } else {
                                    _tabController.animateTo(
                                        _tabController.previousIndex);
                                    await Future.delayed(
                                        const Duration(milliseconds: 100));
                                    _tabController.animateTo(
                                        _tabController.previousIndex);
                                  }
                                },
                                child: SvgPicture.asset(
                                  "asset/images/illustration/bytesize_search.svg",
                                  color: placeholderTextColor,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    _searchEdit.text = "";
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
              ],
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.01),
          child: Container(
            height: screenHeight * 0.035,
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
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
                // Tab(
                //   text: data[4],
                // ),
                // Tab(
                //   text: data[5],
                // ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SAllJobsPage(
            searchEdit: _searchEdit,
          ),
          SAppliedJobPage(
            searchEdit: _searchEdit,
          ),
          SAcceptedJobPage(
            searchEdit: _searchEdit,
          ),
          SShortlistedJobPage(
            searchEdit: _searchEdit,
          ),
        ],
      ),
    );
  }
}
