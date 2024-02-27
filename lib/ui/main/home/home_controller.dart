// ignore_for_file: invalid_use_of_protected_member
import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_news_cast/data/api/repositories/payment_repository.dart';

import '../../../app/app_controller.dart';
import '../../../data/api/api_constants.dart';
import '../../../data/api/models/TUser.dart';
import '../../base/base_controller.dart';

class HomeController extends BaseController with GetSingleTickerProviderStateMixin{
  final _appController = Get.find<AppController>();
  var _user = TUser().obs;

  TUser get user => _user.value;

  bool get isShowScreenError => false;
  final deviceInfoPlugin = DeviceInfoPlugin();
//Notification
  List<dynamic> get listNotification => _listNotification$.value;
  final _listNotification$ = <dynamic>[].obs;
  //Home
  PageController controllerIntro = PageController(initialPage: 0, viewportFraction: 0.93);
  var pageIndexIntro = 0.obs;

  ImageProvider<Object> themeMain() => _appController.themeMain();

  //Vietinbank
  final ScrollController controller = ScrollController();
  RxBool showTabBarFull = true.obs;

  RxBool showInfoFull = true.obs;
  RxBool showInfoMoney = true.obs;

  @override
  void onClose() {
    print('HomeController:onClose');
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    _user.value = _appController.user ?? TUser();
    updateBienDong(user);
    onScroll();
    print('user::' + user.toString());
  }

  void onScroll() {
    controller.addListener(() {
      if (controller.hasClients) {
        if (controller.position.userScrollDirection == ScrollDirection.forward && !showTabBarFull.value) {
          showTabBarFull.value = true;
        } else if (controller.position.userScrollDirection == ScrollDirection.reverse && showTabBarFull.value) {
          showTabBarFull.value = false;
        }
      }
    });
  }

  onChangeVisibleInfo() {
    showInfoFull.value = !showInfoFull.value;
  }

  onChangeVisibleInfoMoney() {
    showInfoMoney.value = !showInfoMoney.value;
  }

  onTabChangedIntro(int index) {
    pageIndexIntro.value = index;
  }

  String getTimeDate(DateTime dateTime) {
    var timeString = '${DateFormat(DATE_FORMAT_NOTIFICATION_DAY).format(dateTime)} tháng ${DateFormat(DATE_FORMAT_NOTIFICATION_YEAR).format(dateTime)}';
    return timeString;
  }

  getListNotification() {
    _listNotification$.value = _appController.user?.bienDong ?? List.empty();
  }

  void updateBienDong(TUser user) {
    _appController.user = user;
  }

  Future<void> onGetBalance() async {
    final balance = await Get.find<PaymentRepository>().paymentGetBalance(user.userName);
    _user.update((_user) {
      user.updateUser(balance: balance);
    });
    updateBienDong(user);
    print('onGetBalance:' + balance.toString());
  }

  void resetPayment() {
    _appController.resetPayment();
  }

  @override
  void dispose() {
    controller.dispose();
    controllerIntro.dispose();
    super.dispose();
  }

  bool get checkLogin => _appController.user != null && _appController.user!.userName.isNotEmpty;
}
