import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:flutter/material.dart';

class MyApplicationAppliedPage extends StatefulWidget {
  const MyApplicationAppliedPage({Key? key}) : super(key: key);

  static const String routeName = "/myApplicationApplied-page";

  @override
  State<MyApplicationAppliedPage> createState() =>
      _MyApplicationAppliedPageState();
}

class _MyApplicationAppliedPageState extends State<MyApplicationAppliedPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: applicationAppliedData.length,
          itemBuilder: (context, index) {
            List<String> data = applicationAppliedData[index];
            return SizedBox(
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: screenWidth * 0.0635,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset(data[2]),
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        data[0],
                        style: const TextStyle(
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                    subtitle: Text(
                      data[1],
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
