class Video {
  final String thumbnail;
  final String tags;
  final Videos videos;

  Video({
    required this.thumbnail,
    required this.tags,
    required this.videos,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    String videoId = json['picture_id'] as String;
    return Video(
      thumbnail: 'https://i.vimeocdn.com/video/${videoId}_295x166.jpg',
      tags: json['tags'] as String,
      videos: Videos.fromJson(json['videos'] as Map<String, dynamic>),
    );
  }
}

class Videos {
  final large;
  final medium;
  final small;

  Videos({
    required this.large,
    required this.medium,
    required this.small,
  });

  factory Videos.fromJson(Map<String, dynamic> json) {
    return Videos(
      large: Large.fromJson(json['large']),
      medium: Medium.fromJson(json['medium']),
      small: Small.fromJson(json['small']),
    );
  }
}
class Large {
  final String url;
  Large({required this.url});
  factory Large.fromJson(Map<String, dynamic> json) => Large(
    url: json['url'] as String,
  );
}

class Medium {
  final String url;
  Medium({required this.url});
  factory Medium.fromJson(Map<String, dynamic> json) => Medium(
    url: json['url'] as String,
  );
}

class Small {
  final String url;
  Small({required this.url});
  factory Small.fromJson(Map<String, dynamic> json) => Small(
    url: json['url'] as String,
  );
}