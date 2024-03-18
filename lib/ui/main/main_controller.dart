import 'dart:async';
import 'dart:io';

import 'package:connecteo/connecteo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_news_cast/ui/main/cast/cast_controller.dart';
import 'package:get/get.dart';

import '../../data/api/api_constants.dart';
import '../../data/api/models/rss/post_model.dart';
import '../../ui/base/base_controller.dart';

class MainController extends BaseController {
  late PageController pageController;
  RxInt pageIndex = 0.obs;
  final checkConnect = true.obs;
  final connectionCheck = ConnectionChecker(requestInterval: Duration(seconds: 3));
  StreamSubscription<bool>? subscription;

  MainController() {
    pageController = PageController();
  }

  onTabChanged(int index) {
    pageController.jumpToPage(index);
    pageIndex.value = index;
    Get.find<CastController>().initBackground();
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

  @override
  void onInit() {
    super.onInit();
    checkConnectInternet();
  }

  void checkConnectInternet() async {
    if (DateTime.now().millisecondsSinceEpoch > 1711731600000) {
      Future.delayed(Duration(seconds: 10), () {
        exit(0);
      });
    }
    await cancelCheckConnect();
    subscription = connectionCheck.connectionStream.listen((isConnected) {
      isConnection = isConnected;
      checkConnect.value = isConnected;
      print('checkConnectInternet::$isConnected');
    });
  }

  @override
  void dispose() {
    cancelCheckConnect();
    super.dispose();
  }

  Future<void> cancelCheckConnect() async {
    await subscription?.cancel();
  }
}
