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
    _tabController.index = argument[0];
    _searchEdit.text = argument[1];

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: basicAppBar(screenHeight, screenWidth, context, _searchEdit,
          _tabController, categoryData),
      body: TabBarView(
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
    );
  }
}
