import 'package:auto_size_text/auto_size_text.dart';
import 'package:first_app/auth/other_services.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/model/job_post_model.dart';
import 'package:first_app/utils/first_char_capital.dart';
import 'package:flutter/material.dart';

class AppliedJobPage extends StatefulWidget {
  const AppliedJobPage({Key? key, required this.searchEdit}) : super(key: key);

  static const String routeName = "/appliedJob-page";

  final TextEditingController searchEdit;

  @override
  State<AppliedJobPage> createState() => _AppliedJobPageState();
}

class _AppliedJobPageState extends State<AppliedJobPage> {
  final OtherService otherService = OtherService();
  List<JobModel1>? _appliedJobs;

  Future<void> getWorkingJobs() async {
    _appliedJobs = await otherService.showWorkingJobs(
      context: context,
      working: "applied",
      search: widget.searchEdit.text.isNotEmpty ? widget.searchEdit.text : "",
    );
    if (this.mounted) {
      setState(() {});
    }
  }

  Future<void> getJobDetails(String jobId) async {
    await otherService.getJobDetails(context: context, jobId: jobId);
  }

  @override
  void initState() {
    getWorkingJobs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: (_appliedJobs == null)
          ? const Center(
              child: CircularProgressIndicator(color: greenColor),
            )
          : (_appliedJobs!.isEmpty)
              ? const Center(
                  child: Text("No Data Found"),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: RefreshIndicator(
                    onRefresh: getWorkingJobs,
                    child: ListView.separated(
                      // physics: const AlwaysScrollableScrollPhysics(),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: _appliedJobs!.length,
                      itemBuilder: (context, index) {
                        JobModel1 data = _appliedJobs![index];
                        return InkWell(
                          onTap: () async {
                            circularProgressIndicatorNew(context);
                            await getJobDetails(data.id.toString());
                          },
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: screenWidth * 0.0635,
                                  backgroundImage: NetworkImage(data.images[0]),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    CharCapital.firstCharCapital(
                                        data.studioName),
                                    style: const TextStyle(
                                      fontFamily: fontFamily,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                subtitle: Text(
                                  data.description.length > 100
                                      ? data.description.substring(0, 100)
                                      : data.description,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontFamily: fontFamily,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                color: Color(0xFF979797),
                                indent: 20,
                                endIndent: 20,
                              ),
                              // SizedBox(height: screenHeight * 0.02),
                              // ListTile(
                              //   leading: CircleAvatar(
                              //     backgroundColor: Colors.transparent,
                              //     radius: screenWidth * 0.06,
                              //     backgroundImage: NetworkImage(data.images[0]),
                              //   ),
                              //   title: Padding(
                              //     padding: const EdgeInsets.only(bottom: 5),
                              //     child: Text(
                              //       data.description.substring(0, 40),
                              //       // data.studioName,
                              //       style: const TextStyle(
                              //         fontFamily: fontFamily,
                              //         fontWeight: FontWeight.bold,
                              //       ),
                              //     ),
                              //   ),
                              //   subtitle: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Text(
                              //         data.studioName,
                              //         // data.description,
                              //         style: TextStyle(
                              //           fontSize: 13,
                              //           fontFamily: fontFamily,
                              //           color: const Color(0xff131212)
                              //               .withOpacity(0.8),
                              //         ),
                              //       ),
                              //       // Text(
                              //       //   data.location,
                              //       //   // data.description,
                              //       //   style: const TextStyle(
                              //       //     fontSize: 10,
                              //       //     fontFamily: fontFamily,
                              //       //     fontWeight: FontWeight.w500,
                              //       //     color: Color(0xff706E72),
                              //       //   ),
                              //       // ),
                              //     ],
                              //   ),
                              //   isThreeLine: true,
                              // ),
                              // SizedBox(height: screenHeight * 0.01),
                              // const Divider(
                              //   thickness: 1,
                              //   height: 0,
                              //   color: Color(0xFF979797),
                              //   // indent: 20,
                              //   // endIndent: 20,
                              // ),
                              // SizedBox(height: screenHeight * 0.015),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.end,
                              //   children: [
                              //     Container(
                              //       width: screenWidth * 0.25,
                              //       height: screenHeight * 0.035,
                              //       alignment: Alignment.center,
                              //       child: AutoSizeText(
                              //         "View Details",
                              //         maxFontSize: 15,
                              //         minFontSize: 10,
                              //         style: TextStyle(
                              //           fontSize: 15,
                              //           color: greenColor,
                              //           fontWeight: FontWeight.normal,
                              //         ),
                              //       ),
                              //     ),
                              //     SizedBox(width: screenWidth * 0.05),
                              //     Container(
                              //       width: screenWidth * 0.3,
                              //       height: screenHeight * 0.035,
                              //       alignment: Alignment.center,
                              //       decoration: BoxDecoration(
                              //         // color: Colors.red,
                              //         borderRadius: BorderRadius.circular(5),
                              //         border: Border.all(
                              //             color: greenColor, width: 1.5),
                              //       ),
                              //       child: AutoSizeText(
                              //         "APPLY NOW",
                              //         maxFontSize: 14,
                              //         minFontSize: 10,
                              //         style: TextStyle(
                              //           fontSize: 14,
                              //           color: greenColor,
                              //           fontWeight: FontWeight.w500,
                              //         ),
                              //       ),
                              //     ),
                              //     SizedBox(width: screenWidth * 0.025),
                              //   ],
                              // ),
                              // SizedBox(height: screenHeight * 0.015),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: screenHeight * 0.02),
                    ),
                  ),
                ),
    );
  }
}
