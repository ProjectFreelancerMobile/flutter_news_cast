import 'dart:async';

import 'package:connecteo/connecteo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_news_cast/data/api/models/device/device_new.dart';
import 'package:flutter_news_cast/ui/main/home/home_controller.dart';
import 'package:flutter_news_cast/ui/widgets/dialogs/app_popup.dart';
import 'package:get/get.dart';

import '../../app/app_pages.dart';
import '../../data/api/api_constants.dart';
import '../../data/api/repositories/device_repository.dart';
import '../../data/api/repositories/farm_repository.dart';
import '../../ui/base/base_controller.dart';

class MainController extends BaseController {
  final _farmRepository = Get.find<FarmRepository>();
  final _deviceRepository = Get.find<DeviceRepository>();
  late PageController pageController;
  RxInt pageIndex = 0.obs;
  AppPopup? appPopup;
  var farmPick = null;
  final checkConnect = true.obs;
  RxString nameFarmPick = ''.obs;
  final connectionCheck = ConnectionChecker(requestInterval: Duration(seconds: 3));
  StreamSubscription<bool>? subscription;

  MainController() {
    pageController = PageController();
  }

  onTabChanged(int index) {
    pageController.jumpToPage(index);
    pageIndex.value = index;
  }

  onGotoAddFarm() {
    Get.find<HomeController>().periodicTimer?.cancel();
    Get.toNamed(AppRoutes.MANAGER, arguments: null);
  }

  onGotoListFarm() {
    Get.find<HomeController>().periodicTimer?.cancel();
    Get.toNamed(AppRoutes.MANAGER_LIST_DEVICE);
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
    getListFarm();
  }

  void sendTest() async {
    DeviceItemNew deviceItemNew = await _deviceRepository.pairDevice(wifi: "AirCity_Tang 2", password: "welcomehome") ?? DeviceItemNew();
    print('deviceItemNew::' + deviceItemNew.toString());
  }

  Future<void> getListFarm() async {
    await _farmRepository.getListFarm().then((value) {
      if (value != null) {
        print("getListFarm:::" + value.map((e) => e.toString()).toString());
        appPopup?.setListFarm(value);
        _farmRepository.getNameFarm(value).then((value) {
          nameFarmPick.value = value;
        });
      }
    });
  }

  Future<void> getFarmDetails(String? name, String? fk) async {
    farmPick = fk;
    nameFarmPick.value = name ?? 'Farm của tôi';
    Get.find<HomeController>().autoRefreshList();
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
