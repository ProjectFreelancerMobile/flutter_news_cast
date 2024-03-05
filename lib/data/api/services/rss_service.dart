import 'package:dart_rss/dart_rss.dart';
import 'package:flutter_news_cast/app/app_controller.dart';
import 'package:get/get.dart';
import 'package:isar/isar.dart';

import '../../storage/my_storage.dart';
import '../api_constants.dart';
import '../models/rss/feed_model.dart';
import 'base_service.dart';

class RSSService extends BaseService {
  final _storage = Get.find<MyStorage>();
  final _isar = Get.find<AppController>().isar;

  Future<List<FeedModel>> getInitRss({isForceReload = false}) async {
    List<FeedModel> listFeed = [];
    if (await _storage.isInstall() == false || isForceReload) {
      _storage.saveInstall(true);
      final listRssDefault = [RSS_1, RSS_2, RSS_3]; //, RSS_4, RSS_5
      await Future.forEach(listRssDefault, (element) async {
        await parseRss(element).then((value) {
          if (value != null) {
            listFeed.add(value);
          }
        });
      });
      print('listRssDefault000::${listFeed.length}');
      bookmarkListFeed(listFeed);
    } else {
      await getFeeds().then((value) {
        if (value.isNotEmpty) {
          listFeed.addAll(value);
        } else {
          getInitRss(isForceReload: true);
        }
      });
      print('listRssDefault111::${listFeed.toString()}');
    }
    return listFeed;
  }

  Future<FeedModel?> parseRss(
    String url, [
    String? feedTitle,
  ]) async {
    final categoryName = 'defaultCategory';
    try {
      final response = await getWithCustomUrl(url, '');
      print('rssFeed:::::' + response.toString());
      try {
        final RssFeed rssFeed = RssFeed.parse(response);
        print('rssFeed:::::' + rssFeed.toString());
        feedTitle = rssFeed.title;
        return FeedModel(
          title: feedTitle ?? '',
          url: url,
          description: rssFeed.description ?? '',
          category: categoryName,
          fullText: false,
          openType: 0,
        );
      } catch (e) {
        print('rssFeed:error:::::' + e.toString());
        final AtomFeed atomFeed = AtomFeed.parse(response);
        return FeedModel(
          title: atomFeed.title ?? '',
          url: url,
          description: atomFeed.subtitle ?? '',
          category: categoryName,
          fullText: false,
          openType: 0,
        );
      }
    } catch (e) {
      print('rssFeed:error:::::' + e.toString());
      Get.snackbar(
        'error'.tr,
        'resolveError'.tr,
      );
      return null;
    }
  }

  Future<void> bookmarkListFeed(List<FeedModel> listFeed) async {
    await _isar.writeTxn(() async {
      await _isar.feedModels.putAll(listFeed);
    });
  }

  Future<void> bookmarkFeed(FeedModel feedModel) async {
    await _isar.writeTxn(() async {
      await _isar.feedModels.put(feedModel);
    });
  }

  Future<FeedModel?> isExists(String url) async {
    final FeedModel? result = await _isar.feedModels.where().filter().urlEqualTo(url).findFirst();
    return result;
  }

  Future<List<FeedModel>> getFeeds() async {
    final List<FeedModel> feeds = await _isar.feedModels.where().findAll();
    return feeds;
  }

  // static Future<DateTime?> getLatesPubDate(FeedModel feed) async {
  //   final List<Post> posts = await isar.posts
  //       .where()
  //       .filter()
  //       .feed((f) => f.idEqualTo(feed.id))
  //       .sortByPubDateDesc()
  //       .findAll();
  //   if (posts.isNotEmpty) {
  //     return posts.first.pubDate;
  //   } else {
  //     return null;
  //   }
  // }

  Future<void> deleteFeed(FeedModel feed) async {
    //await PostHelper.deletePostsByFeed(feed);
    await _isar.writeTxn(() async {
      await _isar.feedModels.delete(feed.id!);
    });
  }
}
