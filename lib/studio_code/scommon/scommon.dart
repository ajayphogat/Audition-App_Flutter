import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/login/verifyMobile.dart';
import 'package:first_app/studio_code/sbottomNavigation/sbottomNavigationBar.dart';
import 'package:first_app/studio_code/sbottomNavigation/smyApplication.dart';
import 'package:first_app/studio_code/scommon/sdata.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

Widget commonTextField(
    BuildContext context, controller, String hintText, icon, bool isPassword) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.width;
  return SizedBox(
    width: screenWidth - screenWidth * 0.305,
    child: Stack(
      children: [
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: screenWidth - screenWidth * 0.305,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: placeholderColor,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return "Please fill this";
            } else {
              return null;
            }
          },
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontSize: 15,
              fontFamily: fontFamily,
              color: placeholderTextColor,
            ),
            errorStyle: const TextStyle(
              fontFamily: fontFamily,
              height: 0.1,
            ),
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  right: icon == MyFlutterApp.message ? 12 : 5,
                  bottom: 8),
              child: Icon(icon,
                  color: Colors.black,
                  size: icon == MyFlutterApp.message ? 28 : 35),
            ),
          ),
        ),
      ],
    ),
  );
}

InkWell basicButton(BuildContext context, formKey, routeName, String text) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.width;
  return InkWell(
    onTap: () {
      if (formKey.currentState!.validate()) {
        routeName == "/bottomNavigation-Page"
            ? Navigator.pushNamedAndRemoveUntil(
                context, routeName, (route) => false)
            : Navigator.pushNamed(context, routeName);
      }
    },
    child: Container(
      alignment: Alignment.center,
      width: screenWidth * 0.383,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: secondoryColor,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: fontFamily,
        ),
      ),
    ),
  );
}

InkWell longBasicButton(BuildContext context, routeName, String text) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.width;
  return InkWell(
    onTap: () {
      routeName == VerifyMobile.routeName
          ? Navigator.pushNamed(context, routeName)
          : Navigator.pushNamedAndRemoveUntil(
              context, routeName, (route) => false);
    },
    child: Container(
      alignment: Alignment.center,
      width: screenWidth * 0.59,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: secondoryColor,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: fontFamily,
          fontSize: 15,
        ),
      ),
    ),
  );
}

Material textContainer(double screenWidth, double screenHeight, String s1,
    String s2, String s3, picture) {
  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(5),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenHeight * 0.175,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            ),
            child: Image.asset(
              "asset/images/uiImages/$picture.png",
              isAntiAlias: true,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.005),
                Text(
                  s1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: fontFamily,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: screenHeight * 0.002),
                Text(
                  s2,
                  style: const TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: screenHeight * 0.003),
                Text(
                  s3,
                  style: const TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 9,
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

Material gridViewContainer(
    double screenWidth, double screenHeight, String s1, String s2, String s3) {
  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(5),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screenHeight * 0.21,
            width: screenWidth * 0.50,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
            ),
            child: Image.asset(
              s3,
              isAntiAlias: true,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 3),
                Text(
                  s1,
                  style: const TextStyle(
                    fontFamily: fontFamily,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  s2,
                  style: const TextStyle(
                    fontSize: 15,
                    color: placeholderTextColor,
                    fontFamily: fontFamily,
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

AppBar basicAppBar(
    double screenHeight,
    double screenWidth,
    BuildContext context,
    TextEditingController searchEdit,
    TabController tabController,
    List<String> data) {
  return AppBar(
    toolbarHeight: screenHeight * 0.10,
    backgroundColor: Colors.white,
    actions: [
      SizedBox(
        width: screenWidth,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(MyFlutterApp.bi_arrow_down, color: Colors.black),
              onPressed: () {
                // print(tabController.index);
                if (data == categoryData) {
                  Navigator.pop(context);
                }
                Navigator.pushReplacementNamed(
                    context, SBottomNavigationPage.routeName);
              },
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                width: screenWidth * 0.75,
                height: screenHeight * 0.045,
                padding: const EdgeInsets.only(left: 10, bottom: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: searchEdit,
                  decoration: InputDecoration(
                    hintText: "Search here....",
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      fontFamily: fontFamily,
                      color: placeholderTextColor,
                    ),
                    border: InputBorder.none,
                    suffixIcon: SizedBox(
                      width: screenWidth * 0.20,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              print(tabController.index);
                              print(searchEdit.text);
                              if (searchEdit.text.isNotEmpty) {
                                Navigator.pushNamed(
                                    context, SMyApplicationPage.routeName,
                                    arguments: [
                                      tabController.index,
                                      searchEdit.text
                                    ]);
                                print("Search");
                              }
                            },
                            child: SvgPicture.asset(
                              "asset/images/illustration/bytesize_search.svg",
                              color: placeholderTextColor,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                searchEdit.text = "";
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
            ),
            // IconButton(
            //   onPressed: () {
            //     showDialog(
            //         context: context,
            //         builder: (context) {
            //           return AlertDialog(
            //             title: Container(
            //               height: screenHeight * 0.10,
            //               alignment: Alignment.center,
            //               child: const Text(
            //                 "Filter Area is under Construction",
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                 ),
            //               ),
            //             ),
            //           );
            //         });
            //   },
            //   icon: const Icon(MyFlutterApp.filter),
            //   color: Colors.black,
            //   iconSize: 33,
            // ),
          ],
        ),
      ),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(screenHeight * 0.01),
      child: Container(
        height: screenHeight * 0.035,
        alignment: Alignment.centerLeft,
        child: TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorColor: thirdColor,
          labelColor: thirdColor,
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
          labelPadding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
          ),
          labelStyle: const TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
          ),
          tabs: [
            Tab(
              text: data[0],
            ),
            Tab(
              text: data[1],
            ),
            Tab(
              text: data[2],
            ),
            Tab(
              text: data[3],
            ),
            // Tab(
            //   text: data[4],
            // ),
            // Tab(
            //   text: data[5],
            // ),
          ],
        ),
      ),
    ),
  );
}

AppBar simpleAppBar(double screenHeight, double screenWidth,
    BuildContext context, TextEditingController searchEdit, String text) {
  return AppBar(
    toolbarHeight: screenHeight * 0.10,
    backgroundColor: Colors.white,
    actions: [
      SizedBox(
        width: screenWidth,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(MyFlutterApp.bi_arrow_down, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                width: screenWidth * 0.75,
                height: screenHeight * 0.045,
                padding: const EdgeInsets.only(bottom: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: searchEdit,
                  decoration: InputDecoration(
                    hintText: "Search here....",
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      fontFamily: fontFamily,
                      color: placeholderTextColor,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "asset/images/illustration/bytesize_search.svg",
                        color: placeholderTextColor,
                      ),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          searchEdit.text = "";
                        },
                        icon: const Icon(
                          MyFlutterApp.gridicons_cross,
                          size: 20,
                          color: placeholderTextColor,
                        )),
                  ),
                ),
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     showDialog(
            //         context: context,
            //         builder: (context) {
            //           return AlertDialog(
            //             title: Container(
            //               height: screenHeight * 0.10,
            //               alignment: Alignment.center,
            //               child: const Text(
            //                 "Filter Area is under Construction",
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                 ),
            //               ),
            //             ),
            //           );
            //         });
            //   },
            //   icon: const Icon(MyFlutterApp.filter),
            //   color: Colors.black,
            //   iconSize: 33,
            // ),
          ],
        ),
      ),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(screenHeight * 0.01),
      child: Container(
        height: screenHeight * 0.035,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: screenWidth * 0.05),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    ),
  );
}

AppBar basicAppBar2(
    double screenHeight,
    double screenWidth,
    BuildContext context,
    TextEditingController searchEdit,
    TabController tabController,
    List<String> data) {
  return AppBar(
    toolbarHeight: screenHeight * 0.10,
    backgroundColor: Colors.white,
    actions: [
      Container(
        width: screenWidth,
        height: screenHeight * 0.10,
        padding: EdgeInsets.only(
          left: screenWidth * 0.05,
          right: screenWidth * 0.01,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                width: screenWidth * 0.80,
                height: screenHeight * 0.045,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: TextFormField(
                  controller: searchEdit,
                  decoration: InputDecoration(
                    hintText: "Search here....",
                    hintStyle: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF979797),
                    ),
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                          "asset/images/illustration/bytesize_search.svg"),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          searchEdit.text = "";
                        },
                        icon: const Icon(
                          MyFlutterApp.gridicons_cross,
                          size: 20,
                          color: Color(0xFF979797),
                        )),
                  ),
                ),
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(MyFlutterApp.filter),
              color: Colors.black,
              iconSize: 33,
            ),
          ],
        ),
      ),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(screenHeight * 0.01),
      child: SizedBox(
        height: screenHeight * 0.035,
        child: TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorColor: const Color(0xFF30319D),
          labelColor: const Color(0xFF30319D),
          unselectedLabelColor: Colors.black,
          indicatorSize: TabBarIndicatorSize.label,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
          labelPadding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.03,
          ),
          labelStyle: const TextStyle(
            fontSize: 16,
          ),
          tabs: [
            Tab(
              text: data[0],
            ),
            Tab(
              text: data[1],
            ),
            Tab(
              text: data[2],
            ),
            Tab(
              text: data[3],
            ),
            Tab(
              text: data[4],
            ),
            Tab(
              text: data[5],
            ),
          ],
        ),
      ),
    ),
  );
}

Material basicTextFormField(double screenWidth, double screenHeight,
    TextEditingController controller, String hintText) {
  return Material(
    elevation: 5,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      width: screenWidth,
      height: screenHeight * 0.05,
      alignment: Alignment.center,
      padding:
          EdgeInsets.only(left: screenWidth * 0.04, bottom: screenWidth * 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: placeholderColor,
      ),
      child: TextFormField(
        controller: controller,
        // validator: (String? value) {
        //   if (value == null || value.isEmpty) {
        //     return "Please fill this";
        //   } else {
        //     return null;
        //   }
        // },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 15,
            color: placeholderTextColor,
          ),
          border: InputBorder.none,
        ),
      ),
    ),
  );
}

Container basicDropDown(double screenHeight, String title, String subTitle) {
  return Container(
    margin: EdgeInsets.only(bottom: screenHeight * 0.03),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: fontFamily,
                fontSize: 18,
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            Text(
              subTitle,
              style: const TextStyle(
                fontFamily: fontFamily,
                color: placeholderTextColor,
              ),
            ),
          ],
        ),
        const Icon(MyFlutterApp.arrow_right_2),
      ],
    ),
  );
}

TextButton appBarTextButton(String text) {
  return TextButton(
    onPressed: () {},
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: fontFamily,
        color: thirdColor,
      ),
    ),
  );
}

Widget detailsMenu(BuildContext context, double screenWidth,
    double screenHeight, String text, String routeName) {
  return Container(
    margin: const EdgeInsets.only(top: 19, left: 15, right: 15),
    child: Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
        child: Container(
          alignment: Alignment.center,
          width: screenWidth,
          height: screenHeight * 0.042,
          padding: const EdgeInsets.only(left: 15, right: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFFDF5F2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                  fontFamily: fontFamily,
                ),
              ),
              const Icon(MyFlutterApp.arrow_right_2),
            ],
          ),
        ),
      ),
    ),
  );
}

AppBar profileAppBar(double screenHeight, double screenWidth,
    BuildContext context, String headline) {
  return AppBar(
    backgroundColor: Colors.white,
    toolbarHeight: screenHeight * 0.105,
    actions: [
      SizedBox(
        width: screenWidth,
        height: screenHeight * 0.08,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                  top: screenHeight * 0.02,
                  bottom: screenHeight * 0.005),
              height: screenHeight * 0.02,
              child: IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  MyFlutterApp.bi_arrow_down,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  appBarTextButton("Cancel"),
                  Text(
                    headline,
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: fontFamily,
                      color: Colors.black,
                    ),
                  ),
                  appBarTextButton("Save"),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Column newColumn(double screenHeight, double screenWidth, String text1,
    String text2, String buttonText) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      AspectRatio(
        aspectRatio: 2,
        child: SvgPicture.asset("asset/images/illustration/innovation.svg"),
      ),
      SizedBox(height: screenHeight * 0.03),
      Text(
        text1,
        style: const TextStyle(
          fontSize: 20,
          fontFamily: fontFamily,
          color: placeholderTextColor,
        ),
      ),
      SizedBox(height: screenHeight * 0.015),
      Text(
        text2,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: fontFamily,
          color: placeholderTextColor,
        ),
      ),
      SizedBox(height: screenHeight * 0.03),
      InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          width: screenWidth * 0.383,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: secondoryColor,
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 16, fontFamily: fontFamily),
          ),
        ),
      ),
    ],
  );
}

AppBar descriptionAppBar(
    double screenHeight, double screenWidth, BuildContext context) {
  return AppBar(
    toolbarHeight: screenHeight * 0.07,
    backgroundColor: Colors.white,
    actions: [
      Container(
        width: screenWidth,
        margin: EdgeInsets.only(top: screenHeight * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(MyFlutterApp.bi_arrow_down, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(MyFlutterApp.bookmark, color: Colors.black),
                ),
                IconButton(
                  onPressed: () {},
                  icon:
                      const Icon(MyFlutterApp.share_fill, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Container yellowCircleButton(double screenHeight, IconData icon) {
  return Container(
    width: screenHeight * 0.03,
    height: screenHeight * 0.03,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFFF9D422),
    ),
    child: Icon(
      icon,
      color: Colors.black,
      size: screenHeight * 0.025,
    ),
  );
}

Future<dynamic> newDialogBox1(BuildContext context, double screenWidth,
    double screenHeight, String text, String text2, bool a, String routeName) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Container(
          width: screenWidth * 0.50,
          height: screenHeight * 0.30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: screenWidth * 0.40,
                height: screenWidth * 0.40,
                child: Lottie.asset(
                  "asset/lottie/successfully_done.json",
                  fit: BoxFit.contain,
                ),
              ),
              Text(text),
              InkWell(
                onTap: () {
                  a
                      ? Navigator.pushNamed(context, routeName)
                      : Navigator.pop(context);
                },
                child: Container(
                  width: screenWidth * 0.38,
                  height: screenHeight * 0.047,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: secondoryColor,
                  ),
                  child: Text(
                    text2,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget unOrderedListItem(BuildContext context, String text) {
  double screenHeight = MediaQuery.of(context).size.height;
  double screenWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: EdgeInsets.only(bottom: screenHeight * 0.01),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          "• ",
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

AppBar indexAppBar(
    double screenHeight, double screenWidth, BuildContext context) {
  return AppBar(
    toolbarHeight: screenHeight * 0.10,
    backgroundColor: Colors.white,
    actions: [
      SizedBox(
        width: screenWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(MyFlutterApp.bi_arrow_down, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // IconButton(
            //   padding: EdgeInsets.zero,
            //   onPressed: () {
            //     showDialog(
            //         context: context,
            //         builder: (context) {
            //           return AlertDialog(
            //             title: Container(
            //               height: screenHeight * 0.10,
            //               alignment: Alignment.center,
            //               child: const Text(
            //                 "Filter Area is under Construction",
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(
            //                   fontSize: 20,
            //                 ),
            //               ),
            //             ),
            //           );
            //         });
            //   },
            //   icon: const Icon(MyFlutterApp.filter),
            //   color: Colors.black,
            //   iconSize: 33,
            // ),
          ],
        ),
      ),
    ],
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(screenHeight * 0.01),
      child: const Text(
        "Invite Friends",
        style: TextStyle(fontSize: 25, color: thirdColor),
      ),
    ),
  );
}

Column simpleArrowColumn(double screenHeight, double screenWidth, String text) {
  return Column(
    children: [
      SizedBox(height: screenHeight * 0.01),
      Padding(
        padding: EdgeInsets.only(
            left: screenWidth * 0.0636, right: screenWidth * 0.0636),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: screenHeight * 0.0235),
            ),
            const Icon(MyFlutterApp.arrow_right_2),
          ],
        ),
      ),
      SizedBox(height: screenHeight * 0.01),
    ],
  );
}

AppBar paymentAppBar(double screenHeight, double screenWidth,
    BuildContext context, String text) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.white,
    toolbarHeight: screenHeight * 0.1015,
    actions: [
      SizedBox(
        width: screenWidth,
        height: screenHeight * 0.08,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: screenWidth * 0.02,
                  right: screenWidth * 0.02,
                  top: screenHeight * 0.02,
                  bottom: screenHeight * 0.005),
              height: screenHeight * 0.02,
              child: IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:
                    const Icon(MyFlutterApp.bi_arrow_down, color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: const TextStyle(
                      fontSize: 25,
                      fontFamily: fontFamily,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Container debitCardContainer(
    double screenHeight, double screenWidth, String assetName, String text) {
  return Container(
    height: screenHeight * 0.05,
    alignment: Alignment.centerLeft,
    margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade400, width: 2),
      color: Colors.white,
    ),
    child: ListTile(
      dense: true,
      visualDensity: const VisualDensity(vertical: -2),
      minLeadingWidth: 30,
      leading:
          AspectRatio(aspectRatio: 0.68, child: SvgPicture.asset(assetName)),
      title: Text(text),
      trailing: Stack(
        children: [
          Container(
            width: screenWidth * 0.04,
            height: screenWidth * 0.04,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 4,
              ),
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}
