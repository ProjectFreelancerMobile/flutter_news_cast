import 'package:flutter/material.dart';
import 'package:flutter_news_cast/ui/widgets/base_scaffold_widget.dart';
import 'package:flutter_news_cast/ui/widgets/data_empty_widget.dart';
import 'package:get/get.dart';

import '../../../app/app_pages.dart';
import '../../../res/style.dart';
import '../../base/base_page.dart';
import '../../widgets/default_appbar.dart';
import '../home/widget/feed_recent_item_view.dart';
import 'bookmark_controller.dart';

//ignore: must_be_immutable
class ListBookmarkPage extends BasePage<BookmarkController> {
  @override
  Widget buildContentView(BuildContext context, BookmarkController controller) {
    return ScaffoldBase(
      offMarginVertical: true,
      appBar: DefaultAppbar(
        title: controller.isBookmark ? textLocalization('home.bookmarks') : textLocalization('home.recents'),
        appBarStyle: AppBarStyle.BACK,
        isLeft: true,
      ),
      body: buildListBookmark(),
    );
  }

  Widget buildListBookmark() {
    return controller.listPost.length > 0
        ? ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = controller.listPost[index];
              return FeedRecentItemView(
                url: item?.image ?? '',
                content: item?.title ?? '',
                onPressed: () => Get.toNamed(AppRoutes.READ_RSS, arguments: item),
                onPressedRemove: () => controller.deleteBookmark(item),
              );
            },
            itemCount: controller.listPost.length,
          )
        : DataEmptyWidget();
  }
}
