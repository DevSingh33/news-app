import 'package:hive/hive.dart';

part 'news_data_model.g.dart';

@HiveType(typeId: 12)
class News {
  @HiveField(10)
  final String? title;
  @HiveField(11)
  final String? description;
  @HiveField(12)
  final String? content;
  @HiveField(13)
  final String? imageUrl;
  @HiveField(14)
  final String? publishedDate;
  @HiveField(15)
  final String? source;

  News({
    required this.title,
    required this.description,
    required this.content,
    required this.imageUrl,
    required this.publishedDate,
    required this.source,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title'] ?? 'No Data Found!',
      description: json['description'] ?? 'No Data Found!',
      content: json['content'] ?? 'No Data Found!',
      imageUrl: json['urlToImage'] ??
          'https://via.placeholder.com/600x400.jpg?text=No+Image+Found!',
      publishedDate: json['publishedAt'] ?? 'No Data Found!',
      source: json['source']['name'] ?? 'No Data Found!',
    );
  }
}
