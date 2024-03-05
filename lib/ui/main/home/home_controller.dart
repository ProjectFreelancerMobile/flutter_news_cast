// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter_news_cast/data/api/models/rss/feed_model.dart';
import 'package:flutter_news_cast/data/api/models/rss/post_model.dart';
import 'package:flutter_news_cast/data/api/repositories/rss_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../app/app_controller.dart';
import '../../../data/api/api_constants.dart';
import '../../../data/api/models/rss/list_feed_model.dart';
import '../../base/base_controller.dart';
import '../main_controller.dart';

class HomeController extends BaseController {
  final _mainController = Get.find<MainController>();
  final _rssRepository = Get.find<RssRepository>();
  final _appController = Get.find<AppController>();

  // var _user = TUser().obs;
  //
  // TUser get user => _user.value;
  // final GlobalKey widgetKey = GlobalKey();
  //
  List<PostModel> get listBookmark => _listBookmark$.value;
  final _listBookmark$ = <PostModel>[].obs;

  List<ListFeedModel> get listFeed => _listFeed$.value;
  final _listFeed$ = <ListFeedModel>[].obs;

  bool get isShowScreenError => false;

  @override
  void onClose() {
    print('HomeController:onClose');
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    getListBookMark();
    initRssData();
  }

  void initRssData() async {
     await _rssRepository.getInitRss().then((value) async {
       var listFeed = <ListFeedModel>[];
       await Future.forEach(value, (element) async {
         print('111111111');
         var feed = ListFeedModel();
         feed.feedModel = element;
         feed.listPost = await getListPostFromFeed(element);
         listFeed.add(feed);
       });
       print('2222222'+ listFeed.length.toString());
       _listFeed$.value = listFeed;
     });
  }

  Future<List<PostModel?>> getListPostFromFeed(FeedModel feedModel) async {
    return await _rssRepository.getPostsByFeeds(feedModel);
  }

  void getListBookMark() async {
    _listBookmark$.value = await _rssRepository.getListBookmark();
  }
}
