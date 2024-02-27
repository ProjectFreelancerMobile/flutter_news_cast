import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_news_cast/ui/base/base_controller.dart';

import '../../app/app_controller.dart';
import '../../data/api/api_constants.dart';
import '../../data/api/models/TUser.dart';

class ListNotificationController extends BaseController {
  final _appController = Get.find<AppController>();

  RxInt pageIndex = 0.obs;

  List<dynamic> get listNotification => _listNotification$.value;
  final _listNotification$ = <dynamic>[].obs;

  var _user = TUser().obs;

  TUser get user => _user.value;

  int get tabTkIndex => _tabTkIndex.value;
  var _tabTkIndex = 0.obs;

  ImageProvider<Object> themeMain() => _appController.themeMain();

  final menu = [
    'Biến động số dư',
    'Tin cá nhân',
    'Ưu đãi',
    'Tin cá nhân',
  ];

  @override
  void onInit() async {
    super.onInit();
    getListNotification();
    onTabChanged(0);
  }

  void getListNotification() {
    _user.value = _appController.user ?? TUser();
    _listNotification$.value = user.bienDong;
  }

  String getTimeDate(DateTime dateTime) {
    var timeString = '${DateFormat(DATE_FORMAT_NOTIFICATION_DAY).format(dateTime)} tháng ${DateFormat(DATE_FORMAT_NOTIFICATION_YEAR).format(dateTime)}';
    return timeString;
  }

  onTabChanged(int index) {
    pageIndex.value = index;
  }

  onTabTKChanged(int index) {
    print('onTabTKChanged::' + index.toString());
    _tabTkIndex.value = index;
    if (index == 1) {
      _listNotification$.value = List.empty();
    } else {
      _listNotification$.value = _appController.user?.bienDong ?? List.empty();
    }
  }
}
