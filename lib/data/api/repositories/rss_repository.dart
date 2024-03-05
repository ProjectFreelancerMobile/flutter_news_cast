import 'package:flutter_news_cast/data/api/models/rss/post_model.dart';
import 'package:get/get.dart';

import '../models/rss/feed_model.dart';
import '../services/rss_service.dart';
import 'base_repository.dart';

class RssRepository extends BaseRepository {
  final _rssService = Get.find<RSSService>();

  Future<List<FeedModel>> getInitRss() async {
    final listFeed = await _rssService.getInitRss();
    return listFeed;
  }

  Future<FeedModel> getFeed(String url) async {
    final feed = await _rssService.parseRss(url);
    return feed;
  }

  Future<List<PostModel?>> getPostsByFeeds(List<FeedModel> feeds) async {
    await _rssService.reslovePosts(feeds);
    final listPost = await _rssService.getPostsByFeeds(feeds);
    return listPost;
  }

  Future<void> updatePostStatus(PostModel post, {DateTime? readTime, bool? bookMark}) async {
    await _rssService.updatePostStatus(post, readTime: readTime, bookMark: bookMark);
  }

  Future<List<PostModel>> getListBookmark() async {
    return await _rssService.getListBookmark();
  }

  Future<List<PostModel>> getListRecent() async {
    return await _rssService.getListRecent();
  }
}
