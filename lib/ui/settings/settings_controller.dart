import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/app_controller.dart';
import '../../../data/api/repositories/user_repository.dart';
import '../../../data/storage/my_storage.dart';
import '../base/base_controller.dart';

class SettingsController extends BaseController {
  final appController = Get.find<AppController>();
  final _useRepository = Get.find<UserRepository>();
  final storage = Get.find<MyStorage>();
  var _indexTheme = 0.obs;

  int get indexTheme => _indexTheme.value;

  ImageProvider<Object> themeMain() => appController.themeMain();

  @override
  void onInit() async {
    super.onInit();
    _indexTheme.value = appController.indexTheme.value;
  }

  void updateTheme(int index) {
    _indexTheme.value = index;
    appController.updateAppTheme(index);
    storage.setAppTheme(index);
  }
}
