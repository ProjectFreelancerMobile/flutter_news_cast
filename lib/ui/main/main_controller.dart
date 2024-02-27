import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../app/app_controller.dart';
import '../../data/storage/my_storage.dart';
import '../../ui/base/base_controller.dart';

class MainController extends BaseController {
  final storage = Get.find<MyStorage>();
  final _appController = Get.find<AppController>();
  late PageController pageController;
  RxInt pageIndex = 0.obs;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  MainController() {
    pageController = PageController();
  }

  onTabChanged(int index) {
    pageController.jumpToPage(index);
    pageIndex.value = index;
  }

  void resetPayment() {
    _appController.resetPayment();
  }

  @override
  void onReady() {
    super.onReady();
    //showLoading();
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void testLoading() {
    // showLoading();
  }

  bool get checkLogin => _appController.user != null && _appController.user!.userName.isNotEmpty;
}
