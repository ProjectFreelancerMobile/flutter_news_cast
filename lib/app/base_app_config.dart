import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data/api/repositories/cast_repository.dart';
import '../data/api/repositories/rss_repository.dart';
import '../data/api/services/cast_service.dart';
import '../data/api/services/rss_service.dart';

enum Environment { dev, prod }

setupLocator() async {
  //Setup service
  Get.lazyPut<RSSService>(() => RSSService(), fenix: true);
  Get.lazyPut<CastService>(() => CastService(), fenix: true);

  //Setup repositories
  Get.lazyPut<RssRepository>(() => RssRepository(), fenix: true);
  Get.lazyPut<CastRepository>(() => CastRepository(), fenix: true);
}

setupStatusBar() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
}
