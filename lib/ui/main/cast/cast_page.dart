import 'package:flutter/material.dart';

import '../../base/base_page.dart';
import 'cast_controller.dart';

//ignore: must_be_immutable
class CastPage extends BasePage<CastController> {
  @override
  Widget buildContentView(BuildContext context, CastController controller) {
    return Scaffold(
      body: Placeholder(),
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
  // Widget buildListDevice(BuildContext context) {
  //   return Expanded(
  //     child: RefreshIndicator(
  //       onRefresh: () => controller.getListDevice(),
  //       child: Container(
  //         padding: EdgeInsets.symmetric(horizontal: 10.ws, vertical: 10.ws),
  //         child: GridView.builder(
  //           padding: EdgeInsets.zero,
  //           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //             crossAxisCount: 2,
  //             mainAxisExtent: 120.ws,
  //             mainAxisSpacing: 10.ws,
  //             crossAxisSpacing: 10.ws,
  //           ),
  //           itemBuilder: (context, index) {
  //             final item = controller.listDevice[index];
  //             return HomeItemView(
  //               deviceItem: item,
  //               onPressed: () => controller.onGotoManagerDevice(item),
  //               onPressedControl: (isOn) => controller.pushDevice(item, item.serialNo),
  //             );
  //           },
  //           itemCount: controller.listDevice.length,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
