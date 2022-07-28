import 'package:flutter/material.dart';
import 'package:image_search_app/fetch_api/video_api.dart';
import 'package:image_search_app/models/video.dart';
import 'package:image_search_app/screens/screens/video_screen/video_player_screen/video_screen.dart';

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
          if (snapshot.hasError) {
            return const Center(
              child: Text('에러가 발생했습니다'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      children:
          videos.where((e) => e.tags.contains(_videoQuery)).map((Video video) {
        return SingleChildScrollView(
          child: _genVideoData(video),
        );
      }).toList(),
    );
  }

  Widget _genVideoData(Video video) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                // 'https://i.vimeocdn.com/video/${video.videoId}_${200 * 150}.jpg',
                'https://pixabay.com/api/videos/${video.videoId}_${200 * 150}.jpg',
                fit: BoxFit.cover,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        VideoPlayScreen(video: video.videos.large['url']),
                  ),
                );
              },
              child: Positioned(
                left: 85,
                top: 60,
                right: 0,
                bottom: 0,
                width: 20,
                height: 20,
                child: CircleAvatar(
                  backgroundImage: Image.asset("assets/lottoWheel.png").image,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            'ID : ${video.videoId}',
            style: const TextStyle(fontSize: 12),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            'Tags : ${video.tags}',
            style: const TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white60,
        title: const Text(
          '이미지 검색 앱',
          style: TextStyle(fontSize: 20, color: Colors.black, letterSpacing: 1),
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
