import 'package:first_app/bottomNavigation/bottomNavigationBar.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget commonTextField(
    BuildContext context, controller, String hintText, icon, bool isPassword) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 120,
    child: Stack(
      children: [
        Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: MediaQuery.of(context).size.width - 120,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFFDF5F2),
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
              color: Color(0xFF979797),
            ),
            errorStyle: const TextStyle(
              height: 0.1,
            ),
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 20, right: 5),
              child: Icon(icon, color: Colors.black, size: 30),
            ),
          ),
        ),
      ],
    ),
  );
}

InkWell basicButton(BuildContext context, formKey, routeName, String text) {
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
      width: 150,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF9D422),
      ),
      child: Text(text),
    ),
  );
}

InkWell longBasicButton(BuildContext context, routeName, String text) {
  return InkWell(
    onTap: () {
      Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
    },
    child: Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width - 160,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFF9D422)),
      child: Text(
        text,
        style: const TextStyle(
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
                const SizedBox(height: 5),
                Text(
                  s1,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  s2,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  s3,
                  style: const TextStyle(
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
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  s2,
                  style:
                      const TextStyle(fontSize: 15, color: Color(0xFF979797)),
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
                if (data == categoryData) {
                  Navigator.pop(context);
                }
                Navigator.pushReplacementNamed(
                    context, BottomNavigationPage.routeName);
              },
            ),
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(4),
              child: Container(
                width: screenWidth * 0.75,
                height: screenHeight * 0.045,
                // padding: const EdgeInsets.only(bottom: 2),
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
        color: const Color(0xFFFDF5F2),
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
            color: Color(0xFF979797),
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
                fontSize: 18,
              ),
            ),
            SizedBox(height: screenHeight * 0.005),
            Text(
              subTitle,
              style: const TextStyle(
                color: Color(0xFF979797),
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
        color: Color(0xFF30319D),
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
              Text(text),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  appBarTextButton("Cancel"),
                  Text(
                    headline,
                    style: const TextStyle(
                      fontSize: 20,
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

Column newColumn(
    double screenHeight, String text1, String text2, String buttonText) {
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
          color: Color(0xFF979797),
        ),
      ),
      SizedBox(height: screenHeight * 0.015),
      Text(
        text2,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF979797),
        ),
      ),
      SizedBox(height: screenHeight * 0.03),
      InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          width: 150,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFFF9D422),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    ],
  );
}
