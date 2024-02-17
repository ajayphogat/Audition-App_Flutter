import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ChatPage extends StatefulWidget {
  final String message;
  final String sender;
  final String profilePic;
  final String adminProfilePic;
  final String typee;
  final bool sentByMe;
  const ChatPage({
    super.key,
    required this.message,
    required this.sender,
    required this.profilePic,
    required this.adminProfilePic,
    required this.typee,
    required this.sentByMe,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.015,
      ),
      child: Row(
        mainAxisAlignment:
            widget.sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: widget.sentByMe
            ? [
                chatBB(screenHeight, screenWidth),
                chatMsg(screenHeight, screenWidth),
              ]
            : [
                chatMsg(screenHeight, screenWidth),
                chatBB(screenHeight, screenWidth),
              ],
      ),
    );
  }

  Container chatMsg(double screenHeight, double screenWidth) {
    return Container(
      width: 32,
      height: 32,
      // margin: EdgeInsets.only(
      //   top: screenHeight * 0.025,
      //   bottom: screenHeight * 0.025,
      // ),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: widget.sentByMe
            ? widget.adminProfilePic.isEmpty
                ? Container(
                    color: Colors.black,
                  )
                : CachedNetworkImage(
                    imageUrl: widget.adminProfilePic,
                    fit: BoxFit.cover,
                  )
            : widget.profilePic.isEmpty
                ? Container(
                    color: Colors.black,
                  )
                : CachedNetworkImage(
                    imageUrl: widget.profilePic,
                    fit: BoxFit.cover,
                  ),
      ),
    );
  }

  ChatBubble chatBB(double screenHeight, double screenWidth) {
    return ChatBubble(
      clipper: ChatBubbleClipper1(
          type: widget.sentByMe
              ? BubbleType.sendBubble
              : BubbleType.receiverBubble),
      backGroundColor: Colors.white,
      margin: EdgeInsets.only(
        top: screenHeight * 0.015,
        bottom: screenHeight * 0.015,
      ),
      child: widget.typee == "text"
          ? Container(
              constraints: BoxConstraints(
                maxWidth: screenWidth * 0.7,
              ),
              child: Text(
                widget.message,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            )
          : Container(
              constraints: BoxConstraints(
                maxWidth: screenWidth * 0.7,
              ),
              child: widget.message == ""
                  ? const CircularProgressIndicator(color: greenColor)
                  : InkWell(
                      onTap: () async {
                        await showDialog(
                            // barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return Center(
                                child: Material(
                                  elevation: 5,
                                  borderRadius: BorderRadius.circular(5),
                                  clipBehavior: Clip.antiAlias,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    height: screenHeight * 0.605,
                                    width: screenWidth,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(Icons.close),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: screenWidth,
                                          height: screenHeight * 0.50,
                                          child: PhotoViewGallery(
                                            pageOptions: [
                                              PhotoViewGalleryPageOptions(
                                                imageProvider:
                                                    CachedNetworkImageProvider(
                                                  widget.message,
                                                ),
                                                minScale: PhotoViewComputedScale
                                                        .contained *
                                                    0.8,
                                                maxScale: PhotoViewComputedScale
                                                        .covered *
                                                    2,
                                              )
                                            ],
                                            scrollPhysics:
                                                const NeverScrollableScrollPhysics(),
                                            backgroundDecoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                              color:
                                                  Theme.of(context).canvasColor,
                                            ),
                                            enableRotation: true,
                                            loadingBuilder: (context, event) =>
                                                Center(
                                              child: SizedBox(
                                                width: 30.0,
                                                height: 30.0,
                                                child: CircularProgressIndicator(
                                                    backgroundColor:
                                                        Colors.orange,
                                                    value: event == null
                                                        ? 0
                                                        : (event.cumulativeBytesLoaded
                                                                .toDouble() /
                                                            event
                                                                .expectedTotalBytes!
                                                                .toDouble())),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      child: CachedNetworkImage(imageUrl: widget.message)),

              // Image.network(widget.message),
            ),
    );
  }
}
