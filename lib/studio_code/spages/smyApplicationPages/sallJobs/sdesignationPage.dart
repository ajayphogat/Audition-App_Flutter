import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class SDesignationPage extends StatelessWidget {
  const SDesignationPage({Key? key}) : super(key: key);

  static const String routeName = "/sdesignation-page";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                      title: const Text(
                        "Name of the Candidate",
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      subtitle: const Text("Location"),
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
                              circleWithTextContainer(screenWidth, "58 Photos",
                                  MyFlutterApp.camera_2_fill),
                              SizedBox(height: screenHeight * 0.02),
                              circleWithTextContainer(screenWidth,
                                  "3 Documents", MyFlutterApp.paper),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              circleWithTextContainer(screenWidth, "75 Videos",
                                  MyFlutterApp.live_fill),
                              SizedBox(height: screenHeight * 0.02),
                              circleWithTextContainer(screenWidth, "9 Audios",
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
                          simpleButton(screenWidth, screenHeight, "Save"),
                          simpleButton(screenWidth, screenHeight, "Chat"),
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
                    const Text(
                      "Skills: Skills of candidate",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const Text(
                      "Location: Job Location",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const Text(
                      "Experience: 2 year",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    const ReadMoreText(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Egestas aliquet et cras magna velit diam adipiscing non. Cursus senectus nec eu, erat habitasse arcu tortor. Faucibus tempor semper enim sed dolor turpis. Quis urna cursus in a nulla. Id vestibulum varius ultricies bibendum commodo facilisi elementum eget enim. Erat auctor malesuada donec id imperdiet odio. Facilisi iaculis cursus lorem ac habitant volutpat lorem consequat. Amet condimentum lacus quis nulla sed tincidunt parturient sit ullamcorper. Eu mauris sed ut urna nulla morbi sed vulputate scelerisque. Erat amet, purus vel eu. Montes, eget adipiscing in nisi, purus lorem auctor egestas. Eu mauris sed ut urna nulla morbi sed vulputate scelerisque. Erat amet, purus vel eu. Montes, eget adipiscing in nisi, purus lorem auctor egestas. ",
                      trimCollapsedText: "Show More",
                      trimExpandedText: "Show Less",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                      moreStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      lessStyle: TextStyle(
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
