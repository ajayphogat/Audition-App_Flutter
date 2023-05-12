import 'package:first_app/auth/other_services.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/model/job_post_model.dart';
import 'package:first_app/pages/categorySection/descriptionPage.dart';
import 'package:flutter/material.dart';

class ActorGridPage extends StatefulWidget {
  ActorGridPage({Key? key, required this.searchEdit}) : super(key: key);

  static const String routeName = "/categoryGrid-page";

  final TextEditingController searchEdit;

  @override
  State<ActorGridPage> createState() => _ActorGridPageState();
}

class _ActorGridPageState extends State<ActorGridPage> {
  final OtherService otherService = OtherService();
  List<JobModel>? _categoryJobs;

  getCategoryJobs() async {
    _categoryJobs = await otherService.categoryJobs(
        context: context,
        category: "Actor",
        search:
            widget.searchEdit.text.isNotEmpty ? widget.searchEdit.text : "");
    // print("raja");
    // print(_categoryJobs);
    if (this.mounted) {
      setState(() {});
    }
  }

  Future<void> getJobDetails(String jobId) async {
    await otherService.getJobDetails(context: context, jobId: jobId);
  }

  @override
  void initState() {
    getCategoryJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: _categoryJobs == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _categoryJobs!.isEmpty
              ? const Center(
                  child: Text(
                    "No data found",
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.symmetric(
                      // horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.03),
                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 2,
                  //   crossAxisSpacing: 10,
                  //   mainAxisSpacing: 10,
                  //   mainAxisExtent: screenHeight * 0.385,
                  // ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: _categoryJobs!.length,
                  itemBuilder: (context, index) {
                    JobModel data = _categoryJobs![index];
                    print(data.studioName);
                    print(data.jobType);
                    print(data.description);
                    print(data.id);
                    return InkWell(
                      onTap: () async {
                        circularProgressIndicatorNew(context);
                        await getJobDetails(data.id.toString());
                      },
                      child: gridViewContainer(
                          context,
                          screenWidth,
                          screenHeight,
                          data.studioName,
                          data.jobType,
                          data.description,
                          data.images[0],
                          data.id),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(height: screenHeight * 0.02),
                ),
    );
  }
}
