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
  int openType; //Open method: 0-Reader 1-Built-in tab 2-System browser

  FeedModel({
    this.id,
    required this.title,
    required this.url,
    required this.description,
    required this.category,
    required this.fullText,
    required this.openType,
  });

  @override
  String toString() {
    return 'FeedModel{id: $id, title: $title, url: $url, description: $description, category: $category, fullText: $fullText, openType: $openType}';
  }

}
