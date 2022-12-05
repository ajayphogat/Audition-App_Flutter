import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/auth/databaseService.dart';
import 'package:first_app/auth/other_services.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/pages/inboxPages/messagePage.dart';
import 'package:first_app/provider/job_post_provider.dart';
import 'package:first_app/provider/studio_provider.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:first_app/studio_code/spages/sinboxPages/smessagePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class SDesignationPage extends StatefulWidget {
  const SDesignationPage({Key? key}) : super(key: key);

  static const String routeName = "/sdesignation-page";

  @override
  State<SDesignationPage> createState() => _SDesignationPageState();
}

class _SDesignationPageState extends State<SDesignationPage> {
  final OtherService otherService = OtherService();
  bool isAccepted = false;
  bool isShortlisted = false;
  bool isDeclined = false;

  Future<void> acceptedStudioJob(jobId, userId) async {
    await otherService.acceptedStudioJob(
        context: context, jobId: jobId, userId: userId, work: "Accepted");
  }

  Future<void> shortlistedStudioJob(jobId, userId) async {
    await otherService.acceptedStudioJob(
        context: context, jobId: jobId, userId: userId, work: "Shortlisted");
  }

  Future<void> declinedStudioJob(jobId, userId) async {
    await otherService.acceptedStudioJob(
        context: context, jobId: jobId, userId: userId, work: "Declined");
  }

  Future<void> studioAcceptJobData(jobId, userId) async {
    await otherService.studioAcceptJobData(
        context: context, jobId: jobId, userId: userId);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var args = ModalRoute.of(context)!.settings.arguments as String;
    var user = Provider.of<UserProvider1>(context).user;
    var jobs = Provider.of<JobProvider1>(context).job;
    var sUser = Provider.of<StudioProvider>(context).user;
    isAccepted = jobs.isAccepted!;
    isShortlisted = jobs.isShortlisted!;
    isDeclined = jobs.isDeclined!;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                          icon: const Icon(MyFlutterApp.gridicons_cross),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      children: const [
                        Text(
                          "Designation",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: screenWidth * 0.05,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                              "asset/images/uiImages/girlFace.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        user.fname,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      subtitle: Text(user.location),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              circleWithTextContainer(screenWidth, "5 Photos",
                                  MyFlutterApp.camera_2_fill),
                              SizedBox(height: screenHeight * 0.02),
                              circleWithTextContainer(screenWidth,
                                  "0 Documents", MyFlutterApp.paper),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              circleWithTextContainer(screenWidth, "3 Videos",
                                  MyFlutterApp.live_fill),
                              SizedBox(height: screenHeight * 0.02),
                              circleWithTextContainer(screenWidth, "0 Audios",
                                  MyFlutterApp.mic_fill),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                circularProgressIndicatorNew(context);
                              },
                              child: simpleButton(
                                  screenWidth, screenHeight, "Save")),
                          InkWell(
                              onTap: () async {
                                navigatorPush(groupId, groupName, userName) =>
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (context) => SMessagePage(
                                            groupId: groupId,
                                            groupName: groupName,
                                            userName: userName,
                                          ),
                                        ));
                                navigatorPop() => Navigator.pop(context);
                                circularProgressIndicatorNew(context);
                                List<dynamic> a =
                                    await DatabaseService(uid: sUser.id)
                                        .createGroup(
                                            sUser.fname, user.id, user.fname);

                                navigatorPop();
                                navigatorPush(a[0], a[1], a[2]);
                              },
                              child: simpleButton(
                                  screenWidth, screenHeight, "Chat")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              const Divider(
                color: Colors.black,
                thickness: 1,
                height: 1,
              ),
              SizedBox(height: screenHeight * 0.02),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Text(
                          "About Candidate",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.03),
                    Row(
                      children: [
                        const Text(
                          "Skills:",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.20,
                          height: 15,
                          margin: const EdgeInsets.only(left: 5),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: user.skills.length,
                            itemBuilder: (context, index) {
                              return Text(user.skills[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Location: ${user.location}",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    // const Text(
                    //   "Experience: 2 year",
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //   ),
                    // ),
                    SizedBox(height: screenHeight * 0.02),
                    ReadMoreText(
                      user.bio,
                      trimCollapsedText: "Show More",
                      trimExpandedText: "Show Less",
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                      moreStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      lessStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      trimMode: TrimMode.Length,
                      trimLength: 655,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: screenWidth * 0.95,
        // color: Colors.red,
        child: (isAccepted == false &&
                isShortlisted == false &&
                isDeclined == false)
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      navigatorPop() => Navigator.pop(context);
                      circularProgressIndicatorNew(context);
                      await acceptedStudioJob(args, user.id);
                      navigatorPop();
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: screenWidth * 0.25,
                      height: screenHeight * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: secondoryColor,
                      ),
                      child: Text("Accept"),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      navigatorPop() => Navigator.pop(context);
                      circularProgressIndicatorNew(context);
                      await shortlistedStudioJob(args, user.id);
                      navigatorPop();
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: screenWidth * 0.25,
                      height: screenHeight * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: secondoryColor,
                      ),
                      child: Text("Shortlist"),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      navigatorPop() => Navigator.pop(context);
                      circularProgressIndicatorNew(context);
                      await declinedStudioJob(args, user.id);
                      navigatorPop();
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: screenWidth * 0.25,
                      height: screenHeight * 0.04,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: secondoryColor,
                      ),
                      child: Text("Decline"),
                    ),
                  ),
                ],
              )
            : InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  width: screenWidth * 0.50,
                  height: screenHeight * 0.04,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: secondoryColor,
                  ),
                  child: Text((isAccepted == true &&
                          isShortlisted == false &&
                          isDeclined == false)
                      ? "Accepted"
                      : (isAccepted == false &&
                              isShortlisted == true &&
                              isDeclined == false)
                          ? "Shortlisted"
                          : (isAccepted == false &&
                                  isShortlisted == false &&
                                  isDeclined == true)
                              ? "Declined"
                              : ""),
                ),
              ),
      ),
    );
  }

  Widget circleWithTextContainer(
      double screenWidth, String text, IconData icons) {
    return SizedBox(
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: secondoryColor,
            radius: screenWidth * 0.05,
            child: Icon(
              icons,
              color: Colors.black,
              size: 20,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Text(text),
        ],
      ),
    );
  }

  Container simpleButton(double screenWidth, double screenHeight, String text) {
    return Container(
      width: screenWidth * 0.32,
      height: screenHeight * 0.04,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: secondoryColor,
      ),
      child: Text(text),
    );
  }
}
