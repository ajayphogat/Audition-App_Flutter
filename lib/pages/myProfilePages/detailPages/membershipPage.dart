import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:flutter/material.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({Key? key}) : super(key: key);

  static const String routeName = "/membership-Page";

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: profileAppBar(screenHeight, screenWidth, context, profileData[3]),
      body: Column(
        children: [
          Container(
            width: screenWidth,
            height: screenHeight * 0.80,
            margin: EdgeInsets.only(top: screenHeight * 0.03),
            child: ListView.builder(
              itemCount: membershipData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            membershipData[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Icon(Icons.check),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
