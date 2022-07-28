import 'package:flutter/material.dart';
import 'package:image_search_app/models/video.dart';
import 'package:video_player/video_player.dart';

class VideoPlayScreen extends StatefulWidget {
  const VideoPlayScreen({Key? key, required this.video}) : super(key: key);
  final Video video;

  @override
  State<VideoPlayScreen> createState() => _VideoPlayScreenState();
}

class _VideoPlayScreenState extends State<VideoPlayScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.video.videos.large['url'])
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Player',
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
              : Container(),
        ),
        floatingActionButton: Opacity(
          opacity: 0.3,
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}