import 'package:flutter/material.dart';

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
        const Icon(Icons.play_circle),
      ],
    );
  }
}