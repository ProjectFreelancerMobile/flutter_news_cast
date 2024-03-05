import 'package:flutter/material.dart';
import 'package:flutter_news_cast/app/app_pages.dart';
import 'package:flutter_news_cast/data/api/models/rss/feed_model.dart';
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
              TouchableOpacity(
                child: Assets.icons.icRecent.svg(),
                onPressed: () {
                  Get.toNamed(AppRoutes.LIST_BOOKMARK, arguments: false);
                },
              ),
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
                for (var item in controller.listFeed) buildListPostFromFeed(item),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildListPostFromFeed(FeedModel feedModel) {
    print('buildListPostFromFeed:::' + feedModel.toString());
    //controller.getListPostFromFeed(feedModel);
    return Container(
      width: Get.width,
      height: 150.ws,
      color: Colors.amber,
      margin: EdgeInsets.only(top: 12.ws),
      padding: EdgeInsets.symmetric(horizontal: 10.ws, vertical: 10.ws),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final item = controller.listPost[index];
          return FeedItemView(
            url: item?.image ?? '',
            content: item?.title ?? '',
            onPressed: () {
              Get.toNamed(AppRoutes.READ_RSS, arguments: item);
            },
          );
        },
        itemCount: controller.listPost.length,
      ),
    );
  }
}
