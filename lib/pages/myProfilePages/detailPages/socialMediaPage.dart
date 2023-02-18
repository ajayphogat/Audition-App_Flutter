import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({Key? key}) : super(key: key);

  static const String routeName = "/socialMedia-Page";

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  late TextEditingController _socialLinkController;
  AuthService authService = AuthService();

  late List<String> linkList;

  Future<void> updateSocialMedia() async {
    await authService.updateSocialMedia(
      context: context,
      socialMedia: linkList,
    );
  }

  @override
  void initState() {
    _socialLinkController = TextEditingController();
    var user = Provider.of<UserProvider>(context, listen: false).user;
    linkList = user.socialMedia;
    super.initState();
  }

  @override
  void dispose() {
    _socialLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: profileAppBar1(screenHeight, screenWidth, context, profileData[2],
          updateSocialMedia),
      body: linkList.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight * 0.70,
                    child: ListView.builder(
                      itemCount: linkList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(linkList[index]),
                              trailing: InkWell(
                                onTap: () {
                                  linkList.removeAt(index);
                                  setState(() {});
                                },
                                child: const Icon(MyFlutterApp.gridicons_cross),
                              ),
                            ),
                            const Divider(
                              color: placeholderTextColor,
                              indent: 10,
                              endIndent: 10,
                              height: 10,
                              thickness: 1,
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        const Divider(
                          color: Colors.black,
                          height: 10,
                          thickness: 3,
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            addLink(context, screenWidth, screenHeight,
                                _socialLinkController);
                            setState(() {});
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: secondoryColor,
                            ),
                            child: const Text(
                              "ADD LINK",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: fontFamily,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 2,
                  child: SvgPicture.asset(
                      "asset/images/illustration/innovation.svg"),
                ),
                SizedBox(height: screenHeight * 0.03),
                const Text(
                  "You don't have any links added yet",
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 20,
                    color: placeholderTextColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                const Text(
                  "Add your personal website, social links, and\nmore.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: fontFamily,
                    color: placeholderTextColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                InkWell(
                  onTap: () {
                    addLink(context, screenWidth, screenHeight,
                        _socialLinkController);
                    setState(() {});
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: secondoryColor,
                    ),
                    child: const Text(
                      "ADD LINK",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: fontFamily,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<dynamic> addLink(BuildContext context, double screenWidth,
      double screenHeight, TextEditingController controller) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Container(
            width: screenWidth * 0.80,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Container(
                  width: screenWidth * 0.60,
                  height: screenHeight * 0.30,
                  // color: Colors.yellow[50],
                  decoration: BoxDecoration(
                      color: Colors.yellow[100],
                      border: Border.all(
                        color: secondoryColor,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none,
                      hintText: "Write your skill here...",
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_socialLinkController.text.isNotEmpty) {
                          linkList.add(_socialLinkController.text);
                        }
                        _socialLinkController.clear();
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Add",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
