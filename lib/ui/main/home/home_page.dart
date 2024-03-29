import 'package:flutter/material.dart';
import 'package:flutter_news_cast/app/app_pages.dart';
import 'package:flutter_news_cast/data/api/models/rss/feed_model.dart';
import 'package:flutter_news_cast/data/api/models/rss/post_model.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/main/home/widget/feed_item_view.dart';
import 'package:flutter_news_cast/ui/main/home/widget/feed_recent_item_view.dart';
import 'package:flutter_news_cast/ui/widgets/base_scaffold_widget.dart';
import 'package:flutter_news_cast/ui/widgets/data_empty_widget.dart';
import 'package:get/get.dart';

import '../../../data/storage/key_constant.dart';
import '../../../res/theme/theme_service.dart';
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
      isHome: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Text(textLocalization('home.title').toUpperCase(), style: text24.bold.textColor141414),
                TouchableOpacity(
                  child: Row(
                    children: [
                      Assets.icons.icRecent.svg(color: getColor().themeColor141414),
                      SizedBox(width: 16.ws),
                    ],
                  ),
                  onPressed: () {
                    Get.toNamed(AppRoutes.LIST_BOOKMARK, arguments: false);
                  },
                ),
              ],
            ),
            SizedBox(height: 24.ws),
            buildListFeedBookMark(),
            SizedBox(height: 24.ws),
            buildListFeed(context),
          ],
        ),
      ),
    );
  }

  Widget buildListFeedBookMark() {
    return Padding(
      padding: EdgeInsets.only(right: 16.ws),
      child: Column(
        children: [
          TouchableOpacity(
            onPressed: () {
              Get.toNamed(AppRoutes.LIST_BOOKMARK, arguments: true);
            },
            child: Row(
              children: [
                Assets.icons.icHomeBookmark.svg(color: getColor().themeColor141414),
                SizedBox(width: 16.ws),
                Expanded(
                  child: Text(
                    textLocalization('home.bookmarks'),
                    style: text18.bold.textColor141414,
                  ),
                ),
                Assets.icons.icSettingsNext.svg(color: getColor().themeColor141414),
              ],
            ),
          ),
          SizedBox(height: 8.ws),
          controller.listBookmark.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = controller.listBookmark[index];
                    return BookmarkItemView(
                      isRemove: false,
                      type: item.feed.value?.type ?? RSS_TITLE.GOOGLE.indexTitleValue,
                      urlIcon: item.icon,
                      content: item.title,
                      onPressed: () => controller.navigationCast(item),
                      onPressedRemove: () => controller.deleteBookmark(item),
                    );
                  },
                  itemCount: controller.listBookmark.length > 5 ? 5 : controller.listBookmark.length,
                )
              : Text(
                  textLocalization('error.empty.bookmark'),
                  style: text14.textColor141414,
                  textAlign: TextAlign.center,
                )
        ],
      ),
    );
  }

  Widget buildListFeed(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Assets.icons.icFeed.svg(color: getColor().themeColor141414),
            SizedBox(width: 16.ws),
            Expanded(
              child: Text(
                textLocalization('home.feeds'),
                style: text18.bold.textColor141414,
              ),
            ),
            TouchableOpacity(child: Assets.icons.icAdd.svg(color: getColor().themeColor141414), onPressed: () => openBottomSheetAddRss(controller)),
            SizedBox(width: 16.ws),
          ],
        ),
        SizedBox(height: 16.ws),
        controller.listFeed.length == 0 && controller.isShowNotFirst
            ? DataEmptyWidget(textEmpty: textLocalization('error.empty.home'))
            : Column(
                children: [
                  for (var item in controller.listFeed) buildListPostFromFeed(context, item.feedModel, item.listPost),
                ],
              )
      ],
    );
  }

  Widget buildListPostFromFeed(BuildContext context, FeedModel? feedModel, List<PostModel?>? listPost) {
    return Column(
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
                        style: text16.bold.textColor141414,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.ws),
                    Assets.icons.icFeedUrl.svg(color: getColor().themeColor141414),
                  ],
                ),
                onPressed: () => controller.navigationCast(PostModel(
                  title: feedModel?.title ?? '',
                  link: feedModel?.hostUrl ?? Uri.parse(feedModel?.url ?? '').host,
                  image: '',
                  content: '',
                  icon: '',
                  pubDate: DateTime.now(),
                  favorite: false,
                  fullText: false,
                )),
              ),
            ),
            SizedBox(width: 16.ws),
            TouchableOpacity(
              child: Assets.icons.icDelete.svg(color: getColor().themeColor141414),
              onPressed: () {
                AppDialog(
                  context: context,
                  title: textLocalization('dialog.delete.learn').trParams(
                    {
                      'field': feedModel?.title ?? '',
                    },
                  ),
                  description: textLocalization('dialog.undone.action'),
                  type: DialogType.TWO_ACTION,
                  cancelText: textLocalization('dialog.cancel'),
                  okText: textLocalization('dialog.delete'),
                  onOkPressed: (dialog) async {
                    await controller.deleteRssFeed(feedModel);
                    dialog.dismiss();
                  },
                  onCancelPressed: () {},
                ).show();
                /*AppDialog(
                  context: context,
                  title: textLocalization('dialog.delete.learn'),
                  description: textLocalization('dialog.undone.action'),
                  type: DialogType.THREE_ACTION,
                  cancelText: textLocalization('dialog.cancel'),
                  okText: textLocalization('dialog.delete'),
                  midText: textLocalization('dialog.learn.more'),
                  onOkPressed: () {
                    controller.removeBookMark(feedModel);
                  },
                  onCancelPressed: () {},
                  onMidPressed: () {
                    launchOpenUrl(Uri.parse(LEARN_MORE_URL));
                  },
                ).show();*/
              },
            ),
            SizedBox(width: 16.ws),
          ],
        ),
        SizedBox(height: 10.ws),
        SizedBox(
          width: double.infinity,
          height: 170.ws,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = listPost?[index];
              return FeedItemView(
                url: item?.image ?? '',
                content: item?.title ?? '',
                onPressed: () => controller.navigationCast(item),
              );
            },
            itemCount: listPost?.length,
          ),
        ),
      ],
    );
  }
}
