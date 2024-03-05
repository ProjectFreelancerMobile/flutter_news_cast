import 'package:flutter_news_cast/utils/dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

class RssPodcastIndexGuid {
  static RssPodcastIndexGuid? parse(XmlElement? element) {
    if (element == null) {
      return null;
    }

    return RssPodcastIndexGuid(
      isPermalink: parseBool(element.getAttribute("isPermaLink")),
      value: element.innerText,
    );
  }

  const RssPodcastIndexGuid({
    this.isPermalink,
    this.value,
  });

  final bool? isPermalink;
  final String? value;

  @override
  String toString() {
    return 'RssPodcastIndexGuid{isPermalink: $isPermalink, value: $value}';
  }
}
