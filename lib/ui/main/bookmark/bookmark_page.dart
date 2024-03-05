import 'package:flutter/material.dart';
import 'package:flutter_news_cast/ui/widgets/data_empty_widget.dart';

import '../../../res/style.dart';
import '../../base/base_page.dart';
import '../../widgets/default_appbar.dart';
import '../widget/feed_recent_item_view.dart';
import 'bookmark_controller.dart';

//ignore: must_be_immutable
class ListBookmarkPage extends BasePage<BookmarkController> {
  @override
  Widget buildContentView(BuildContext context, BookmarkController controller) {
    return Scaffold(
      appBar: DefaultAppbar(
        title: textLocalization('home.bookmarks'),
        appBarStyle: AppBarStyle.BACK,
      ),
      body: buildListBookmark(),
    );
  }

  Widget buildListBookmark() {
    return Expanded(
      child: controller.listPost.length > 0
          ? ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = controller.listPost[index];
                return FeedRecentItemView(
                  url: item?.image ?? '',
                  content: item?.content ?? '',
                  onPressed: () {},
                );
              },
              itemCount: controller.listPost.length,
            )
          : DataEmptyWidget(),
    );
  }
}
