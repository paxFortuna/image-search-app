class Video {
  final String videoId;
  final String tags;
  final Videos videos;

  Video({
    required this.videoId,
    required this.tags,
    required this.videos,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      videoId: json['picutre_id'] as String,
      tags: json['tags'] as String,
      videos: Videos.fromJson(json['videos'] as Map<String, dynamic>),
    );
  }
}

class Videos {
  final Map<String, dynamic> large;
  final Map<String, dynamic> medium;
  final Map<String, dynamic> small;

  Videos({
    required this.large,
    required this.medium,
    required this.small,
  });

  factory Videos.fromJson(Map<String, dynamic> json) {
    return Videos(
      large: json['large'] as Map<String, dynamic>,
      medium: json['medium'] as Map<String, dynamic>,
      small: json['small'] as Map<String, dynamic>,
    );
  }
}