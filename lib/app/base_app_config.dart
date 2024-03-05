import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../data/api/repositories/cast_repository.dart';
import '../data/api/repositories/rss_repository.dart';
import '../data/api/repositories/user_repository.dart';
import '../data/api/services/bookmark_service.dart';
import '../data/api/services/cast_service.dart';
import '../data/api/services/rss_service.dart';

enum Environment { dev, prod }

setupLocator() async {
  //Setup service
  Get.lazyPut<BookmarkService>(() => BookmarkService(), fenix: true);
  Get.lazyPut<RSSService>(() => RSSService(), fenix: true);
  Get.lazyPut<CastService>(() => CastService(), fenix: true);

  //Setup repositories
  Get.lazyPut<BookmarkRepository>(() => BookmarkRepository(), fenix: true);
  Get.lazyPut<RssRepository>(() => RssRepository(), fenix: true);
  Get.lazyPut<CastRepository>(() => CastRepository(), fenix: true);
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
