class Video {
  final String id;
  final String topic;
  final String? description;
  final double? duration;
  final String? thumbnail;

  const Video({
    required this.id,
    required this.topic,
    this.description,
    this.duration,
    this.thumbnail,
  });

  @override
  String toString() {
    return 'Video(id: $id, topic: $topic, duration: $duration)';
  }
}
