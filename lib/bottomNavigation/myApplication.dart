import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/pages/myApplicationPages/myApplicationPage.dart';
import 'package:flutter/material.dart';

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
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
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
      appBar: basicAppBar2(screenHeight, screenWidth, context, _searchEdit,
          _tabController, myApplicationData),
      body: TabBarView(
        controller: _tabController,
        children: const [
          MyApplicationAppliedPage(),
          MyApplicationAppliedPage(),
          MyApplicationAppliedPage(),
          MyApplicationAppliedPage(),
          MyApplicationAppliedPage(),
          MyApplicationAppliedPage(),
        ],
      ),
    );
  }
}
