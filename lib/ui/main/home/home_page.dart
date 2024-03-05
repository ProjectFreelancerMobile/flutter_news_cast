import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_news_cast/app/app_pages.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/main/widget/feed_item_view.dart';
import 'package:flutter_news_cast/ui/main/widget/feed_recent_item_view.dart';
import 'package:flutter_news_cast/ui/widgets/base_scaffold_widget.dart';
import 'package:get/get.dart';

import '../../base/base_page.dart';
import '../../widgets/button/touchable_opacity.dart';
import 'home_controller.dart';

//ignore: must_be_immutable
class HomePage extends BasePage<HomeController> {
  @override
  Widget buildContentView(BuildContext context, HomeController controller) {
    return ScaffoldBase(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Text(textLocalization('home.title').toUpperCase(), style: text24.bold.textColor141414),
              Assets.icons.icRecent.svg(),
            ],
          ),
          SizedBox(height: 12.ws),
          // Row(
          //   children: [
          //     Text(
          //       controller.feedModel.toString(),
          //       style: text18.bold.textColor141414,
          //       maxLines: 10,
          //     ),
          //   ],
          // ),
          Expanded(
            flex: 1,
            child: buildListFeedRecent(),
          ),
          Expanded(
            flex: 2,
            child: buildListFeed(),
          ),
        ],
      ),
    );
  }

  Widget buildListFeedRecent() {
    return Column(
      children: [
        TouchableOpacity(
          onPressed: () {},
          child: Row(
            children: [
              Assets.icons.icHomeBookmark.svg(),
              SizedBox(width: 16.ws),
              Expanded(
                child: Text(
                  textLocalization('home.bookmarks'),
                  style: text16.bold.textColor141414,
                ),
              ),
              Assets.icons.icSettingsNext.svg(),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final item = controller.listRecentFeed[index];
              return FeedRecentItemView(
                url: item.url ?? '',
                content: item.title ?? '',
                onPressed: () {},
              );
            },
            itemCount: controller.listRecentFeed.length,
          ),
        ),
      ],
    );
  }

  Widget buildListFeed() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.ws, vertical: 10.ws),
      child: GridView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisExtent: 120.ws,
          mainAxisSpacing: 10.ws,
          crossAxisSpacing: 10.ws,
        ),
        itemBuilder: (context, index) {
          final item = controller.listPost[index];
          return FeedItemView(
            url: item?.image ?? '',
            content: item?.title ?? '',
            onPressed: () {
              Get.toNamed(AppRoutes.READ_RSS, arguments: item?.link ?? '');
            },
          );
        },
        itemCount: controller.listFeed.length,
      ),
    );
  }
}
