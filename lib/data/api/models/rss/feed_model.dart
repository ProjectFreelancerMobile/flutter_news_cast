import 'package:isar/isar.dart';

part 'feed_model.g.dart';

@collection
class FeedModel {
  Id? id;
  String title;
  String url;
  String description;
  String category;
  bool fullText;
  int rssType;
  String? baseUrl;

  FeedModel({
    this.id,
    required this.title,
    required this.url,
    required this.description,
    required this.category,
    required this.fullText,
    required this.rssType,
    this.baseUrl,
  });

  @override
  String toString() {
    return 'FeedModel{id: $id, title: $title, url: $url, description: $description, category: $category, fullText: $fullText, rssType: $rssType, baseUrl:$baseUrl}';
  }
}
