class Video {
  final String id;
  final String topic;
  final String? description;
  final double? duration;
  final String? thumbnail;
  final String? videoUrl;

  const Video({
    required this.id,
    required this.topic,
    this.description,
    this.duration,
    this.thumbnail,
    this.videoUrl,
  });

  @override
  String toString() {
    return 'Video(id: $id, topic: $topic, duration: $duration, description: $description)';
  }
}
