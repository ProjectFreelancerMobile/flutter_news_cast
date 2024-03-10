import 'package:flutter_news_cast/utils/dart_rss/domain/media/category.dart';
import 'package:flutter_news_cast/utils/dart_rss/domain/media/content.dart';
import 'package:flutter_news_cast/utils/dart_rss/domain/media/credit.dart';
import 'package:flutter_news_cast/utils/dart_rss/domain/media/rating.dart';
import 'package:flutter_news_cast/utils/dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class Group {
  static Group? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return Group(
      contents: element.findElements('media:content').map((e) => Content.parse(e)).toList(),
      credits: element.findElements('media:credit').map((e) => Credit.parse(e)).toList(),
      category: Category.parse(findElementOrNull(element, 'media:category')),
      rating: Rating.parse(findElementOrNull(element, 'media:rating')),
      thumbnail: AtomThumbnail.parse(findElementOrNull(element, 'media:thumbnail')),
    );
  }

  const Group({
    this.contents = const <Content>[],
    this.credits = const <Credit>[],
    this.category,
    this.rating,
    this.thumbnail,
  });

  final List<Content> contents;
  final List<Credit> credits;
  final Category? category;
  final Rating? rating;
  final AtomThumbnail? thumbnail;

  @override
  String toString() {
    return 'Group{contents: $contents, credits: $credits, category: $category, rating: $rating}';
  }
}

class AtomThumbnail {
  static AtomThumbnail? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    final url = element.getAttribute('url');
    final width = element.getAttribute('width');
    final height = element.getAttribute('height');
    return AtomThumbnail(url, width, height);
  }

  const AtomThumbnail(this.url, this.width, this.height);

  final String? url;
  final String? width;
  final String? height;
}
