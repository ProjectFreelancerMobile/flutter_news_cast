import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/main/widget/feed_item_view.dart';
import 'package:flutter_news_cast/ui/main/widget/feed_recent_item_view.dart';
import 'package:flutter_news_cast/ui/widgets/base_scaffold_widget.dart';

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
            onPressed: () {},
          );
        },
        itemCount: controller.listFeed.length,
      ),
    );
  }

// buildWidgetUserInfo(BuildContext context) => Container(
//       width: double.infinity,
//       height: 130.ws,
//       decoration: BoxDecoration(
//         color: getColor().bgThemeColorWhite,
//         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(14), bottomRight: Radius.circular(14)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             spreadRadius: 1,
//             blurRadius: 1,
//             offset: Offset(0, 0.5),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 30.ws),
//           Container(
//             height: 50.ws,
//             width: double.infinity,
//             padding: EdgeInsets.only(left: 24.ws),
//             child: Align(
//               alignment: Alignment.bottomLeft,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       "${textLocalization("home.user.title")}${controller.user.name != null ? controller.user.name : ""}",
//                       style: text26.medium.textColor141414.height14Per,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   Visibility(
//                     visible: false,
//                     child: TouchableOpacity(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 30.ws),
//                         child: Assets.icons.icNotification.svg(),
//                       ),
//                       onPressed: () {
//                         showMessage(textLocalization('feature'));
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             height: 50.ws,
//             width: double.infinity,
//             padding: EdgeInsets.only(left: 24.ws),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 8.ws),
//                   child: Text(controller.getMainController.nameFarmPick.value.isNotEmpty ? controller.getMainController.nameFarmPick.value : 'Farm của tôi',
//                       style: text14.textColor141414),
//                 ),
//                 TouchableOpacity(
//                   child: Padding(
//                     key: controller.widgetKey,
//                     padding: EdgeInsets.symmetric(horizontal: 24.ws, vertical: 4.ws),
//                     child: Assets.icons.icMenu.svg(height: 24.ws, width: 20.ws),
//                   ),
//                   onPressed: () {
//                     final RenderBox renderBox = controller.widgetKey.currentContext?.findRenderObject() as RenderBox;
//                     final Offset offset = renderBox.localToGlobal(Offset.zero);
//                     controller.getPopup()?.showPopupDialog(context, offset);
//                   },
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//
// buildWidgetDevice(BuildContext context) {
//   return Padding(
//     padding: EdgeInsets.only(left: 16.ws, right: 16.ws, top: 22.hs),
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(vertical: 8),
//           child: Text(textLocalization('home_list_device').toUpperCase(), style: text14.height20Per.textColor141414),
//         ),
//         TouchableOpacity(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Assets.icons.icDeviceAdd.svg(width: 14.ws, height: 14.ws),
//           ),
//           onPressed: () => controller.onGotoAddDevice(),
//         )
//       ],
//     ),
//   );
// }
//
}
