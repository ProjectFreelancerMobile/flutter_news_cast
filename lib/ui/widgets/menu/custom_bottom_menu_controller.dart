import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/storage/my_storage.dart';
import '../../../res/theme/app_theme.dart';
import '../../../res/theme/theme_service.dart';

class CustomBottomMenuController extends GetxController {
  final themeManager = Get.find<ThemeService>();
  Rx<ThemeData?>? theme;

  @override
  void onInit() {
    super.onInit();
    theme = themeManager.themeData.obs;
    themeManager.store.box.listenKey(MyStorage.APP_THEME, (value) {
      theme!.value = appThemeData[themeManager.getAppTheme(value)];
      update();
    });
  }
}
