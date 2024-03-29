import 'package:flutter_news_cast/utils/dart_rss/domain/dublin_core/dublin_core.dart';
import 'package:flutter_news_cast/utils/dart_rss/domain/media/media.dart';
import 'package:flutter_news_cast/utils/dart_rss/domain/rss_category.dart';
import 'package:flutter_news_cast/utils/dart_rss/domain/rss_content.dart';
import 'package:flutter_news_cast/utils/dart_rss/domain/rss_enclosure.dart';
import 'package:flutter_news_cast/utils/dart_rss/domain/rss_item_itunes.dart';
import 'package:flutter_news_cast/utils/dart_rss/domain/rss_item_podcast_index.dart';
import 'package:flutter_news_cast/utils/dart_rss/domain/rss_source.dart';
import 'package:flutter_news_cast/utils/dart_rss/util/helpers.dart';
import 'package:xml/xml.dart';

import 'media/group.dart';

class RssItem {
  factory RssItem.parse(XmlElement element) {
    final description = findElementOrNull(element, 'description')?.innerText ?? '';
    var imagePost = null;
    final thumbnail = findElementOrNull(element, 'media:thumbnail');
    if (thumbnail != null) {
      imagePost = AtomThumbnail.parse(findElementOrNull(element, 'media:thumbnail'))?.url ?? '';
    } else if (description.contains('<img src=')) {
      if (description.contains('" /></a>')) {
        imagePost = description.substring(description.indexOf('<img src="') + 10, description.indexOf('" /></a>')); // Thanh Nien
      } else if (description.contains('" ></a>')) {
        imagePost = description.substring(description.indexOf('<img src="') + 10, description.indexOf('" ></a>')); //Vnexpress
      } else {
        imagePost = description.substring(description.indexOf('<img src=') + 10, description.indexOf('\'/></a>')); //Dan tri
      }
      //print('imagePost::' + imagePost);
    }
    return RssItem(
      title: findElementOrNull(element, 'title')?.innerText,
      description: description,
      link: findElementOrNull(element, 'link')?.innerText,
      categories: element.findElements('category').map((element) => RssCategory.parse(element)).toList(),
      guid: findElementOrNull(element, 'guid')?.innerText,
      pubDate: findElementOrNull(element, 'pubDate')?.innerText,
      author: findElementOrNull(element, 'author')?.innerText,
      comments: findElementOrNull(element, 'comments')?.innerText,
      source: RssSource.parse(findElementOrNull(element, 'source')),
      content: RssContent.parse(findElementOrNull(element, 'content:encoded')),
      media: Media.parse(element),
      enclosure: RssEnclosure.parse(findElementOrNull(element, 'enclosure')),
      dc: DublinCore.parse(element),
      itunes: RssItemItunes.parse(element),
      podcastIndex: RssItemPodcastIndex.parse(element),
      image: imagePost,
    );
  }

  const RssItem({
    this.title,
    this.description,
    this.link,
    this.image,
    this.categories = const <RssCategory>[],
    this.guid,
    this.pubDate,
    this.author,
    this.comments,
    this.source,
    this.content,
    this.media,
    this.enclosure,
    this.dc,
    this.itunes,
    this.podcastIndex,
  });

  final String? title;
  final String? description;
  final String? link;
  final String? image;
  final List<RssCategory> categories;
  final String? guid;
  final String? pubDate;
  final String? author;
  final String? comments;
  final RssSource? source;
  final RssContent? content;
  final Media? media;
  final RssEnclosure? enclosure;
  final DublinCore? dc;
  final RssItemItunes? itunes;
  final RssItemPodcastIndex? podcastIndex;
}
