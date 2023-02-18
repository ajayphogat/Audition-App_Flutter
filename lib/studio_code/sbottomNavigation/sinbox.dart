import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/studio_code/sbottomNavigation/sbottomNavigationBar.dart';
import 'package:first_app/studio_code/sbottomNavigation/snotificationPage.dart';
import 'package:first_app/studio_code/scommon/sdata.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:first_app/studio_code/spages/sinboxPages/sinboxPage.dart';
import 'package:flutter/material.dart';

class SInboxPage extends StatefulWidget {
  const SInboxPage({Key? key}) : super(key: key);

  static const String routeName = "/sinbox-page";

  @override
  State<SInboxPage> createState() => _InboxState();
}

class _InboxState extends State<SInboxPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchEdit;
  bool a = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.10,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.01),
            child: SizedBox(
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
                ],
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.01),
          child: Container(
            alignment: Alignment.centerLeft,
            height: screenHeight * 0.035,
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
                  text: inboxData[0],
                ),
                Tab(
                  text: inboxData[1],
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          SInboxMessagePage(),
          // Center(child: CircularProgressIndicator()),
          SNotificationPage(),
        ],
      ),
    );
  }
}
