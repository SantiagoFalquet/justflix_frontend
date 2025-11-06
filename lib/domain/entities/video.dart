class Video {
  String id;
  String? topic;
  String? description;
  num? duration;
  String? thumbnail;

  Video(
      {
        required this.id,
        this.topic,
        this.description,
        this.duration,
        this.thumbnail
      });

  @override
  String toString() {
    return '''
    \x1B[34mid:\t\t\x1B[36m$id\n\x1B[0m
    \x1B[34mtopic:\t\x1B[36m$topic\n\x1B[0m
    \x1B[34mdescription:\t\x1B[36m$description\n\x1B[0m
    \x1B[34mduration:\t\t\x1B[36m$duration\n\x1B[0m
    \x1B[34mthumbnail:\t\x1B[36m$thumbnail\n\x1B[0m
    ''';
  }
}
