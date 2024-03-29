import 'package:flutter/material.dart';
import 'package:flutter_news_cast/data/storage/key_constant.dart';
import 'package:flutter_news_cast/ui/widgets/base_scaffold_widget.dart';
import 'package:flutter_news_cast/ui/widgets/data_empty_widget.dart';

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
              return BookmarkItemView(
                isRemove: true,
                type: item?.feed.value?.type ?? RSS_TITLE.GOOGLE.indexTitleValue,
                urlIcon: item?.icon ?? '',
                content: item?.title ?? '',
                onPressed: () => controller.navigationCast(item),
                onPressedRemove: () => controller.deleteBookmark(item),
              );
            },
            itemCount: controller.listPost.length,
          )
        : DataEmptyWidget(textEmpty: controller.isBookmark ? textLocalization('error.empty.bookmark') : null);
  }
}
