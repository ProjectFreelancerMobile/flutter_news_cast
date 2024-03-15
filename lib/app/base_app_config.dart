import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data/api/repositories/rss_repository.dart';
import '../data/api/services/rss_service.dart';

enum Environment { dev, prod }

setupLocator() async {
  //Setup service
  Get.lazyPut<RSSService>(() => RSSService(), fenix: true);

  //Setup repositories
  Get.lazyPut<RssRepository>(() => RssRepository(), fenix: true);
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
