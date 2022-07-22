import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/inboxPages/inboxPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({Key? key}) : super(key: key);

  static const String routeName = "/inbox-page";

  @override
  State<InboxPage> createState() => _InboxState();
}

class _InboxState extends State<InboxPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late TextEditingController _searchEdit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchEdit = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
          Container(
            width: screenWidth,
            height: screenHeight * 0.10,
            padding: EdgeInsets.only(
              left: screenWidth * 0.05,
              right: screenWidth * 0.01,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: screenWidth * 0.80,
                    height: screenHeight * 0.045,
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
                          color: Color(0xFF979797),
                        ),
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                              "asset/images/illustration/bytesize_search.svg"),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              _searchEdit.text = "";
                            },
                            icon: const Icon(
                              MyFlutterApp.gridicons_cross,
                              size: 20,
                              color: Color(0xFF979797),
                            )),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: const Icon(MyFlutterApp.filter),
                  color: Colors.black,
                  iconSize: 33,
                ),
              ],
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
              indicatorColor: const Color(0xFF30319D),
              labelColor: const Color(0xFF30319D),
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
              labelPadding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.03,
              ),
              labelStyle: const TextStyle(
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
          InboxMessagePage(),
          InboxMessagePage(),
        ],
      ),
    );
  }
}
