import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_news_cast/app/app_pages.dart';
import 'package:flutter_news_cast/data/api/models/rss/post_model.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/main/home/widget/feed_item_view.dart';
import 'package:flutter_news_cast/ui/main/home/widget/feed_recent_item_view.dart';
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
              TouchableOpacity(
                child: Assets.icons.icRecent.svg(),
                onPressed: () {
                  Get.toNamed(AppRoutes.LIST_BOOKMARK, arguments: false);
                },
              ),
            ],
          ),
          SizedBox(height: 12.ws),
          Expanded(
            flex: 1,
            child: buildListFeedRecent(),
          ),
          Expanded(
            flex: 3,
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
          onPressed: () {
            Get.toNamed(AppRoutes.LIST_BOOKMARK, arguments: true);
          },
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
              final item = controller.listBookmark[index];
              return FeedRecentItemView(
                url: item.image ?? '',
                content: item.title ?? '',
                onPressed: () {
                  Get.toNamed(AppRoutes.READ_RSS, arguments: item);
                },
              );
            },
            itemCount: controller.listBookmark.length > 5 ? 5 : controller.listBookmark.length,
          ),
        ),
      ],
    );
  }

  Widget buildListFeed() {
    return Column(
      children: [
        Row(
          children: [
            Assets.icons.icFeed.svg(),
            SizedBox(width: 16.ws),
            Expanded(
              child: Text(
                textLocalization('home.feeds'),
                style: text16.bold.textColor141414,
              ),
            ),
            Assets.icons.icAdd.svg(),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (var item in controller.listFeed) buildListPostFromFeed(item.feedModel?.title, item.listPost),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildListPostFromFeed(String? title, List<PostModel?>? listPost) {
    print('buildListPostFromFeed::${listPost?.length}');
    return Container(
      width: Get.width,
      height: 170.ws,
      margin: EdgeInsets.only(top: 12.ws),
      padding: EdgeInsets.symmetric(horizontal: 10.ws, vertical: 10.ws),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TouchableOpacity(
                onPressed: () {},
                child: Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          title ?? '',
                          style: text14.bold.textColor141414,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 6.ws),
                      Assets.icons.icFeedUrl.svg(),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16.ws),
              TouchableOpacity(
                child: Assets.icons.icDelete.svg(),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 10.ws),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = listPost?[index];
                return FeedItemView(
                  url: item?.image ?? '',
                  content: item?.title ?? '',
                  onPressed: () {
                    Get.toNamed(AppRoutes.READ_RSS, arguments: item);
                  },
                );
              },
              itemCount: listPost?.length,
            ),
          ),
        ],
      ),
    );
  }
}
