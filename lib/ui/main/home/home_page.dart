import 'package:flutter/material.dart';
import 'package:flutter_news_cast/app/app_pages.dart';
import 'package:flutter_news_cast/data/api/models/rss/feed_model.dart';
import 'package:flutter_news_cast/data/api/models/rss/post_model.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/main/home/widget/feed_item_view.dart';
import 'package:flutter_news_cast/ui/main/home/widget/feed_recent_item_view.dart';
import 'package:flutter_news_cast/ui/widgets/base_scaffold_widget.dart';
import 'package:get/get.dart';

import '../../base/base_page.dart';
import '../../widgets/button/touchable_opacity.dart';
import '../../widgets/dialogs/app_dialog.dart';
import '../bottom_sheet/bottom_sheet.dart';
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
            child: buildListFeed(context),
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
        SizedBox(height: 10.ws),
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

  Widget buildListFeed(BuildContext context) {
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
            TouchableOpacity(child: Assets.icons.icAdd.svg(), onPressed: () => openAddRss(controller)),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (var item in controller.listFeed) buildListPostFromFeed(context, item.feedModel, item.listPost),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildListPostFromFeed(BuildContext context, FeedModel? feedModel, List<PostModel?>? listPost) {
    print('buildListPostFromFeed::${listPost?.length}');
    return Container(
      width: Get.width,
      height: 170.ws,
      margin: EdgeInsets.only(top: 12.ws),
      padding: EdgeInsets.symmetric(vertical: 10.ws),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TouchableOpacity(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          feedModel?.title ?? '',
                          style: text14.bold.textColor141414,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 6.ws),
                      Assets.icons.icFeedUrl.svg(),
                    ],
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 16.ws),
              TouchableOpacity(
                child: Assets.icons.icDelete.svg(),
                onPressed: () {
                  AppDialog(
                    context: context,
                    title: textLocalization('dialog.delete.learn'),
                    description: textLocalization('dialog.undone.action'),
                    type: DialogType.THREE_ACTION,
                    cancelText: textLocalization('dialog.cancel'),
                    okText: textLocalization('dialog.delete'),
                    midText: textLocalization('dialog.learn.more'),
                    onOkPressed: () {},
                    onCancelPressed: () {},
                    onMidPressed: () {},
                  ).show();
                  controller.removeBookMark(feedModel);
                },
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

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Basic dialog title'),
          content: const Text(
            'A dialog is a type of modal window that\n'
            'appears in front of app content to\n'
            'provide critical information, or prompt\n'
            'for a decision to be made.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Disable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
