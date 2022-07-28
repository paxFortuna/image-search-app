import 'package:flutter/material.dart';
import 'package:image_search_app/fetch_api/video_api.dart';
import 'package:image_search_app/models/video.dart';
import 'package:image_search_app/screens/screens/video_screen/video_player_screen/video_player_screen.dart';
import 'package:image_search_app/theme.dart';

import 'components/video_thumbnail.dart';

class VideoSearchApp extends StatefulWidget {
  const VideoSearchApp({Key? key}) : super(key: key);

  @override
  State<VideoSearchApp> createState() => _VideoSearchAppState();
}

class _VideoSearchAppState extends State<VideoSearchApp> {
  final _videoApi = VideoApi();
  final _videoController = TextEditingController();
  String _videoQuery = '';

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  Widget _genTextField() {
    return TextField(
      controller: _videoController,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        // TextField height 설정과 borderLine 유지하기
        contentPadding: const EdgeInsets.fromLTRB(12.0, 0.5, 0.0, 0.5),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            // 키보드 닫기 이벤트 처리
            FocusManager.instance.primaryFocus?.unfocus();
            setState(() {
              _videoQuery = _videoController.text;
              _videoController.clear();
            });
          },
          child: const Icon(Icons.search),
        ),
        hintText: '검색어를 입력하세요',
      ),
    );
  }

  Widget _genFutureBuild() {
    return FutureBuilder<List<Video>>(
        future: _videoApi.getVideos(_videoQuery),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('에러가 발생했습니다'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('데이터가 없습니다'),
            );
          }

          final List<Video> videos = snapshot.data!;

          return _genGridView(videos);
        });
  }

  Widget _genGridView(List<Video> videos) {
    return Center(
      child: Builder(
        builder: (BuildContext context) {
          final orientation = MediaQuery.of(context).orientation;
          return GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            children: videos
                .map(
                  (Video video) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayScreen(video: video),
                        ),
                      );
                    },
                    child: VideoThumbnail(video: video),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: Text(
          '동영상 검색 앱',
          style: textTheme().headline2,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 15, 5, 8),
            child: _genTextField(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _genFutureBuild(),
            ),
          ),
        ],
      ),
    );
  }
}
