import 'package:flutter/material.dart';

import '../../../fetch_api/photo_stream_api.dart';
import '../../../models/photo.dart';
import '../../../theme.dart';

class ImageStreamScreen extends StatefulWidget {
  const ImageStreamScreen({Key? key}) : super(key: key);

  @override
  State<ImageStreamScreen> createState() => _ImageStreamScreenState();
}

class _ImageStreamScreenState extends State<ImageStreamScreen> {


  List<Photo>? initImage;
  List<Photo> images = [];
  final _streamApi = PhotoStreamApi();
  final _controller = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData () async{
    initImage = await _streamApi.initStream();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
 
  Widget _genTextField() {
    return SingleChildScrollView(
      child: TextField(
        controller: _controller,
        decoration:InputDecoration(
          enabledBorder: _genOutInputer(),
          // TextField height 설정과 borderLine 유지하기
          contentPadding: const EdgeInsets.fromLTRB(12.0, 0.5, 0.0, 0.5),
          focusedBorder: _genOutInputer(),
          suffixIcon: GestureDetector(
            onTap: () {
              // 키보드 닫기 이벤트 처리
              FocusManager.instance.primaryFocus?.unfocus();
              setState(() {
                _query = _controller.text;
                _controller.clear();
              });
            },
            child: const Icon(Icons.search),
          ),
          hintText: '검색어를 입력하세요',
        ),
      ),
    );
  }

  OutlineInputBorder _genOutInputer() {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.secondary,
        width: 2,
      ),
    );
  }

  Widget _genStreamBuild() {
    return StreamBuilder<List<Photo>>(
        initialData: initImage,
        stream: _streamApi.photoStream,
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
          final List<Photo> images = snapshot.data!;

          return _genGridView(images, context);
        });
  }
  // Builder Widget 사용 : 좋지 않은 선택
  Widget _genGridView(List<Photo> images, BuildContext context) {
      final orientation = MediaQuery.of(context).orientation;
      return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
          crossAxisSpacing: 10,
        ),
        children: images
            .where((e) => e.tags.contains(_query))
            .map((Photo image) {
          return SingleChildScrollView(
            child: _genPhotoData(image),
          );
        }).toList(),
      );
  }

  Widget _genPhotoData(Photo image) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            image.previewURL,
            // width: 150,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            'ID : ${image.id.toString()}',
            style: textTheme.bodyText2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            'Tags : ${image.tags}',
            style: textTheme.bodyText2,
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
          '이미지 스트림 검색 앱',
          style: TextStyle(fontSize: 20, color: Colors.black, letterSpacing: 1),
        ),
        centerTitle: true,
      ),
      // Expanded로 감싸야 renderFlex issue 제거됨!!
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 15, 5, 8),
            child: _genTextField(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _genStreamBuild(),
              ),
          ),
        ],
      ),
    );
  }
}