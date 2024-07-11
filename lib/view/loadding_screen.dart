import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../Model/my_data.dart'; // Ensure this file contains the `loadingAimationVideoUrl`

class MyLoader extends StatefulWidget {
  const MyLoader({super.key});

  @override
  State<MyLoader> createState() => _MyLoaderState();
}

class _MyLoaderState extends State<MyLoader> {
  String videoUrl = loadingAimationVideoUrl;

  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Initialize the video player controller with the asset video URL
    _controller = VideoPlayerController.asset(videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {
        _controller.play();
        _controller.setLooping(true);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: getVideoAnimation(),
      ),
    );
  }

  Widget getVideoAnimation() {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (_controller.value.isInitialized) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 200,
                  child: const Text(
                    "loading...",
                    style: TextStyle(
                        color: Color.fromARGB(255, 193, 193, 193),
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: Text(
                "Failed to load video",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
        } else if (snapshot.hasError) {
          return const Center(
            child: Text(
              "Failed to load video",
              style: TextStyle(color: Colors.white),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
