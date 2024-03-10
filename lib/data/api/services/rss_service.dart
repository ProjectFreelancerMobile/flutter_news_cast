import 'package:flutter_news_cast/app/app_controller.dart';
import 'package:flutter_news_cast/data/storage/key_constant.dart';
import 'package:flutter_news_cast/utils/dart_rss/dart_rss.dart';
import 'package:flutter_news_cast/utils/dart_rss/domain/json/json_feed.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

import '../../storage/my_storage.dart';
import '../api_constants.dart';
import '../models/rss/feed_model.dart';
import '../models/rss/list_feed_bookmark_model.dart';
import '../models/rss/list_feed_model.dart';
import '../models/rss/post_model.dart';
import 'base_service.dart';

class RSSService extends BaseService {
  final _storage = Get.find<MyStorage>();
  final _isar = Get.find<AppController>().isar;

  Future<List<ListFeedModel>> getInitRss({isRefresh = false}) async {
    List<ListFeedModel> listFeed = [];
    if (await _storage.isInstall() == false) {
      _storage.saveInstall(true);
      final listRssDefault = [
        ListFeedBookmarkModel(0, RSS_1, RSS_TYPE.RSS.indexValue),
        ListFeedBookmarkModel(1, RSS_2, RSS_TYPE.ATOM.indexValue),
        ListFeedBookmarkModel(2, RSS_3, RSS_TYPE.RSS.indexValue),
        ListFeedBookmarkModel(3, RSS_4, RSS_TYPE.JSON.indexValue, baseUrl: BASE_JSON_PARSE),
        ListFeedBookmarkModel(4, RSS_5, RSS_TYPE.JSON.indexValue, baseUrl: BASE_JSON_PARSE),
        ListFeedBookmarkModel(5, RSS_6, RSS_TYPE.RSS.indexValue),
      ];
      var listFeedLite = <FeedModel>[];
      await Future.forEach(listRssDefault, (element) async {
        var feedItemModel = ListFeedModel();
        await parseRss(element).then((value) async {
          listFeedLite.add(value);
          feedItemModel.feedModel = value;
          await fetchPostFromFeed(value);
          feedItemModel.listPost = await getPostsByFeeds(value);
        });
        listFeed.add(feedItemModel);
      });
      print('00000000000');
      saveListFeed(listFeedLite);
    } else if (isRefresh) {
      var listFeedLite = <FeedModel>[];
      await Future.forEach(await getFeedsDB(), (element) async {
        if (element.feedModel != null) {
          var feedItemModel = ListFeedModel();
          await parseRss(ListFeedBookmarkModel(
            element.feedModel?.id ?? 0,
            element.feedModel?.url ?? '',
            element.feedModel?.rssType ?? RSS_TYPE.RSS.indexValue,
          )).then((value) async {
            listFeedLite.add(value);
            feedItemModel.feedModel = value;
            await fetchPostFromFeed(value);
            feedItemModel.listPost = await getPostsByFeeds(value);
          });
          listFeed.add(feedItemModel);
        }
      });
      print('11111111111');
    } else {
      await getFeedsDB().then((value) {
        listFeed.addAll(value);
      });
      print('22222222222');
    }
    print('listFeed:::::${listFeed.length}');
    return listFeed;
  }

  Future<List<ListFeedModel>> getInitRssCloud({isForceReload = false}) async {
    List<ListFeedModel> listFeed = [];
    final listRssDefault = [
      // ListFeedBookmarkModel(0, RSS_1, RSS_TYPE.RSS.indexValue),
      // ListFeedBookmarkModel(1, RSS_2, RSS_TYPE.ATOM.indexValue),
      // ListFeedBookmarkModel(2, RSS_3, RSS_TYPE.RSS.indexValue),
      // ListFeedBookmarkModel(3, RSS_4, RSS_TYPE.JSON.indexValue, baseUrl: BASE_JSON_PARSE),
      // ListFeedBookmarkModel(4, RSS_5, RSS_TYPE.JSON.indexValue, baseUrl: BASE_JSON_PARSE),
      // ListFeedBookmarkModel(5, RSS_6, RSS_TYPE.RSS.indexValue),
      ListFeedBookmarkModel(6, 'https://vnexpress.net/rss/tin-moi-nhat.rss', RSS_TYPE.RSS.indexValue),
    ];
    var listFeedLite = <FeedModel>[];
    await Future.forEach(listRssDefault, (element) async {
      var feedItemModel = ListFeedModel();
      await parseRss(element).then((value) async {
        listFeedLite.add(value);
        feedItemModel.feedModel = value;
        await fetchPostFromFeed(value);
      });
      feedItemModel.listPost = await getPostsByListFeeds(listFeedLite);
      listFeed.add(feedItemModel);
    });
    return listFeed;
  }

  Future<FeedModel> parseRss(
    ListFeedBookmarkModel feedModel, [
    String? feedTitle,
  ]) async {
    final categoryName = 'defaultCategory';
    try {
      final response = await getWithUrlRss(feedModel.url);
      print('rssType.type::' + feedModel.rssType.type.toString());
      switch (feedModel.rssType.type) {
        case RSS_TYPE.RSS:
          final RssFeed rssFeed = RssFeed.parse(response);
          feedTitle = rssFeed.title;
          return FeedModel(
            id: feedModel.id,
            title: feedTitle ?? '',
            url: feedModel.url,
            description: rssFeed.description ?? '',
            category: categoryName,
            fullText: false,
            rssType: feedModel.rssType,
            baseUrl: feedModel.baseUrl,
          );
        case RSS_TYPE.ATOM:
          final AtomFeed atomFeed = AtomFeed.parse(response);
          return FeedModel(
            id: feedModel.id,
            title: atomFeed.title ?? '',
            url: feedModel.url,
            description: atomFeed.subtitle ?? '',
            category: categoryName,
            fullText: false,
            rssType: feedModel.rssType,
            baseUrl: feedModel.baseUrl,
          );
        case RSS_TYPE.JSON:
          return FeedModel(
            id: feedModel.id,
            title: feedTitle ?? '',
            url: feedModel.url,
            description: '',
            category: categoryName,
            fullText: false,
            rssType: feedModel.rssType,
            baseUrl: feedModel.baseUrl,
          );
        default:
          final RssFeed rssFeed = RssFeed.parse(response);
          feedTitle = rssFeed.title;
          return FeedModel(
            id: feedModel.id,
            title: feedTitle ?? '',
            url: feedModel.url,
            description: rssFeed.description ?? '',
            category: categoryName,
            fullText: false,
            rssType: feedModel.rssType,
            baseUrl: feedModel.baseUrl,
          );
      }
    } catch (e) {
      print('rssFeed:error:::::' + e.toString());
      Get.snackbar(
        'error'.tr,
        'resolveError'.tr,
      );
      return FeedModel(
        id: feedModel.id,
        title: '',
        url: '',
        description: '',
        category: categoryName,
        fullText: false,
        rssType: feedModel.rssType,
        baseUrl: feedModel.baseUrl,
      );
    }
  }

  Future<void> saveListFeed(List<FeedModel> listFeed) async {
    await _isar.writeTxn(() async {
      await _isar.feedModels.putAll(listFeed);
    });
  }

  Future<bool> bookmarkFeed(String url) async {
    if (await isExists(url)) {
      return false;
    }
    final response = await getWithUrlRss(url);
    RssVersion rssVersion = WebFeed.detectRssVersion(response);
    var rssType = RSS_TYPE.RSS.indexValue;
    final id = await _isar.feedModels.count() + 1;
    print('rssVersion::$rssVersion id:$id');
    switch (rssVersion) {
      case RssVersion.atom:
        rssType = RSS_TYPE.ATOM.indexValue;
        break;
      case RssVersion.rss2:
        rssType = RSS_TYPE.RSS.indexValue;
        break;
      case RssVersion.rss1:
        rssType = RSS_TYPE.RSS.indexValue;
        break;
      default:
        rssType = RSS_TYPE.JSON.indexValue;
        break;
    }
    print('url::$url rssType:$rssType');
    await parseRss(ListFeedBookmarkModel(id, url, rssType)).then((value) async {
      await _isar.writeTxn(() async {
        await _isar.feedModels.put(value);
      });
      await fetchPostFromFeed(value);
    });
    return true;
  }

  Future<bool> isExists(String url) async {
    final FeedModel? result = await _isar.feedModels.where().filter().urlEqualTo(url).findFirst();
    return result != null;
  }

  Future<List<ListFeedModel>> getFeedsDB() async {
    var listFeed = <ListFeedModel>[];
    final List<FeedModel> feeds = await _isar.feedModels.where().findAll();
    await Future.forEach(feeds, (element) async {
      var feed = ListFeedModel();
      feed.feedModel = element;
      feed.listPost = await getPostsByFeeds(element);
      listFeed.add(feed);
    });
    return listFeed;
  }

  Future<DateTime?> getLatesPubDate(FeedModel feed) async {
    final List<PostModel> posts = await _isar.postModels.where().filter().feed((f) => f.idEqualTo(feed.id)).sortByPubDateDesc().findAll();
    if (posts.isNotEmpty) {
      return posts.first.pubDate;
    } else {
      return null;
    }
  }

  Future<void> deleteBookmark(FeedModel feed) async {
    await deletePostsByFeed(feed);
    await _isar.writeTxn(() async {
      await _isar.feedModels.delete(feed.id!);
    });
  }

  //POST
  Future<int> fetchPostFromListFeed(List<FeedModel> feeds) async {
    int result = 0;
    for (final FeedModel feed in feeds) {
      bool res = await fetchPostFromFeed(feed);
      if (!res) {
        result++;
      }
    }
    return result;
  }

  Future<bool> fetchPostFromFeed(FeedModel feedModel) async {
    try {
      final response = await getWithUrlRss(feedModel.url);
      final DateTime? feedLastUpdated = await getLatesPubDate(feedModel);
      switch (feedModel.rssType.type) {
        case RSS_TYPE.RSS:
          RssFeed rssFeed = RssFeed.parse(response);
          List<Future> futures = [];
          await Future.forEach(rssFeed.items, (element) async {
            if (!(_parsePubDate(element.pubDate).isAfter(feedLastUpdated ?? DateTime(0)))) {
              return;
            }
            futures.add(_parseRSSPostItem(element, feedModel));
          });
          await Future.wait(futures);
          return true;
        case RSS_TYPE.ATOM:
          AtomFeed atomFeed = AtomFeed.parse(response);
          List<Future> futures = [];
          await Future.forEach(atomFeed.items, (element) async {
            if (!(_parsePubDate(atomFeed.updated).isAfter(feedLastUpdated ?? DateTime(0)))) {
              return;
            }
            futures.add(_parseAtomPostItem(element, feedModel));
          });
          await Future.wait(futures);
          return true;
        case RSS_TYPE.JSON:
          final JsonFeed jsonFeed = JsonFeed.fromJson(response);
          List<Future> futures = [];
          await Future.forEach(jsonFeed.list ?? List.empty(), (element) async {
            futures.add(_parseJsonPostItem(element, feedModel, baseUrl: feedModel.baseUrl));
          });
          await Future.wait(futures);
          return true;
        default:
          RssFeed rssFeed = RssFeed.parse(response);
          List<Future> futures = [];
          await Future.forEach(rssFeed.items, (element) async {
            if (!(_parsePubDate(element.pubDate).isAfter(feedLastUpdated ?? DateTime(0)))) {
              return;
            }
            futures.add(_parseRSSPostItem(element, feedModel));
          });
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
      image: item.image ?? item.enclosure?.url ?? ((item.media?.thumbnails.isNotEmpty == true) ? item.media?.thumbnails.first.url : '') ?? '',
      content: item.description ?? '',
      pubDate: _parsePubDate(item.pubDate),
      favorite: false,
      fullText: feedModel.fullText,
    );
    post.feed.value = feedModel;
    print('_parseRSSPostItem.post::' + post.toString());
    await savePost(post);
  }

  Future<void> _parseAtomPostItem(AtomItem item, FeedModel feedModel) async {
    String title = item.title!.trim();
    bool blockStatue = _isBlock(title, item.content ?? '');
    if (blockStatue) {
      return;
    }
    print('_parseAtomPostItem.post::' + item.media.toString());
    PostModel post = PostModel(
      title: title,
      link: item.links[0].href ?? '',
      image: item.media?.group?.thumbnail?.url ?? item.image ?? '',
      content: item.content ?? '',
      pubDate: _parsePubDate(item.updated),
      favorite: false,
      fullText: feedModel.fullText,
    );
    post.feed.value = feedModel;
    await savePost(post);
  }

  Future<void> _parseJsonPostItem(JsonItem item, FeedModel feedModel, {String? baseUrl}) async {
    String title = item.title!.trim();
    bool blockStatue = _isBlock(title, item.title ?? '');
    if (blockStatue) {
      return;
    }
    PostModel post = PostModel(
      title: title,
      link: '$baseUrl${item.id}',
      image: '',
      content: title,
      pubDate: DateTime.now(),
      favorite: false,
      fullText: feedModel.fullText,
    );
    post.feed.value = feedModel;
    print('_parseRSSPostItem.post::' + post.toString());
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

  Future<void> saveListPost(List<PostModel> listPost) async {
    await _isar.writeTxn(() async {
      await _isar.postModels.putAll(listPost);
    });
  }

  Future<void> savePost(PostModel postModel) async {
    _isar.writeTxnSync(() {
      _isar.postModels.putSync(postModel);
    });
  }

  Future<List<PostModel>> getAllPosts() async {
    return await _isar.postModels.where().findAll();
  }

  Future<List<PostModel>> getPostsByListFeeds(List<FeedModel> feeds) async {
    final List<PostModel> result = [];
    for (final FeedModel feed in feeds) {
      final List<PostModel> posts = await _isar.postModels.where().filter().feed((f) => f.idEqualTo(feed.id)).findAll();
      result.addAll(posts);
    }
    return result;
  }

  Future<List<PostModel>> getPostsByFeeds(FeedModel feedModel) async {
    final List<PostModel> posts = await _isar.postModels.where().filter().feed((f) => f.idEqualTo(feedModel.id)).findAll();
    return posts;
  }

  Future<void> deletePostsByFeed(FeedModel feed) async {
    final List<PostModel> posts = await getPostsByFeeds(feed);
    await _isar.writeTxn(() async {
      await _isar.postModels.deleteAll(posts.map((e) => e.id!).toList());
    });
  }

  Future<void> updatePostStatus(PostModel post, {DateTime? readTime, bool? bookMark}) async {
    post.readDate = readTime ?? post.readDate;
    post.favorite = bookMark ?? post.favorite;
    await savePost(post);
  }

  Future<List<PostModel>> getListBookmark() async {
    final List<PostModel> posts = await _isar.postModels.where().filter().favoriteEqualTo(true).findAll();
    return posts;
  }

  Future<List<PostModel>> getListRecent() async {
    final List<PostModel> posts = await _isar.postModels.where().filter().readDateIsNotNull().sortByReadDate().findAll();
    return posts;
  }
}
