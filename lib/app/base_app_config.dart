import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data/api/repositories/payment_repository.dart';
import '../data/api/repositories/user_repository.dart';
import '../data/api/services/payment_service.dart';
import '../data/api/services/user_service.dart';

enum Environment { dev, prod }

setupLocator() async {
  //Setup service
  Get.lazyPut<UserService>(() => UserService(), fenix: true);
  Get.lazyPut<PaymentService>(() => PaymentService(), fenix: true);
  //Setup repositories
  Get.lazyPut<UserRepository>(() => UserRepository(), fenix: true);
  Get.lazyPut<PaymentRepository>(() => PaymentRepository(), fenix: true);

  // Get.put(AssetPathProvider());
  //
  // Get.put(PhotoProvider());
  // Get.put(AssetPathProvider());
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
