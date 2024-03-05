// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_news_cast/data/api/models/rss/post_model.dart';
import 'package:flutter_news_cast/data/api/repositories/rss_repository.dart';
import 'package:get/get.dart';

import '../../../app/app_controller.dart';
import '../../base/base_controller.dart';
import '../main_controller.dart';

class BookmarkController extends BaseController {
  final _mainController = Get.find<MainController>();
  final _rssRepository = Get.find<RssRepository>();
  final _appController = Get.find<AppController>();
  final isBookmark = Get.arguments as bool;
  List<PostModel?> get listPost => _listPost$.value;
  final _listPost$ = <PostModel?>[].obs;

  bool get isShowScreenError => false;

  @override
  void onInit() async {
    super.onInit();
    if(isBookmark){
      getListBookMark();
    }else{
      getListRecent();
    }
  }

  void getListBookMark() async {
    _listPost$.value = await _rssRepository.getListBookmark();
  }

  void getListRecent() async {
    _listPost$.value = await _rssRepository.getListRecent();
  }
}
