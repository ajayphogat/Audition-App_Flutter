import 'dart:convert';

import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/auth/other_services.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/model/job_post_model.dart';
import 'package:first_app/pages/categorySection/categoryDetailPage.dart';
import 'package:first_app/provider/studio_provider.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../customize/my_flutter_app_icons.dart';
import '../pages/categorySection/descriptionPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = "/home-page";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final OtherService otherService = OtherService();
  List<JobModel>? allJobs;

  final TextEditingController _searchEdit = TextEditingController();

  getAllJobs() async {
    allJobs = await otherService.getAllJobs(context: context);
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
    getAllJobs();
    super.initState();
  }

  @override
  void dispose() {
    _searchEdit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SvgPicture.asset(
                          "asset/images/illustration/homePage_top_yellow.svg"),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.05,
                          right: screenWidth * 0.05,
                          top: screenHeight * 0.085,
                          bottom: screenHeight * 0.03),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi, ${user.fname.split(" ")[0]}",
                            style: const TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 35,
                            ),
                          ),
                          const Text(
                            "Welcome.........",
                            style: TextStyle(
                              fontFamily: fontFamily,
                              color: placeholderTextColor,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                              ),
                              child: TextFormField(
                                controller: _searchEdit,
                                textInputAction: TextInputAction.go,
                                decoration: InputDecoration(
                                  hintText: "Search here....",
                                  hintStyle: const TextStyle(
                                    fontSize: 18,
                                    color: placeholderTextColor,
                                  ),
                                  border: InputBorder.none,
                                  suffixIcon: SizedBox(
                                    width: screenWidth * 0.20,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            print(_searchEdit.text);
                                            if (_searchEdit.text.isNotEmpty) {
                                              Navigator.pushNamed(context,
                                                  CategoryDetailPage.routeName,
                                                  arguments: [
                                                    0,
                                                    _searchEdit.text
                                                  ]);
                                            }
                                          },
                                          child: SvgPicture.asset(
                                            "asset/images/illustration/bytesize_search.svg",
                                            color: placeholderTextColor,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              _searchEdit.text = "";
                                            },
                                            icon: const Icon(
                                              MyFlutterApp.gridicons_cross,
                                              size: 20,
                                              color: placeholderTextColor,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Container(
                padding: EdgeInsets.only(left: screenWidth * 0.04),
                width: screenWidth,
                child: const Text(
                  "Popular",
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              SizedBox(
                width: screenWidth,
                height: screenHeight * 0.628,
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.025,
                    vertical: screenHeight * 0.01,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: screenWidth * 0.02,
                    mainAxisSpacing: screenHeight * 0.03,
                    mainAxisExtent: screenHeight * 0.18,
                  ),
                  itemCount: categoryData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, CategoryDetailPage.routeName,
                            arguments: [index, ""]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: placeholderColor,
                        ),
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.01,
                          right: screenWidth * 0.01,
                          top: screenHeight * 0.01,
                        ),
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Image.asset(
                                  "asset/images/categoryImages/${categoryData[index]}.png"),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(categoryData[index]),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              ((allJobs == null) || (allJobs!.isEmpty))
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: screenWidth * 0.04),
                          width: screenWidth,
                          child: const Text(
                            "Recently",
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        seeAllContainer(screenWidth, screenHeight),
                        SizedBox(
                          height: screenHeight * 0.372,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              JobModel job = allJobs![index];
                              return InkWell(
                                onTap: () async {
                                  circularProgressIndicatorNew(context);
                                  await getJobDetails(job.id.toString());
                                  // Navigator.pushNamed(
                                  //     context, DescriptionPage.routeName,
                                  //     arguments: job);
                                },
                                child: textContainer(
                                    screenWidth,
                                    screenHeight,
                                    job.description.substring(0, 21),
                                    job.studioName.length > 25
                                        ? job.studioName.substring(0, 24)
                                        : job.studioName,
                                    job.jobType,
                                    job.images),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.04),
                        Container(
                          padding: EdgeInsets.only(left: screenWidth * 0.04),
                          width: screenWidth,
                          height: screenHeight * 0.035,
                          child: const Text(
                            "More",
                            style: TextStyle(
                              fontSize: 25,
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        seeAllContainer(screenWidth, screenHeight),
                        SizedBox(
                          height: screenHeight * 0.372,
                          child: ListView.builder(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10, bottom: 10),
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              JobModel job = allJobs![
                                  allJobs!.length > 10 ? index + 3 : index];
                              return InkWell(
                                onTap: () async {
                                  circularProgressIndicatorNew(context);
                                  await getJobDetails(job.id.toString());
                                  // Navigator.pushNamed(
                                  //     context, DescriptionPage.routeName,
                                  //     arguments: job);
                                },
                                child: textContainer(
                                    screenWidth,
                                    screenHeight,
                                    job.description.substring(0, 21),
                                    job.studioName.length > 25
                                        ? job.studioName.substring(0, 24)
                                        : job.studioName,
                                    job.jobType,
                                    job.images),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Container seeAllContainer(double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.only(
          right: screenWidth * 0.07, bottom: screenHeight * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, CategoryDetailPage.routeName,
                  arguments: [0, ""]);
            },
            child: const Text(
              "See All",
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: thirdColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget gridContainer(String name) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        width: (MediaQuery.of(context).size.width - 40) / 3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFDF5F2),
        ),
        child: Column(
          children: [
            AspectRatio(
                aspectRatio: 0.89,
                child: Image.asset("asset/images/categoryImages/$name.png")),
            const SizedBox(height: 5),
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: fontFamily,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
