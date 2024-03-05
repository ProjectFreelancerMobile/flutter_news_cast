// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter_news_cast/data/api/models/rss/feed_model.dart';
import 'package:flutter_news_cast/data/api/models/rss/post_model.dart';
import 'package:flutter_news_cast/data/api/repositories/rss_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../app/app_controller.dart';
import '../../../data/api/api_constants.dart';
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

  List<FeedModel> get listFeed => _listFeed$.value;
  final _listFeed$ = <FeedModel>[].obs;

  List<PostModel?> get listPost => _listPost$.value;
  final _listPost$ = <PostModel?>[].obs;

  bool get isShowScreenError => false;

  @override
  void onClose() {
    print('HomeController:onClose');
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    initRssData();
    getListBookMark();
  }

  void initRssData() async {
    // _feedModel$.value = await _rssRepository.getFeed(RSS_1);
    _listFeed$.value = await _rssRepository.getInitRss();
  }

  void getListPostFromFeed(FeedModel feedModel) async {
    _listPost$.value =  await _rssRepository.getPostsByFeeds(feedModel);
  }

  void getListBookMark() async {
    _listBookmark$.value = await _rssRepository.getListBookmark();
  }
}
