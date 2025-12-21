class Video {
  String title;
  String author;

  Video(this.title, this.author);

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(json["title"], json["author"]);
  }
}