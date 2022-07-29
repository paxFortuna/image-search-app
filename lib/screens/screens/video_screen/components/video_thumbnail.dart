import 'package:flutter/material.dart';
import 'package:image_search_app/color_schemes.g.dart';
import 'package:image_search_app/screens/screens/video_screen/components/contents/video_content.dart';
import '../../../../models/video.dart';

class VideoThumbnail extends StatelessWidget {
  final Video video;

  const VideoThumbnail({
    required this.video,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            video.thumbnail,
            fit: BoxFit.cover,
          ),
        ),
        const Positioned(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
          child: Icon(
            Icons.play_circle,
            size: 40,
            color: Colors.red,
          ),
        ),
        Positioned(
          left: 5,
            bottom: 3,
            child: VideoContent(video: video)),
      ],
    );
  }
}
