import 'package:flutter_news_cast/data/api/models/rss/feed_model.dart';
import 'package:isar/isar.dart';

part 'post_model.g.dart';

@collection
class PostModel {
  Id? id = Isar.autoIncrement;
  final feed = IsarLink<FeedModel>();
  String title;
  String link;
  String content;
  DateTime pubDate;
  bool read;
  bool favorite;
  bool fullText;

  PostModel({
    this.id,
    required this.title,
    required this.link,
    required this.content,
    required this.pubDate,
    required this.read,
    required this.favorite,
    required this.fullText,
  });

  @override
  String toString() {
    return 'PostModel{id: $id, feed: $feed, title: $title, link: $link, content: $content, pubDate: $pubDate, read: $read, favorite: $favorite, fullText: $fullText}';
  }

}
