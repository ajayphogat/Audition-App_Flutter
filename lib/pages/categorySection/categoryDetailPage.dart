import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/pages/categorySection/categoryPageGrid.dart';
import 'package:flutter/material.dart';

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
    var page = ModalRoute.of(context)!.settings.arguments as int;
    _tabController.index = page;

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
          CategoryGirdPage(),
          CategoryGirdPage(),
          CategoryGirdPage(),
        ],
      ),
    );
  }
}
