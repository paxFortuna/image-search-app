import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_search_app/fetch.dart';
import 'package:image_search_app/models/photo.dart';
// import 'package:http/http.dart' as http;

class ImageSearchApp extends StatefulWidget {
  const ImageSearchApp({Key? key}) : super(key: key);

  @override
  State<ImageSearchApp> createState() => _ImageSearchAppState();
}

class _ImageSearchAppState extends State<ImageSearchApp> {

  final _controller = TextEditingController();
  String _query = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void initData() async {
    await getImage(_query);
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '이미지 검색 앱',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                suffixIcon: GestureDetector(
                  onTap: (){
                    // 키보드 닫기 이벤트 처리
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState((){
                      _query = _controller.text;
                    });
                  },
                    child: const Icon(Icons.search),),
                hintText: '검색어를 입력하세요',
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<Photo>>(
                  future: getImage(_query),
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

                    return GridView(
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      children: images
                          .where((e) => e.tags.contains(_query))
                          .map((Photo image) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            image.previewURL,
                            fit: BoxFit.cover,
                          ),
                        );
                      }).toList(),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
