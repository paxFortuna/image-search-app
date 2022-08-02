class Photo {
  final int id;
  final String previewURL;
  final String tags;

  Photo({
    required this.id,
    required this.previewURL,
    required this.tags,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as int,
      previewURL: json['previewURL'] as String,
      tags: json['tags'] as String,
    );
  }

  @override
  String toString() {
    return 'Photo{id: $id, previewURL: $previewURL, tags: $tags}';
  }
}