import 'package:flutter_news_cast/utils/dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class RssItunesOwner {
  static RssItunesOwner? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return RssItunesOwner(
      name: findElementOrNull(element, 'itunes:name')?.innerText.trim(),
      email: findElementOrNull(element, 'itunes:email')?.innerText.trim(),
    );
  }

  const RssItunesOwner({this.name, this.email});

  final String? name;
  final String? email;
}
