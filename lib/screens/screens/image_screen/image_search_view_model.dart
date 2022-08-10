import 'package:flutter/material.dart';

import '../../../fetch_api/photo_api.dart';
import '../../../models/photo.dart';

class ImageSearchViewModel extends ChangeNotifier {
  final _photoApi = PhotoApi();
  List<Photo> images = [];

  void fetchImage(String query) async {
    images = await _photoApi.fetchImage(query);
    notifyListeners();
  }

}