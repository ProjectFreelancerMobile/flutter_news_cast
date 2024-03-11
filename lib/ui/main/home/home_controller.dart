// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter/material.dart';
import 'package:flutter_news_cast/data/api/models/rss/feed_model.dart';
import 'package:flutter_news_cast/data/api/models/rss/post_model.dart';
import 'package:flutter_news_cast/data/api/repositories/rss_repository.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:get/get.dart';

import '../../../app/app_controller.dart';
import '../../../data/api/models/rss/list_feed_model.dart';
import '../../base/base_controller.dart';
import '../main_controller.dart';

class HomeController extends BaseController {
  final _mainController = Get.find<MainController>();
  final _rssRepository = Get.find<RssRepository>();
  final _appController = Get.find<AppController>();
  TextEditingController textAddRssCl = TextEditingController();

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
    showLoading();
    final listRss = await _rssRepository.getInitRss();
    hideLoading();
    _listFeed$.value = listRss;
  }

  Future<List<PostModel>> getListBookMark() async {
    _listBookmark$.value = await _rssRepository.getListBookmark();
    return listBookmark;
  }

  void saveRssFeed() async {
    if (textAddRssCl.text.isEmpty) return;
    final isSuccess = await _rssRepository.saveRssFeed(textAddRssCl.text);
    textAddRssCl.clear();
    if (isSuccess) {
      await _rssRepository.getInitRss().then((value) {
        _listFeed$.value = value;
      });
    } else {
      showErrors(textLocalization('error.url.exist'));
    }
  }

  void deleteRssFeed(FeedModel? feedModel) async {
    if (feedModel == null) return;
    final isSuccess = await _rssRepository.deleteRssFeed(feedModel);
    if (isSuccess) {
      await _rssRepository.getInitRss().then((value) {
        _listFeed$.value = value;
      });
    } else {
      showErrors(textLocalization('error.remove'));
    }
  }

  String? validatorRss(String fieldName) {
    return (GetUtils.isNullOrBlank(textAddRssCl.text) == true)
        ? 'sign_up_msg_is_required'.trParams(
            {
              'field': fieldName,
            },
          )
        : GetUtils.isLengthLessThan(textAddRssCl.text, 3)
            ? 'sign_up_msg_is_at_least_3_characters'.trParams(
                {
                  'field': fieldName,
                },
              )
            : null;
  }

  @override
  void dispose() {
    textAddRssCl.dispose();
    super.dispose();
  }
}
