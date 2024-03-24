import 'package:flutter_news_cast/data/api/models/rss/post_model.dart';
import 'package:get/get.dart';

import '../models/rss/feed_model.dart';
import '../models/rss/list_feed_model.dart';
import '../services/rss_service.dart';
import 'base_repository.dart';

class RssRepository extends BaseRepository {
  final _rssService = Get.find<RSSService>();

  Future<bool> isInitFirst() async {
    return _rssService.isInitFirst();
  }

  Future<List<ListFeedModel>> getInitRss() async {
    final listFeed = await _rssService.getInitRss();
    return listFeed;
  }

  Future<void> updatePostStatus(PostModel post, {DateTime? readTime, bool? bookMark, bool isSync = false}) async {
    await _rssService.updatePostStatus(post, readTime: readTime, bookMark: bookMark, isSync: isSync);
  }

  Future<List<PostModel>> getListBookmark() async {
    return await _rssService.getListBookmark();
  }

  Future<List<PostModel>> getListRecent() async {
    return await _rssService.getListRecent();
  }

  Future<bool> deleteRssFeed(FeedModel feedModel) async {
    return await _rssService.deleteRssFeed(feedModel);
  }

  Future<bool> saveRssFeed(String url) async {
    return await _rssService.saveRssFeed(url);
  }

  Future<int> getIdPost() async {
    return await _rssService.getIdPost();
  }

  Future<PostModel?> getPostBookmark(String? url) async {
    return await _rssService.getPosts(url);
  }
}
