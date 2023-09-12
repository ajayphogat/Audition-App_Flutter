import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
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
              Stack(
                children: [
                  Image.asset("asset/images/uiImages/Home.png"),
                  Column(
                    children: [
                      SizedBox(
                        // color: Colors.blue,
                        width: screenWidth,
                        height: screenHeight * 0.215,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              child: SizedBox(
                                width: screenWidth,
                                // height: screenHeight * 0.2,
                                child: Image.asset(
                                  "asset/images/uiImages/yellow_color.png",
                                  fit: BoxFit.fitHeight,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth,
                              padding: EdgeInsets.only(
                                  left: screenWidth * 0.05,
                                  right: screenWidth * 0.15,
                                  top: screenHeight * 0.05),
                              // height: screenHeight * 0.2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    "Hi, ${user.fname.split(" ")[0]}!",
                                    style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.02),
                                  const AutoSizeText(
                                    "Unleash your talent and shine on stage with us",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            width: screenWidth,
                            height: screenHeight * 0.045,
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                            ),
                            child: TextFormField(
                              onFieldSubmitted: (String value) {
                                if (value.isNotEmpty) {
                                  Navigator.pushNamed(
                                      context, CategoryDetailPage.routeName,
                                      arguments: [0, value]);
                                }
                              },
                              controller: _searchEdit,
                              textInputAction: TextInputAction.go,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                constraints: BoxConstraints(
                                  maxHeight: screenHeight * 0.045,
                                  maxWidth: screenWidth,
                                ),
                                contentPadding: EdgeInsets.zero,
                                isDense: true,
                                hintText: "Search here",
                                hintStyle: const TextStyle(
                                  fontSize: 18,
                                  color: placeholderTextColor,
                                ),
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.01),
                                  child: Image.asset("asset/icons/search.png",
                                      fit: BoxFit.contain),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),
                      Container(
                        padding: EdgeInsets.only(left: screenWidth * 0.04),
                        width: screenWidth,
                        child: const Text(
                          "Explore opportunities",
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // SizedBox(height: screenHeight * 0.01),
                      SizedBox(
                        width: screenWidth,
                        // color: Colors.blue,
                        height: screenHeight * 0.56,
                        child: GridView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.025,
                            vertical: screenHeight * 0.01,
                          ),
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            // crossAxisSpacing: screenWidth * 0.005,
                            // mainAxisSpacing: screenHeight * 0.03,
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
                              child: Image.asset(
                                categoryData[index],
                              ),
                              // child: Container(
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(10),
                              //     // color: placeholderColor,
                              //   ),
                              //   // padding: EdgeInsets.only(
                              //   //   left: screenWidth * 0.01,
                              //   //   right: screenWidth * 0.01,
                              //   //   top: screenHeight * 0.01,
                              //   // ),
                              //   child: Image.asset("asset/images/uiImages/actor.png",
                              //       fit: BoxFit.contain),
                              // child: Column(
                              //   children: [
                              //     AspectRatio(
                              //       aspectRatio: 1,
                              //       child: Image.asset(
                              //           "asset/images/categoryImages/${categoryData[index]}.png"),
                              //     ),
                              //     SizedBox(height: screenHeight * 0.01),
                              //     Text(categoryData[index]),
                              //   ],
                              // ),
                              // ),
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
                                  // color: Colors.red,
                                  padding:
                                      EdgeInsets.only(left: screenWidth * 0.04),
                                  width: screenWidth,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Recently posted",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontFamily: fontFamily,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      seeAllContainer(
                                          screenWidth, screenHeight),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: screenHeight * 0.55,
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
                                          await getJobDetails(
                                              job.id.toString());
                                          // Navigator.pushNamed(
                                          //     context, DescriptionPage.routeName,
                                          //     arguments: job);
                                        },
                                        child: textContainer(
                                          screenWidth,
                                          screenHeight,
                                          job.description.length > 20
                                              ? job.description.substring(0, 21)
                                              : job.description,
                                          job.studioName.length > 25
                                              ? job.studioName.substring(0, 24)
                                              : job.studioName,
                                          job.jobType,
                                          job.images,
                                          job.location,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.04),
                                // Container(
                                //   padding: EdgeInsets.only(left: screenWidth * 0.04),
                                //   width: screenWidth,
                                //   height: screenHeight * 0.035,
                                //   child: const Text(
                                //     "More",
                                //     style: TextStyle(
                                //       fontSize: 25,
                                //       fontFamily: fontFamily,
                                //       fontWeight: FontWeight.bold,
                                //     ),
                                //   ),
                                // ),
                                // seeAllContainer(screenWidth, screenHeight),
                                // SizedBox(
                                //   height: screenHeight * 0.43,
                                //   child: ListView.separated(
                                //     padding: const EdgeInsets.only(
                                //         left: 10, top: 10, bottom: 10),
                                //     physics: const BouncingScrollPhysics(),
                                //     scrollDirection: Axis.horizontal,
                                //     itemCount: 3,
                                //     itemBuilder: (context, index) {
                                //       JobModel job = allJobs![
                                //           allJobs!.length > 10 ? index + 3 : index];
                                //       return InkWell(
                                //         onTap: () async {
                                //           circularProgressIndicatorNew(context);
                                //           await getJobDetails(job.id.toString());
                                //           // Navigator.pushNamed(
                                //           //     context, DescriptionPage.routeName,
                                //           //     arguments: job);
                                //         },
                                //         child: textContainer(
                                //           screenWidth,
                                //           screenHeight,
                                //           job.description.substring(0, 21),
                                //           job.studioName.length > 25
                                //               ? job.studioName.substring(0, 24)
                                //               : job.studioName,
                                //           job.jobType,
                                //           job.images,
                                //           job.location,
                                //         ),
                                //       );
                                //     },
                                //     separatorBuilder: (context, index) =>
                                //         SizedBox(width: screenWidth * 0.05),
                                //   ),
                                // ),
                              ],
                            ),
                    ],
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
      padding: EdgeInsets.only(right: screenWidth * 0.04),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
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
                fontWeight: FontWeight.w500,
                color: greenColor,
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
