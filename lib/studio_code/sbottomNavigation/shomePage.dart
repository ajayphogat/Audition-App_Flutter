import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_app/auth/other_services.dart';
import 'package:first_app/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/studio_provider.dart';

class SHomePage extends StatefulWidget {
  const SHomePage({Key? key}) : super(key: key);

  static const String routeName = "/shome-page";

  @override
  State<SHomePage> createState() => _SHomePageState();
}

class _SHomePageState extends State<SHomePage> {
  final OtherService otherService = OtherService();
  bool a = false;
  final double barWidth = 22;
  final double width = 12;

  List<BarChartGroupData> rawBarGroups = [];
  List<BarChartGroupData> showingBarGroups = [];

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 2,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: Colors.black,
          width: width,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
        BarChartRodData(
          toY: y2,
          color: thirdColor,
          width: width,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
      ],
    );
  }

  void getStudioData() async {
    await otherService.getStudioData(context: context);
  }

  @override
  void initState() {
    getStudioData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final sUser = Provider.of<StudioProvider>(context).user;
    print("sUser");
    print(sUser.profilePic);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: screenHeight * 0.10,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.01),
          child: Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.02),
            child: const Text(
              "Dashboard",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: screenWidth * 0.04,
                  right: screenWidth * 0.04,
                  top: screenHeight * 0.03,
                  bottom: screenHeight * 0.015),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: screenWidth * 0.04,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      clipBehavior: Clip.hardEdge,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: sUser.profilePic.isEmpty
                            ? Container(
                                color: Colors.black,
                              )
                            : CachedNetworkImage(
                                imageUrl: sUser.profilePic,
                                fit: BoxFit.cover,
                              ),
                        // child: Image.network(
                        //   sUser.profilePic,
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Text(
                    sUser.fname,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
              ),
              child: Row(
                children: const [
                  Text(
                    "Hey! let's dive into\nthe details",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth,
              height: screenHeight,
              margin: EdgeInsets.only(
                top: screenHeight * 0.02,
              ),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    blurRadius: 5,
                    offset: Offset(1, 0),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: secondoryColor,
              ),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  const Text(
                    "Jobs by Applicants Graph",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "2023",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Padding(
                    padding: EdgeInsets.only(left: screenWidth * 0.03),
                    child: Row(
                      children: [
                        Container(
                          width: screenHeight * 0.015,
                          height: screenHeight * 0.015,
                          color: Colors.black,
                          margin: const EdgeInsets.only(right: 5),
                        ),
                        const Text(
                          "Applicants",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: screenHeight * 0.015,
                          height: screenHeight * 0.015,
                          color: thirdColor,
                          margin: const EdgeInsets.only(right: 5),
                        ),
                        const Text(
                          "Jobs",
                          style: TextStyle(
                            color: thirdColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      sUser.totalApplicants == null
                          ? Container(
                              alignment: Alignment.center,
                              width: screenWidth,
                              height: screenHeight * 0.25,
                              child: const CircularProgressIndicator(
                                color: greenColor,
                              ),
                            )
                          : Container(
                              width: screenWidth,
                              height: screenHeight * 0.25,
                              // color: Colors.red,
                              margin:
                                  EdgeInsets.only(bottom: screenHeight * 0.02),
                              // color: Colors.red,
                              child: BarChart(
                                BarChartData(
                                  alignment: BarChartAlignment.spaceEvenly,
                                  // maxY: 20,
                                  maxY: double.parse(sUser.totalApplicants!) >
                                          sUser.post!.length.toDouble()
                                      ? double.parse(sUser.totalAccepted!) * 10
                                      : sUser.post!.length.toDouble() * 10,
                                  minY: 0,
                                  borderData: FlBorderData(
                                    show: true,
                                    border: const Border(
                                      top: BorderSide.none,
                                      bottom: BorderSide(
                                        color: Colors.black,
                                      ),
                                      left: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  titlesData: FlTitlesData(
                                    show: true,
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        reservedSize: 42,
                                        showTitles: true,
                                        getTitlesWidget: bottomTitles,
                                      ),
                                    ),
                                  ),

                                  groupsSpace: 20,
                                  barTouchData: BarTouchData(
                                    enabled: true,
                                    touchTooltipData: BarTouchTooltipData(
                                      tooltipBgColor: Colors.white,
                                    ),
                                  ),
                                  gridData: FlGridData(show: false),
                                  barGroups: [
                                    makeGroupData(
                                        0,
                                        sUser.janApplicants!.toDouble(),
                                        sUser.janJob!.toDouble()),
                                    makeGroupData(
                                        1,
                                        sUser.febApplicants!.toDouble(),
                                        sUser.febJob!.toDouble()),
                                    makeGroupData(
                                        2,
                                        sUser.marApplicants!.toDouble(),
                                        sUser.marJob!.toDouble()),
                                    makeGroupData(
                                        3,
                                        sUser.aprApplicants!.toDouble(),
                                        sUser.aprJob!.toDouble()),
                                    makeGroupData(
                                        4,
                                        sUser.mayApplicants!.toDouble(),
                                        sUser.mayJob!.toDouble()),
                                    makeGroupData(
                                        5,
                                        sUser.junApplicants!.toDouble(),
                                        sUser.junJob!.toDouble()),
                                    makeGroupData(
                                        6,
                                        sUser.julApplicants!.toDouble(),
                                        sUser.julJob!.toDouble()),
                                    makeGroupData(
                                        7,
                                        sUser.augApplicants!.toDouble(),
                                        sUser.augJob!.toDouble()),
                                    makeGroupData(
                                        8,
                                        sUser.sepApplicants!.toDouble(),
                                        sUser.sepJob!.toDouble()),
                                    makeGroupData(
                                        9,
                                        sUser.octApplicants!.toDouble(),
                                        sUser.octJob!.toDouble()),
                                    makeGroupData(
                                        10,
                                        sUser.novApplicants!.toDouble(),
                                        sUser.novJob!.toDouble()),
                                    makeGroupData(
                                        11,
                                        sUser.decApplicants!.toDouble(),
                                        sUser.decJob!.toDouble()),
                                  ],
                                  // barGroups: BarData.barData
                                  //     .map(
                                  //       (data) => BarChartGroupData(
                                  //         x: data.id,
                                  //         barRods: [
                                  //           BarChartRodData(
                                  //             toY: data.y,
                                  //             width: barWidth,
                                  //             color: data.color,
                                  //           ),

                                  //           // BarChartRodData(
                                  //           //   toY: data.y,
                                  //           //   width: barWidth,
                                  //           //   color: data.color,
                                  //           // ),
                                  //         ],
                                  //       ),
                                  //     )
                                  //     .toList(),
                                ),
                              ),
                              // child: const CircularProgressIndicator(
                              //   color: Colors.black,
                              // ),
                            ),
                      // Positioned(
                      //   top: screenHeight * 0.15,
                      //   left: screenWidth * 0.085,
                      //   child: const RotatedBox(
                      //     quarterTurns: -1,
                      //     child: Text(
                      //       "Pages",
                      //       style: TextStyle(
                      //         fontSize: 10,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Positioned(
                      //   top: screenHeight * 0.345,
                      //   left: (screenWidth - 40) / 2,
                      //   child: const Text(
                      //     "Timeline",
                      //     style: TextStyle(
                      //       fontSize: 10,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.05, bottom: screenHeight * 0.01),
                    child: Row(
                      children: const [
                        Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.18,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: screenHeight * 0.01),
                      children: [
                        sUser.post == null
                            ? newVerticalContainer1(screenWidth, screenHeight,
                                "Number of posted jobs")
                            : newVerticalContainer(
                                screenWidth,
                                screenHeight,
                                "Number of posted jobs",
                                "${sUser.post!.length}"),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        sUser.totalApplicants == null
                            ? newVerticalContainer1(screenWidth, screenHeight,
                                "Number of total Applicants")
                            : newVerticalContainer(
                                screenWidth,
                                screenHeight,
                                "Number of total Applicants",
                                "${sUser.totalApplicants}"),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        sUser.totalShortlisted == null
                            ? newVerticalContainer1(screenWidth, screenHeight,
                                "Number of shortlisted Applicants")
                            : newVerticalContainer(
                                screenWidth,
                                screenHeight,
                                "Number of shortlisted Applicants",
                                "${sUser.totalShortlisted}"),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        sUser.totalAccepted == null
                            ? newVerticalContainer1(screenWidth, screenHeight,
                                "Number of accepted Applicants")
                            : newVerticalContainer(
                                screenWidth,
                                screenHeight,
                                "Number of accepted Applicants",
                                "${sUser.totalAccepted}"),
                        SizedBox(
                          width: screenWidth * 0.05,
                        ),
                        sUser.totalBookmark == null
                            ? newVerticalContainer1(screenWidth, screenHeight,
                                "Number of jobs bookmarked")
                            : newVerticalContainer(
                                screenWidth,
                                screenHeight,
                                "Number of jobs bookmarked",
                                "${sUser.totalBookmark}"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Material newVerticalContainer(
      double screenWidth, double screenHeight, String text1, String text2) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 4,
      child: Container(
        width: screenWidth * 0.25,
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              text1,
              textAlign: TextAlign.center,
            ),
            Text(
              text2,
              style: const TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Material newVerticalContainer1(
      double screenWidth, double screenHeight, String text1) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 4,
      child: Container(
        width: screenWidth * 0.25,
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              text1,
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.095),
              height: screenWidth * 0.06,
              child: const CircularProgressIndicator(
                color: greenColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 15) {
      text = 'Jobs';
    } else if (value == 10) {
      text = 'by';
    } else if (value == 5) {
      text = 'Applicants';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }
}
