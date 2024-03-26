import 'package:flutter/cupertino.dart';
import 'package:flutter_news_cast/ui/main/cast/cast_controller.dart';
import 'package:flutter_news_cast/ui/main/home/home_controller.dart';
import 'package:get/get.dart';

import '../../data/api/models/rss/post_model.dart';
import '../../ui/base/base_controller.dart';

class MainController extends BaseController {
  late PageController pageController;
  RxInt pageIndex = 0.obs;

  MainController() {
    pageController = PageController();
  }

  onTabChanged(int index) {
    pageController.jumpToPage(index);
    pageIndex.value = index;
    Get.find<CastController>().initBackground();
    if (index == 0) {
      Get.find<HomeController>().getListBookMark();
    }
  }

  onRunRssPost(PostModel? postModel) {
    pageController.jumpToPage(1);
    pageIndex.value = 1;
    Get.find<CastController>().initUrlCast(postModel);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
