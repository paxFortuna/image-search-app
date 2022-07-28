import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_search_app/models/video.dart';

class VideoApi{
  Future<List<Video>> getVideos(String videoQuery) async {
    Uri url = Uri.parse(
       'https://pixabay.com/api/videos/?key=26655862-d25160d651ed15b14be08cf35'
           '&q=$videoQuery');

    http.Response response = await http.get(url);
    print('Response status: ${response.statusCode}');

    String jsonString = response.body;
    Map<String, dynamic> json = jsonDecode(jsonString);
    Iterable hits = json['hits'];
    return hits.map((e) => Video.fromJson(e)).toList();
  }
}

