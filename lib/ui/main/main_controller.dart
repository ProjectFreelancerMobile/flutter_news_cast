import 'dart:async';

import 'package:connecteo/connecteo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../data/api/api_constants.dart';
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
