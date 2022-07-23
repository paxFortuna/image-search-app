class Photo {
  final String previewURL;
  final String tags;

  Photo({
    required this.previewURL,
    required this.tags,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      previewURL: json['previewURL'] as String,
      tags: json['tags'] as String,
    );
  }
}