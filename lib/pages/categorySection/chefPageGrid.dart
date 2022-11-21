import 'package:first_app/auth/other_services.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/model/job_post_model.dart';
import 'package:first_app/pages/categorySection/descriptionPage.dart';
import 'package:flutter/material.dart';

class ChefGridPage extends StatefulWidget {
  const ChefGridPage({Key? key}) : super(key: key);

  static const String routeName = "/chefGrid-page";

  @override
  State<ChefGridPage> createState() => _ChefGridPageState();
}

class _ChefGridPageState extends State<ChefGridPage> {
  final OtherService otherService = OtherService();
  List<JobModel>? _categoryJobs;

  getCategoryJobs() async {
    _categoryJobs = await otherService.categoryJobs(
      context: context,
      category: "Chef",
    );
    setState(() {});
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
      body: ((_categoryJobs == null) || (_categoryJobs!.isEmpty))
          ? const Center(
              child: CircularProgressIndicator(),
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
                  onTap: () {
                    Navigator.pushNamed(context, DescriptionPage.routeName,
                        arguments: data);
                  },
                  child: gridViewContainer(
                      context,
                      screenWidth,
                      screenHeight,
                      data.studioName,
                      data.jobType,
                      data.description,
                      data.images[0]),
                );
              },
            ),
    );
  }
}
