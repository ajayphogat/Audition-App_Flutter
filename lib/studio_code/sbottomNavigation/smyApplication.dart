import 'package:first_app/studio_code/scommon/scommon.dart';
import 'package:first_app/studio_code/scommon/sdata.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sAcceptedJob.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sAppliedJob.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sShortlistedJob.dart';
import 'package:first_app/studio_code/spages/smyApplicationPages/sallJobs/sallJobs.dart';
import 'package:flutter/material.dart';

class SMyApplicationPage extends StatefulWidget {
  const SMyApplicationPage({Key? key}) : super(key: key);

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
      appBar: basicAppBar(screenHeight, screenWidth, context, _searchEdit,
          _tabController, myApplicationData),
      body: TabBarView(
        controller: _tabController,
        children: const [
          SAllJobsPage(),
          SAppliedJobPage(),
          SAcceptedJobPage(),
          SShortlistedJobPage(),
        ],
      ),
    );
  }
}
