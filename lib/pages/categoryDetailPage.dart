import 'package:first_app/common/data.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/categoryPageGrid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryDetailPage extends StatefulWidget {
  const CategoryDetailPage({Key? key}) : super(key: key);

  static const String routeName = "/categoryDetail-page";

  @override
  State<CategoryDetailPage> createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
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
            height: screenHeight * 0.10,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(MyFlutterApp.bi_arrow_down,
                      color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    width: screenWidth * 0.75,
                    height: screenHeight * 0.045,
                    // padding: const EdgeInsets.only(bottom: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    child: TextFormField(
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
                            onPressed:
                                () {}, //FIXME: functionality of clearing _controller of searchBox
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
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: const Color(0xFF30319D),
            labelColor: const Color(0xFF30319D),
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
            labelPadding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
            labelStyle: const TextStyle(
              fontSize: 16,
            ),
            tabs: [
              Tab(
                text: categoryData[0],
              ),
              Tab(
                text: categoryData[1],
              ),
              Tab(
                text: categoryData[2],
              ),
              Tab(
                text: categoryData[3],
              ),
              Tab(
                text: categoryData[4],
              ),
              Tab(
                text: categoryData[5],
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CategoryGirdPage(),
          CategoryGirdPage(),
          CategoryGirdPage(),
          CategoryGirdPage(),
          CategoryGirdPage(),
          CategoryGirdPage(),
        ],
      ),
    );
  }
}
