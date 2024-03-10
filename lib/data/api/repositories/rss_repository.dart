import 'package:flutter_news_cast/data/api/models/rss/list_feed_bookmark_model.dart';
import 'package:flutter_news_cast/data/api/models/rss/post_model.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

import '../../storage/key_constant.dart';
import '../models/rss/feed_model.dart';
import '../models/rss/list_feed_model.dart';
import '../services/rss_service.dart';
import 'base_repository.dart';

class RssRepository extends BaseRepository {
  final _rssService = Get.find<RSSService>();

  Future<List<ListFeedModel>> getInitRss({isRefresh = false}) async {
    final listFeed = await _rssService.getInitRss(isRefresh: isRefresh);
    return listFeed;
  }

  Future<FeedModel> getFeed(String url) async {
    final feed = await _rssService.parseRss(ListFeedBookmarkModel(Isar.autoIncrement, url, RSS_TYPE.RSS.indexValue));
    return feed;
  }

  Future<List<PostModel?>> getPostsByListFeeds(List<FeedModel> feeds) async {
    await _rssService.fetchPostFromListFeed(feeds);
    final listPost = await _rssService.getPostsByListFeeds(feeds);
    return listPost;
  }

  Future<List<PostModel?>> getPostsByFeeds(FeedModel feedModel) async {
    await _rssService.fetchPostFromFeed(feedModel);
    final listPost = await _rssService.getPostsByFeeds(feedModel);
    print('getPostsByFeeds:${listPost.length}');
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

  Future<void> deleteBookmark(FeedModel feedModel) async {
    return await _rssService.deleteBookmark(feedModel);
  }

  Future<bool> bookmarkFeed(String url) async {
    return await _rssService.bookmarkFeed(url);
  }
}
