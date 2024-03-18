import 'package:flutter_news_cast/data/api/models/rss/feed_model.dart';
import 'package:isar/isar.dart';

part 'post_model.g.dart';

@collection
class PostModel {
  Id? id = Isar.autoIncrement;
  final feed = IsarLink<FeedModel>();
  String title;
  String link;
  String image;
  String content;
  DateTime pubDate;
  DateTime? readDate;
  bool favorite;
  bool fullText;

  PostModel({
    this.id,
    this.readDate,
    required this.title,
    required this.link,
    required this.image,
    required this.content,
    required this.pubDate,
    required this.favorite,
    required this.fullText,
  });

  @override
  String toString() {
    return 'PostModel{id: $id, feed: $feed, title: $title, link: $link, readDate: $readDate, favorite: $favorite}';
  }
}
