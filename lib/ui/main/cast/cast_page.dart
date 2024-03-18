import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/res/theme/theme_service.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../base/base_page.dart';
import '../../widgets/button/text_button_widget.dart';
import '../../widgets/input/text_form_field_widget.dart';
import 'cast_controller.dart';

//ignore: must_be_immutable
class CastPage extends BasePage<CastController> {
  @override
  Widget buildContentView(BuildContext context, CastController controller) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Material(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.ws, vertical: 24.ws),
                child: Row(
                  children: [
                    ButtonIconTextWidget(
                      onPressed: () {
                        controller.webController.goBack();
                        controller.updateStateCanBack();
                      },
                      icon: controller.isHasCanBack ? Assets.icons.icBack.svg() : Assets.icons.icBack.svg(color: Colors.black12),
                    ),
                    Expanded(
                      child: DTextFromField(
                        keyboardType: TextInputType.text,
                        controller: controller.textSearchCl,
                        textStyle: text16.textColor141414,
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 16.ws),
                          child: controller.isHasEditUrl ? Icon(Icons.search) : Assets.icons.icCastLock.svg(),
                        ),
                        suffixIcon: MaterialButton(
                          onPressed: () {
                            controller.clearOrReload();
                          },
                          height: 24.ws,
                          minWidth: 24.ws,
                          padding: EdgeInsets.all(0),
                          child: controller.isHasEditUrl ? Assets.icons.icRemove.svg() : Assets.icons.icCastReplay.svg(),
                        ),
                        iconContraints: BoxConstraints(maxWidth: 40.ws, maxHeight: 24, minHeight: 24),
                        background: getColor().themeColorEBEBEC,
                        borderRadius: 18,
                        strokeColor: Colors.transparent,
                        hintText: textLocalization('feed.search.url'),
                        contentPadding: EdgeInsets.symmetric(horizontal: 2.ws, vertical: 12.ws),
                        onValidated: (val) {
                          return controller.validatorURL('Địa chỉ URL');
                        },
                        onFieldSubmitted: (value) {
                          controller.commitURL(value, isInputEdit: true);
                        },
                        onChange: (value) {
                          controller.onChangeUrl();
                        },
                      ),
                    ),
                    SizedBox(width: 12.ws),
                    TouchableOpacity(
                      onPressed: () => controller.saveBookMark(),
                      child: controller.isHasBookmark
                          ? Icon(Icons.bookmark, size: 24.ws, color: Color(0xFF333333))
                          : Icon(Icons.bookmark_border, size: 24.ws, color: Color(0xFF333333)),
                    ),
                    // IconButton(onPressed: () {}, icon: Assets.icons.icCast.svg(height: 22.ws)),
                  ],
                ),
              ),
              /*Expanded(
          child: InAppWebView(
            key: controller.webViewKey,
            keepAlive: controller.keepAlive,
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
        ),*/
              Expanded(
                child: GestureDetector(
                  child: WebViewWidget(controller: controller.webController),
                  onTapDown: (value) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
