import 'package:first_app/customize/my_flutter_app_icons.dart';
import 'package:first_app/studio_code/sconstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SMessagePage extends StatefulWidget {
  const SMessagePage({Key? key}) : super(key: key);

  static const String routeName = "/smessage-page";

  @override
  State<SMessagePage> createState() => _SMessagePageState();
}

class _SMessagePageState extends State<SMessagePage> {
  late TextEditingController _textController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: screenHeight * 0.1,
        actions: [
          Column(
            children: [
              SizedBox(
                width: screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(MyFlutterApp.bi_arrow_down,
                          color: Colors.black),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.25),
                      child: const Text(
                        "Messages",
                        style: TextStyle(
                          color: thirdColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: screenWidth,
                padding: EdgeInsets.only(left: screenWidth * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.asset("asset/images/uiImages/face.png",
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    const Text(
                      "Cameron Williamson",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight - (screenHeight * 0.213),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: ChatBubble(
                              clipper: ChatBubbleClipper1(
                                  type: BubbleType.sendBubble),
                              alignment: Alignment.topRight,
                              backGroundColor: secondoryColor,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: screenWidth * 0.7,
                                ),
                                child: const Text(
                                  "Quisque elementum tristique sapien viverra leo quisque in.",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.asset(
                                  "asset/images/uiImages/face.png",
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.asset(
                                  "asset/images/uiImages/girlFace.jpg",
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: ChatBubble(
                              clipper: ChatBubbleClipper1(
                                  type: BubbleType.receiverBubble),
                              alignment: Alignment.topLeft,
                              backGroundColor: secondoryColor,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: screenWidth * 0.7,
                                ),
                                child: const Text(
                                  "Quisque elementum tristique sapien viverra leo quisque in.",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: ChatBubble(
                              clipper: ChatBubbleClipper1(
                                  type: BubbleType.sendBubble),
                              alignment: Alignment.topRight,
                              backGroundColor: secondoryColor,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: screenWidth * 0.7,
                                ),
                                child: const Text(
                                  "Quisque elementum tristique sapien viverra leo quisque in.",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.asset(
                                  "asset/images/uiImages/face.png",
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.asset(
                                  "asset/images/uiImages/girlFace.jpg",
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: ChatBubble(
                              clipper: ChatBubbleClipper1(
                                  type: BubbleType.receiverBubble),
                              alignment: Alignment.topLeft,
                              backGroundColor: secondoryColor,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: screenWidth * 0.7,
                                ),
                                child: const Text(
                                  "Quisque elementum tristique sapien viverra leo quisque in.",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: ChatBubble(
                              clipper: ChatBubbleClipper1(
                                  type: BubbleType.sendBubble),
                              alignment: Alignment.topRight,
                              backGroundColor: secondoryColor,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: screenWidth * 0.7,
                                ),
                                child: const Text(
                                  "Quisque elementum tristique sapien viverra leo quisque in.",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.asset(
                                  "asset/images/uiImages/face.png",
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.asset(
                                  "asset/images/uiImages/girlFace.jpg",
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: ChatBubble(
                              clipper: ChatBubbleClipper1(
                                  type: BubbleType.receiverBubble),
                              alignment: Alignment.topLeft,
                              backGroundColor: secondoryColor,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: screenWidth * 0.7,
                                ),
                                child: const Text(
                                  "Quisque elementum tristique sapien viverra leo quisque in.",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: ChatBubble(
                              clipper: ChatBubbleClipper1(
                                  type: BubbleType.sendBubble),
                              alignment: Alignment.topRight,
                              backGroundColor: secondoryColor,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: screenWidth * 0.7,
                                ),
                                child: const Text(
                                  "Quisque elementum tristique sapien viverra leo quisque in.",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.asset(
                                  "asset/images/uiImages/face.png",
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.asset(
                                  "asset/images/uiImages/girlFace.jpg",
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: ChatBubble(
                              clipper: ChatBubbleClipper1(
                                  type: BubbleType.receiverBubble),
                              alignment: Alignment.topLeft,
                              backGroundColor: secondoryColor,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: screenWidth * 0.7,
                                ),
                                child: const Text(
                                  "Quisque elementum tristique sapien viverra leo quisque in.",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: ChatBubble(
                              clipper: ChatBubbleClipper1(
                                  type: BubbleType.sendBubble),
                              alignment: Alignment.topRight,
                              backGroundColor: secondoryColor,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: screenWidth * 0.7,
                                ),
                                child: const Text(
                                  "Quisque elementum tristique sapien viverra leo quisque in.",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.asset(
                                  "asset/images/uiImages/face.png",
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.asset(
                                  "asset/images/uiImages/girlFace.jpg",
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: ChatBubble(
                              clipper: ChatBubbleClipper1(
                                  type: BubbleType.receiverBubble),
                              alignment: Alignment.topLeft,
                              backGroundColor: secondoryColor,
                              child: Container(
                                constraints: BoxConstraints(
                                  maxWidth: screenWidth * 0.7,
                                ),
                                child: const Text(
                                  "Quisque elementum tristique sapien viverra leo quisque in.",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.02,
                    vertical: screenHeight * 0.005,
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(20),
                    elevation: 4,
                    child: Container(
                      width: screenWidth,
                      height: screenHeight * 0.06,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.02, right: screenWidth * 0.02),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey[200],
                      ),
                      child: TextFormField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: "Type your message here",
                          hintStyle: const TextStyle(
                            fontSize: 15,
                            fontFamily: fontFamily,
                            color: placeholderTextColor,
                          ),
                          border: InputBorder.none,
                          prefixIcon: IconButton(
                            onPressed: () {
                              showDialog(
                                barrierColor: Colors.transparent,
                                context: context,
                                builder: ((context) {
                                  return Dialog(
                                    insetPadding: EdgeInsets.only(
                                        top: screenHeight * 0.49),
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Container(
                                      width: screenWidth * 0.95,
                                      height: screenHeight * 0.30,
                                      padding:
                                          EdgeInsets.all(screenWidth * 0.05),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey[200],
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              sendDocumentButton(screenWidth,
                                                  MyFlutterApp.camera_2_fill),
                                              sendDocumentButton(screenWidth,
                                                  MyFlutterApp.live_fill),
                                              sendDocumentButton(screenWidth,
                                                  MyFlutterApp.mic_fill),
                                            ],
                                          ),
                                          SizedBox(height: screenHeight * 0.02),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              sendDocumentButton(screenWidth,
                                                  MyFlutterApp.paper),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              );
                            },
                            icon: const Icon(
                                MyFlutterApp.clarity_attachment_line,
                                color: Colors.black),
                          ),
                          suffixIcon: IconButton(
                            icon:
                                SvgPicture.asset("asset/icons/send_button.svg"),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget sendDocumentButton(double screenWidth, IconData icon) {
    return InkWell(
      onTap: () {
        print("Hello");
      },
      child: Container(
        width: screenWidth * 0.15,
        height: screenWidth * 0.15,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: secondoryColor,
        ),
        child: Icon(icon),
      ),
    );
  }
}
