import 'package:flutter_news_cast/data/storage/key_constant.dart';
import 'package:isar/isar.dart';

part 'feed_model.g.dart';

@collection
class FeedModel {
  Id? id = Isar.autoIncrement;
  String title;
  String url;
  String description;
  String category;
  bool fullText;
  int rssType;

  FeedModel({
    this.id,
    required this.title,
    required this.url,
    required this.description,
    required this.category,
    required this.fullText,
    required this.rssType,
  });

  @override
  String toString() {
    return 'FeedModel{id: $id, title: $title, url: $url, description: $description, category: $category, fullText: $fullText, rssType: $rssType}';
  }

}
