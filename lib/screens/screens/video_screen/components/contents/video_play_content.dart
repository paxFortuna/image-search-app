import 'package:flutter/material.dart';
import 'package:image_search_app/theme.dart';
import '../../../../../models/video.dart';

class VideoPlayContent extends StatelessWidget {
  const VideoPlayContent({Key? key, required this.video}) : super(key: key);
  final Video video;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'Copy from Gumsang_code^^',
            style: textTheme.bodyText2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            video.tags,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        //아이콘 부분//
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  const Icon(Icons.thumb_up_outlined),
                  Text(video.likes.toString()),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: [
                  const Icon(Icons.remove_red_eye_outlined),
                  Text("View : ${video.views.toString()}"),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: const [
                  Icon(Icons.reply_rounded),
                  Text("공유"),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: const [
                  Icon(Icons.playlist_add_outlined),
                  Text("만들기"),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: const [
                  Icon(Icons.flag_outlined),
                  Text("신고"),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: const [
                  Icon(Icons.subscriptions_outlined),
                  Text("스크립트 표시"),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                children: const [
                  Icon(Icons.download_outlined),
                  Text("오프라인 저장"),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
            ],
          ),
        ),
        const Divider(
          // indent: 3,
          // endIndent: 3,
          // color: Colors.black45,
          thickness: 2,
          height: 30,
        ),

        //ID
        Row(
          children: [
            SizedBox(
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(video.userImageURL),
              ),
            ),
            const SizedBox(
              width: 13,
            ),
            Expanded(
              child: Text(
                video.user,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                "구독",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
