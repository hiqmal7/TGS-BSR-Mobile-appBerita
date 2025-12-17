class NewsModel {
  final String title;
  final String description;
  final String content;
  final String imageUrl;
  final String publishedAt;

  NewsModel({
    required this.title,
    required this.description,
    required this.content,
    required this.imageUrl,
    required this.publishedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}
