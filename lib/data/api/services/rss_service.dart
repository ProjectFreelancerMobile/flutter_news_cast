import 'package:dart_rss/dart_rss.dart';
import 'package:get/get.dart';

import '../../storage/my_storage.dart';
import '../models/rss/feed_model.dart';
import 'base_service.dart';

class RSSService extends BaseService {
  final _storage = Get.find<MyStorage>();

  Future<FeedModel?> parseRss(
    String url, [
    String? feedTitle,
  ]) async {
    final categoryName = 'defaultCategory';
    try {
      final response = await get(url);
      final postXmlString = response.data;
      print('rssFeed:::::' + postXmlString.toString());
      try {
        final RssFeed rssFeed = RssFeed.parse(postXmlString);
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
        final AtomFeed atomFeed = AtomFeed.parse(postXmlString);
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

  /// Parse the feed
  /// Parameter: feed address
  /// Returns: [Feed] object
  /// NOTE: Consider both RSS and Atom formats
/* static Future<Feed?> parse(
      String url, [
        String? categoryName,
        String? feedTitle,
      ]) async {
    categoryName ??= 'defaultCategory'.tr;
    try {
      final Dio dio = appDio.dio;
      final response = await dio.get(url);
      final postXmlString = response.data;
      try {
        */ /* 使用 RSS 格式解析 */ /*
        final RssFeed rssFeed = RssFeed.parse(postXmlString);
        print('rssFeed:::::'+ rssFeed.toString());
        feedTitle = rssFeed.title;
        return Feed(
          title: feedTitle ?? '',
          url: url,
          description: rssFeed.description ?? '',
          category: categoryName,
          fullText: false,
          openType: 0,
        );
      } catch (e) {
        print('e:::::'+ e.toString());
        */ /* 使用 Atom 格式解析 */ /*
        final AtomFeed atomFeed = AtomFeed.parse(postXmlString);
        return Feed(
          title: atomFeed.title ?? '',
          url: url,
          description: atomFeed.subtitle ?? '',
          category: categoryName,
          fullText: false,
          openType: 0,
        );
      }
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'resolveError'.tr,
      );
      return null;
    }
  }

  /// 保存订阅源到 Isar
  static Future<void> saveToIsar(Feed feed) async {
    await isar.writeTxn(() async {
      await isar.feeds.put(feed);
    });
  }

  /// 根据 url 判断 Isar 数据库中是否已存在
  static Future<Feed?> isExists(String url) async {
    final Feed? result =
    await isar.feeds.where().filter().urlEqualTo(url).findFirst();
    return result;
  }

  /// 从 Isar 获取所有订阅源
  static Future<List<Feed>> getFeeds() async {
    final List<Feed> feeds = await isar.feeds.where().findAll();
    return feeds;
  }

  /// 获取 Feed 所属的 Post 最新 pubDate
  static Future<DateTime?> getLatesPubDate(Feed feed) async {
    final List<Post> posts = await isar.posts
        .where()
        .filter()
        .feed((f) => f.idEqualTo(feed.id))
        .sortByPubDateDesc()
        .findAll();
    if (posts.isNotEmpty) {
      return posts.first.pubDate;
    } else {
      return null;
    }
  }

  /// 删除订阅源
  static Future<void> deleteFeed(Feed feed) async {
    await PostHelper.deletePostsByFeed(feed);
    await isar.writeTxn(() async {
      await isar.feeds.delete(feed.id!);
    });
  }

  //
  /// 保存 Post 到 Isar
  static Future<void> savePost(Post post) async {
    isar.writeTxnSync(() {
      isar.posts.putSync(post);
    });
  }

  /// 解析 List<Feed> 返回失败数量
  static Future<int> reslovePosts(List<Feed> feeds) async {
    int result = 0;
    for (final Feed feed in feeds) {
      bool res = await _reslovePost(feed);
      if (!res) {
        result++;
      }
    }
    return result;
  }

  /// 获取所有 Post
  static Future<List<Post>> getAllPosts() async {
    return await isar.posts.where().findAll();
  }

  /// 通过 List<Feed> 从 Isar 数据库获取关联的 Post
  static Future<List<Post>> getPostsByFeeds(List<Feed> feeds) async {
    final List<Post> result = [];
    for (final Feed feed in feeds) {
      final List<Post> posts = await isar.posts
          .where()
          .filter()
          .feed((f) => f.idEqualTo(feed.id))
          .findAll();
      result.addAll(posts);
    }
    return result;
  }

  /// 从 title 和 content 中搜索
  static Future<List<Post>> search(String value) async {
    if (value.isEmpty) {
      return [];
    }
    final List<Post> result = await isar.posts
        .where()
        .filter()
        .titleContains(value)
        .or()
        .contentContains(value)
        .findAll();
    return result;
  }

  /// 删除所有 feed 为指定 Feed 的 Post
  static Future<void> deletePostsByFeed(Feed feed) async {
    final List<Post> posts = await getPostsByFeeds([feed]);
    await isar.writeTxn(() async {
      await isar.posts.deleteAll(posts.map((e) => e.id!).toList());
    });
  }

  /// 修改 Post 阅读状态
  static Future<void> updatePostReadStatus(Post post, {bool? read}) async {
    post.read = read ?? !post.read;
    await savePost(post);
  }

  /// 全标已读
  static Future<void> mardPostsAsRead(List<Post> posts) async {
    for (final Post post in posts) {
      post.read = true;
    }
    await isar.writeTxn(() async {
      await isar.posts.putAll(posts);
    });
  }

  /// 解析 Feed, 获取更新
  static Future<bool> _reslovePost(Feed feed) async {
    try {
      final Dio dio = appDio.dio;
      final response = await dio.get(feed.url);
      final postXmlString = response.data;
      final DateTime? feedLastUpdated = await FeedHelper.getLatesPubDate(feed);
      try {
        */ /* 使用 RSS 格式解析 */ /*
        RssFeed rssFeed = RssFeed.parse(postXmlString);
        List<Future> futures = [];
        for (RssItem item in rssFeed.items) {
          if (!(_parsePubDate(item.pubDate)
              .isAfter(feedLastUpdated ?? DateTime(0)))) {
            break;
          }
          futures.add(_parseRSSPostItem(item, feed));
        }
        await Future.wait(futures);
        return true;
      } catch (e) {
        */ /* 使用 Atom 格式解析 */ /*
        AtomFeed atomFeed = AtomFeed.parse(postXmlString);
        List<Future> futures = [];
        for (AtomItem item in atomFeed.items) {
          if (!(_parsePubDate(item.updated)
              .isAfter(feedLastUpdated ?? DateTime(0)))) {
            break;
          }
          futures.add(_parseAtomPostItem(item, feed));
        }
        await Future.wait(futures);
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  /// 使用 RSS 格式解析 [RssItem]，存入数据库
  static Future<void> _parseRSSPostItem(RssItem item, Feed feed) async {
    */ /* 判断是否屏蔽 */ /*
    String title = item.title!.trim();
    bool blockStatue = _isBlock(title, item.description ?? '');
    if (blockStatue) {
      return;
    }
    Post post = Post(
      title: title,
      link: item.link!,
      content: item.description ?? '',
      pubDate: _parsePubDate(item.pubDate),
      read: false,
      favorite: false,
      fullText: feed.fullText,
    );
    post.feed.value = feed;
    await savePost(post);
  }

  /// 使用 RSS 格式解析 [AtomItem]，存入数据库
  static Future<void> _parseAtomPostItem(AtomItem item, Feed feed) async {
    */ /* 判断是否屏蔽 */ /*
    String title = item.title!.trim();
    bool blockStatue = _isBlock(title, item.content ?? '');
    if (blockStatue) {
      return;
    }
    Post post = Post(
      title: title,
      link: item.links[0].href!,
      content: item.content!,
      pubDate: _parsePubDate(item.updated),
      read: false,
      favorite: false,
      fullText: feed.fullText,
    );
    post.feed.value = feed;
    await savePost(post);
  }

  /// 通过 title 判断 [Post] 是否屏蔽
  static bool _isBlock(String postTitle, String content) {
    List<String> blockList = PrefsHelper.blockList;
    bool blockStatue = false;
    for (String block in blockList) {
      if (postTitle.contains(block) || content.contains(block)) {
        blockStatue = true;
        break;
      }
    }
    return blockStatue;
  }

  /// Post pubDate 格式转换
  static DateTime _parsePubDate(String? str) {
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
  }*/

// Future<TokenModel?> tokenModel() async => await _storage.getDeviceToken();
//
// Future<String> getNameFarm(List<FarmItem>? listFarm) async {
//   final token = await tokenModel();
//   final farm = listFarm?.firstWhere((element) => element.fkey == token?.fk);
//   return Future.value(farm?.name ?? textLocalization('service.manager.my'));
// }
//
// Future<FarmItem?> getFarmDetail(String? fk) async {
//   final token = await tokenModel();
//   final params = {"uk": token?.uk, "fk": fk ?? token?.fk};
//   final response = await post(GET_FARM, data: params);
//   if (response.data != null) {
//     return FarmItem.fromJson(response.data);
//   } else {
//     return null;
//   }
// }
//
// Future<List<FarmItem>?> getListFarm() async {
//   final token = await tokenModel();
//   final params = {"uk": token?.uk};
//   final response = await post(GET_ALL_FARM, data: params);
//   if (response.data != null) {
//     return List<FarmItem>.from(response.data.map((item) => FarmItem.fromJson(item)));
//   } else {
//     return null;
//   }
// }
//
// Future<ApiResponse> createFarm({required String name, required String acreage, required String unit, required String address}) async {
//   final token = await tokenModel();
//   final params = {"uk": token?.uk, "name": name, "acreage": acreage, "unit": unit, "address": address};
//   return await post(CREATE_FARM, data: params);
// }
//
// Future<ApiResponse> updateFarm({required String fk, required String name, required String acreage, required String unit, required String address}) async {
//   final token = await tokenModel();
//   final params = {"uk": token?.uk, "fk": fk, "name": name, "acreage": acreage, "unit": unit, "address": address};
//   return await post(UPDATE_FARM, data: params);
// }
//
// Future<List<ProvinceItem>?> getListProvince() async {
//   final token = await tokenModel();
//   final params = {"uk": token?.uk, "fk": token?.fk};
//   final response = await post(REGION_PROVINCE, data: params);
//   if (response.data != null) {
//     return List<ProvinceItem>.from(response.data.map((item) => ProvinceItem.fromJson(item)));
//   } else {
//     return null;
//   }
// }
//
// Future<List<ProvinceItem>?> getListDistrict(String code) async {
//   final token = await tokenModel();
//   final params = {"uk": token?.uk, "fk": token?.fk, "code": code};
//   final response = await post(REGION_DISTRICT, data: params);
//   if (response.data != null) {
//     return List<ProvinceItem>.from(response.data.map((item) => ProvinceItem.fromJson(item)));
//   } else {
//     return null;
//   }
// }
//
// Future<List<ProvinceItem>?> getListWard(String code) async {
//   final token = await tokenModel();
//   final params = {"uk": token?.uk, "fk": token?.fk, "code": code};
//   final response = await post(REGION_WARD, data: params);
//   if (response.data != null) {
//     return List<ProvinceItem>.from(response.data.map((item) => ProvinceItem.fromJson(item)));
//   } else {
//     return null;
//   }
// }
}
