import 'package:isar/isar.dart';

part 'feed_model.g.dart';

@collection
class FeedModel {
  Id? id;
  String title;
  String url;
  String description;
  String category;
  String icon;
  bool fullText;
  int rssType;
  String? baseUrl;
  String? hostUrl;
  int type;

  FeedModel({
    this.id,
    required this.title,
    required this.url,
    required this.description,
    required this.icon,
    required this.category,
    required this.fullText,
    required this.rssType,
    required this.type,
    this.hostUrl,
    this.baseUrl,
  });

  @override
  String toString() {
    return 'FeedModel{id: $id, title: $title, url: $url, icon:$icon, description: $description, category: $category, fullText: $fullText, rssType: $rssType, type:$type, baseUrl:$baseUrl}';
  }
}
