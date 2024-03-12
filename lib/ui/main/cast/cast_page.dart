import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_news_cast/app/app_pages.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:get/get.dart';

import '../../base/base_page.dart';
import '../../widgets/input/text_form_field_widget.dart';
import 'cast_controller.dart';

//ignore: must_be_immutable
class CastPage extends BasePage<CastController> {
  @override
  Widget buildContentView(BuildContext context, CastController controller) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.ws, right: 16.ws, top: 46.ws, bottom: 12.ws),
            child: Row(
              children: [
                IconButton(onPressed: () => Get.offAllNamed(AppRoutes.MAIN), icon: Icon(Icons.arrow_back_ios_new)),
                Expanded(
                  child: DTextFromField(
                    keyboardType: TextInputType.text,
                    controller: controller.textSearchCl,
                    textStyle: text14.textColor141414,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 16.ws),
                      child: controller.isHasLoadWeb ? Assets.icons.icCastLock.svg() : Icon(Icons.search),
                    ),
                    suffixIcon: MaterialButton(
                      onPressed: () {
                        controller.clearOrReload();
                      },
                      height: 24.ws,
                      minWidth: 24.ws,
                      padding: EdgeInsets.all(0),
                      child: controller.isHasLoadWeb ? Assets.icons.icCastReplay.svg() : Assets.icons.icRemove.svg(),
                    ),
                    iconContraints: BoxConstraints(maxWidth: 40.ws, maxHeight: 24, minHeight: 24),
                    background: colorSearch,
                    borderRadius: 18,
                    strokeColor: Colors.transparent,
                    hintText: textLocalization('feed.search.url'),
                    contentPadding: EdgeInsets.symmetric(horizontal: 2.ws, vertical: 12.ws),
                    onValidated: (val) {
                      return controller.validatorURL('Địa chỉ URL');
                    },
                    onChange: (value) {
                      controller.commitURL(value);
                    },
                  ),
                ),
                IconButton(onPressed: () {}, icon: Assets.icons.icBookmark.svg(height: 22.ws)),
                // IconButton(onPressed: () {}, icon: Assets.icons.icCast.svg(height: 22.ws)),
              ],
            ),
          ),
          Expanded(
            child: InAppWebView(
              key: controller.webViewKey,
              initialSettings: controller.settings,
              pullToRefreshController: controller.pullToRefreshController,
              onWebViewCreated: (controllerWeb) {
                controller.webViewController = controllerWeb;
              },
              onLoadStart: (controllerWeb, url) {
                controller.loadWeb(false);
              },
              onPermissionRequest: (controller, request) async {
                return PermissionResponse(resources: request.resources, action: PermissionResponseAction.GRANT);
              },
              shouldOverrideUrlLoading: (controller, navigationAction) async {
                return NavigationActionPolicy.ALLOW;
              },
              onLoadStop: (controllerWeb, url) async {
                controller.pullToRefreshController?.endRefreshing();
              },
              onReceivedError: (controllerWeb, request, error) {
                controller.pullToRefreshController?.endRefreshing();
              },
              onProgressChanged: (controllerWeb, progress) {
                if (progress == 100) {
                  controller.loadWeb(true);
                  controller.pullToRefreshController?.endRefreshing();
                }
              },
              onUpdateVisitedHistory: (controllerWeb, url, androidIsReload) {},
              onConsoleMessage: (controllerWeb, consoleMessage) {
                if (kDebugMode) {
                  print(consoleMessage);
                }
              },
            ),
          ),
        ],
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
