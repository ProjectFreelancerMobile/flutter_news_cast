// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter_news_cast/data/api/models/rss/post_model.dart';
import 'package:flutter_news_cast/data/api/repositories/rss_repository.dart';
import 'package:get/get.dart';

import '../../../data/api/api_constants.dart';
import '../../base/base_controller.dart';
import '../home/home_controller.dart';
import '../main_controller.dart';

class BookmarkController extends BaseController {
  final _mainController = Get.find<MainController>();
  final _rssRepository = Get.find<RssRepository>();
  final isBookmark = Get.arguments as bool;

  List<PostModel?> get listPost => _listPost$.value;
  final _listPost$ = <PostModel?>[].obs;

  bool get isShowScreenError => false;

  @override
  void onInit() async {
    super.onInit();
    if (isBookmark) {
      getListBookMark();
    } else {
      getListRecent();
    }
  }

  void getListBookMark() async {
    _listPost$.value = await _rssRepository.getListBookmark();
  }

  void getListRecent() async {
    _listPost$.value = await _rssRepository.getListRecent();
  }

  void deleteBookmark(PostModel? postModel) async {
    if (postModel == null) return;
    if (isBookmark) {
      await _rssRepository.updatePostStatus(postModel, bookMark: false, readTime: postModel.readDate);
      _listPost$.value = await Get.find<HomeController>().getListBookMark();
    } else {
      await _rssRepository.updatePostStatus(postModel, bookMark: postModel.favorite, readTime: null);
      getListRecent();
    }
  }

  void navigationCast(String? url) {
    urlCast = url ?? '';
    Get.back();
    _mainController.onTabChangedCast();
  }
}
