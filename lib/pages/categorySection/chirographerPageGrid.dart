import 'package:first_app/auth/other_services.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/model/job_post_model.dart';
import 'package:first_app/pages/categorySection/descriptionPage.dart';
import 'package:flutter/material.dart';

class ChirographerGridPage extends StatefulWidget {
  const ChirographerGridPage({Key? key, required this.searchEdit})
      : super(key: key);

  static const String routeName = "/chirographerGrid-page";

  final TextEditingController searchEdit;
  @override
  State<ChirographerGridPage> createState() => _ChirographerGridPageState();
}

class _ChirographerGridPageState extends State<ChirographerGridPage> {
  final OtherService otherService = OtherService();
  List<JobModel>? _categoryJobs;

  getCategoryJobs() async {
    _categoryJobs = await otherService.categoryJobs(
      context: context,
      category: "Chirographer",
      search: widget.searchEdit.text.isNotEmpty ? widget.searchEdit.text : "",
    );
    if (this.mounted) {
      setState(() {});
    }
  }

  Future<void> getJobDetails(String jobId) async {
    print("heyyyy");
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
                  child: Text("No data found"),
                )
              : GridView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.03),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: screenHeight * 0.385,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: _categoryJobs!.length,
                  itemBuilder: (context, index) {
                    JobModel data = _categoryJobs![index];
                    return InkWell(
                      onTap: () async {
                        print(data.id);
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
                        data.id,
                      ),
                    );
                  },
                ),
    );
  }
}
