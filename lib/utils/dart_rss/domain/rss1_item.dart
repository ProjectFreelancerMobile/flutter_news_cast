import 'package:flutter_news_cast/utils/dart_rss/domain/dublin_core/dublin_core.dart';
import 'package:flutter_news_cast/utils/dart_rss/domain/rss_content.dart';
import 'package:flutter_news_cast/utils/dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class Rss1Item {
  factory Rss1Item.parse(XmlElement element) {
    return Rss1Item(
      title: findElementOrNull(element, 'title')?.innerText,
      description: findElementOrNull(element, 'description')?.innerText,
      link: findElementOrNull(element, 'link')?.innerText,
      dc: DublinCore.parse(element),
      content: RssContent.parse(findElementOrNull(element, 'content:encoded')),
    );
  }

  const Rss1Item({
    this.title,
    this.description,
    this.link,
    this.dc,
    this.content,
  });

  final String? title;
  final String? description;
  final String? link;
  final DublinCore? dc;
  final RssContent? content;
}
