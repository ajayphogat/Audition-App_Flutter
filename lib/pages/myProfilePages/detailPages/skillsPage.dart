import 'package:first_app/auth/auth_service.dart';
import 'package:first_app/common/common.dart';
import 'package:first_app/common/data.dart';
import 'package:first_app/constants.dart';
import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../provider/user_provider.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({Key? key}) : super(key: key);

  static const String routeName = "/skills-Page";

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> {
  late TextEditingController _skillController;
  final AuthService authService = AuthService();

  List<String> skillsList = [];

  Future<void> updateSkills() async {
    await authService.updateSkills(
      context: context,
      skills: skillsList,
    );
  }

  @override
  void initState() {
    _skillController = TextEditingController();
    var user = Provider.of<UserProvider>(context, listen: false).user;
    skillsList = user.skills;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: profileAppBar1(
          screenHeight, screenWidth, context, profileData[4], updateSkills),
      body: skillsList.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: screenWidth,
                    height: screenHeight * 0.70,
                    child: ListView.builder(
                      itemCount: skillsList.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Text(skillsList[index]),
                              trailing: InkWell(
                                onTap: () {
                                  skillsList.removeAt(index);
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
                            addSkill(context, screenWidth, screenHeight,
                                _skillController);
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
                  "You don't have any skills added yet",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: fontFamily,
                    color: placeholderTextColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.015),
                const Text(
                  "Add your performance skills",
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
                    addSkill(
                        context, screenWidth, screenHeight, _skillController);
                    setState(() {});
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: screenWidth * 0.383,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: secondoryColor,
                    ),
                    child: const Text(
                      "ADD SKILL",
                      style: TextStyle(fontSize: 16, fontFamily: fontFamily),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<dynamic> addSkill(BuildContext context, double screenWidth,
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
                      hintText: "Write your link here...",
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
                        if (controller.text.isNotEmpty) {
                          skillsList.add(controller.text);
                        }
                        controller.clear();
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
