import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:flutter/material.dart';

class CategoryGirdPage extends StatefulWidget {
  const CategoryGirdPage({Key? key}) : super(key: key);

  static const String routeName = "/categoryGrid-page";

  @override
  State<CategoryGirdPage> createState() => _CategoryGirdPageState();
}

class _CategoryGirdPageState extends State<CategoryGirdPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GridView.builder(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04, vertical: screenHeight * 0.03),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          mainAxisExtent: screenHeight * 0.27,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: actorData.length,
        itemBuilder: (context, index) {
          List<String> data = actorData[index];
          return gridViewContainer(
              screenWidth, screenHeight, data[0], data[1], data[2]);
        },
      ),
    );
  }
}
