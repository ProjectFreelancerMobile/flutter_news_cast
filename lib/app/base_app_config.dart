import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data/api/repositories/device_repository.dart';
import '../data/api/repositories/farm_repository.dart';
import '../data/api/repositories/user_repository.dart';
import '../data/api/services/device_service.dart';
import '../data/api/services/farm_service.dart';
import '../data/api/services/user_service.dart';

enum Environment { dev, prod }

setupLocator() async {
  //Setup service
  Get.lazyPut<UserService>(() => UserService(), fenix: true);
  Get.lazyPut<FarmService>(() => FarmService(), fenix: true);
  Get.lazyPut<DeviceService>(() => DeviceService(), fenix: true);

  //Setup repositories
  Get.lazyPut<UserRepository>(() => UserRepository(), fenix: true);
  Get.lazyPut<DeviceRepository>(() => DeviceRepository(), fenix: true);
  Get.lazyPut<FarmRepository>(() => FarmRepository(), fenix: true);
}

setupStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}
