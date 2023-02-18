import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key, required this.videoUrl});

  final String videoUrl;

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _controller;
  late bool isMuted = _controller.value.volume == 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => _controller.play());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return _controller != null && _controller.value.isInitialized
        ? Center(
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(5),
              clipBehavior: Clip.antiAlias,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: screenHeight * 0.65,
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
                    Container(
                      height: screenHeight * 0.50,
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                    _controller != null && _controller.value.isInitialized
                        ? IconButton(
                            onPressed: () {
                              _controller.setVolume(isMuted ? 1 : 0);
                              setState(() {
                                isMuted = !isMuted;
                              });
                            },
                            icon: Icon(
                                isMuted ? Icons.volume_mute : Icons.volume_up),
                            iconSize: 30,
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          )
        : Center(
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(5),
              clipBehavior: Clip.antiAlias,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: screenHeight * 0.65,
                width: screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
  }
}
