import 'package:first_app/provider/studio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/common.dart';

class FollowersPage extends StatefulWidget {
  const FollowersPage({super.key});

  static const String routeName = '/followersPage';

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var sUser = Provider.of<StudioProvider1>(context).user;
    print(sUser.followers.length);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text("Followers"),
        centerTitle: true,
      ),
      body: sUser.id == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : sUser.followers.isEmpty
              ? const Center(
                  child: Text(
                    "No data found",
                  ),
                )
              : GridView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.03),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: screenHeight * 0.23,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: sUser.followers.length,
                  itemBuilder: (context, index) {
                    var data = sUser.followers[index];

                    return InkWell(
                      onTap: () async {
                        // print(data.id);
                        // circularProgressIndicatorNew(context);
                        // await getJobDetails(data.id.toString());
                      },
                      child: gridFollowerView(
                        context,
                        screenWidth,
                        screenHeight,
                        data['profilePic'],
                        data['fname'],
                      ),
                    );
                  },
                ),
    );
  }
}
