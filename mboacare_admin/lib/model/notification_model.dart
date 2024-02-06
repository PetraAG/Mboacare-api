class Notify {
  final String content;
  final String title;
  final String pubDate;

  Notify({
    required this.content,
    required this.title,
    required this.pubDate,
  });

  factory Notify.fromJson(Map<String, dynamic> json) {
    return Notify(
      content: json['content'],
      title: json['title'],
      pubDate: json['pubDate'],
    );
  }
}
