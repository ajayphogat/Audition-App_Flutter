import 'package:first_app/common/common.dart';
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
  late TextEditingController _searchEdit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _searchEdit = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchEdit.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: basicAppBar(screenHeight, screenWidth, context, _searchEdit,
          _tabController, categoryData),
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
