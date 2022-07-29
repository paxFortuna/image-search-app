import 'package:flutter/material.dart';
import 'package:image_search_app/theme.dart';

import '../../../../../models/video.dart';

class VideoContent extends StatelessWidget {
  const VideoContent({Key? key, required this.video}) : super(key: key);
  final Video video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tag: ${video.tags}',
            style: textTheme.bodyText2,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 3),
          Text(
            'Url: ${video.videos.large.url}',
            style: textTheme.bodyText2,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
