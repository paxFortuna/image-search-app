import 'package:flutter/material.dart';

import '../../../fetch_api/photo_api.dart';
import '../../../models/photo.dart';

class ImageSearchViewModel extends ChangeNotifier {
  final _photoApi = PhotoApi();
  List<Photo> images = [];
  bool isLoading = false;

  void fetchImage(String query) async {
    isLoading = true;
    notifyListeners();

    images = await _photoApi.fetchImage(query);
    isLoading = false;
    notifyListeners();
  }

}