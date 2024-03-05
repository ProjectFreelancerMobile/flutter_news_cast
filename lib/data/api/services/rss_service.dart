import 'package:flutter_news_cast/utils/dart_rss/dart_rss.dart';
import 'package:flutter_news_cast/app/app_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import '../../storage/my_storage.dart';
import '../api_constants.dart';
import '../models/rss/feed_model.dart';
import '../models/rss/post_model.dart';
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

  Future<FeedModel> parseRss(
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
      return FeedModel(
        title: '',
        url: '',
        description: '',
        category: categoryName,
        fullText: false,
        openType: 0,
      );
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

  Future<DateTime?> getLatesPubDate(FeedModel feed) async {
    final List<PostModel> posts = await _isar.postModels.where().filter().feed((f) => f.idEqualTo(feed.id)).sortByPubDateDesc().findAll();
    if (posts.isNotEmpty) {
      return posts.first.pubDate;
    } else {
      return null;
    }
  }

  Future<void> deleteFeed(FeedModel feed) async {
    //await PostHelper.deletePostsByFeed(feed);
    await _isar.writeTxn(() async {
      await _isar.feedModels.delete(feed.id!);
    });
  }

  //POST
  Future<int> reslovePosts(List<FeedModel> feeds) async {
    int result = 0;
    for (final FeedModel feed in feeds) {
      bool res = await _reslovePost(feed);
      if (!res) {
        result++;
      }
    }
    return result;
  }

  Future<bool> _reslovePost(FeedModel feedModel) async {
    try {
      final response = await getWithCustomUrl(feedModel.url, '');
      final DateTime? feedLastUpdated = await getLatesPubDate(feedModel);
      try {
        RssFeed rssFeed = RssFeed.parse(response);
        List<Future> futures = [];
        for (RssItem item in rssFeed.items) {
          if (!(_parsePubDate(item.pubDate).isAfter(feedLastUpdated ?? DateTime(0)))) {
            break;
          }
          futures.add(_parseRSSPostItem(item, feedModel));
        }
        await Future.wait(futures);
        return true;
      } catch (e) {
        AtomFeed atomFeed = AtomFeed.parse(response);
        List<Future> futures = [];
        for (AtomItem item in atomFeed.items) {
          if (!(_parsePubDate(item.updated).isAfter(feedLastUpdated ?? DateTime(0)))) {
            break;
          }
          futures.add(_parseAtomPostItem(item, feedModel));
        }
        await Future.wait(futures);
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> _parseRSSPostItem(RssItem item, FeedModel feedModel) async {
    String title = item.title!.trim();
    bool blockStatue = _isBlock(title, item.description ?? '');
    if (blockStatue) {
      return;
    }
    PostModel post = PostModel(
      title: title,
      link: item.link!,
      image: item.image!,
      content: item.description ?? '',
      pubDate: _parsePubDate(item.pubDate),
      read: false,
      favorite: false,
      fullText: feedModel.fullText,
    );
    post.feed.value = feedModel;
    await savePost(post);
  }

  Future<void> _parseAtomPostItem(AtomItem item, FeedModel feedModel) async {
    String title = item.title!.trim();
    bool blockStatue = _isBlock(title, item.content ?? '');
    if (blockStatue) {
      return;
    }
    PostModel post = PostModel(
      title: title,
      link: item.links[0].href!,
      image: item.content!,
      content: item.content!,
      pubDate: _parsePubDate(item.updated),
      read: false,
      favorite: false,
      fullText: feedModel.fullText,
    );
    post.feed.value = feedModel;
    await savePost(post);
  }

  bool _isBlock(String postTitle, String content) {
    return false;
    // List<String> blockList = PrefsHelper.blockList;
    // bool blockStatue = false;
    // for (String block in blockList) {
    //   if (postTitle.contains(block) || content.contains(block)) {
    //     blockStatue = true;
    //     break;
    //   }
    // }
    // return blockStatue;
  }

  DateTime _parsePubDate(String? str) {
    if (str == null) {
      return DateTime.now();
    }
    const dateFormatPatterns = [
      'EEE, d MMM yyyy HH:mm:ss Z',
    ];
    try {
      return DateTime.parse(str);
    } catch (_) {
      for (final pattern in dateFormatPatterns) {
        try {
          final format = DateFormat(pattern);
          return format.parse(str);
        } catch (_) {}
      }
    }
    return DateTime.now();
  }

  Future<void> savePost(PostModel postModel) async {
    _isar.writeTxnSync(() {
      _isar.postModels.putSync(postModel);
    });
  }

  Future<List<PostModel>> getAllPosts() async {
    return await _isar.postModels.where().findAll();
  }

  Future<List<PostModel>> getPostsByFeeds(List<FeedModel> feeds) async {
    final List<PostModel> result = [];
    for (final FeedModel feed in feeds) {
      final List<PostModel> posts = await _isar.postModels.where().filter().feed((f) => f.idEqualTo(feed.id)).findAll();
      result.addAll(posts);
    }
    return result;
  }
}
