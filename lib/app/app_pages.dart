import 'package:get/get.dart';

import '../../ui/main/main_binding.dart';
import '../../ui/main/main_page.dart';
import '../ui/main/bookmark/bookmark_binding.dart';
import '../ui/main/bookmark/bookmark_page.dart';

part 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.MAIN,
      page: () => MainPage(),
      binding: MainBinding(),
    ),
    GetPage(
      name: AppRoutes.LIST_BOOKMARK,
      page: () => ListBookmarkPage(),
      binding: BookmarkBinding(),
      transition: Transition.rightToLeft,
    ),
    // GetPage(
    //   name: AppRoutes.READ_RSS,
    //   page: () => RssPage(),
    //   binding: RssBinding(),
    // ),
  ];
}
