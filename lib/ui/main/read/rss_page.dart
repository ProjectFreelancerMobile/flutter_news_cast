import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../base/base_page.dart';
import 'rss_controller.dart';

//ignore: must_be_immutable
class RssPage extends BasePage<RssController> {
  @override
  Widget buildContentView(BuildContext context, RssController controller) {
    return Scaffold(
      body: InAppWebView(
        key: controller.webViewKey,
        initialSettings: controller.settings,
        pullToRefreshController: controller.pullToRefreshController,
        onWebViewCreated: (controllerWeb) {
          controller.webViewController = controllerWeb;
        },
        onLoadStart: (controller, url) {},
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
            controller.pullToRefreshController?.endRefreshing();
          }
        },
        onUpdateVisitedHistory: (controllerWeb, url, androidIsReload) {},
        onConsoleMessage: (controlcontrollerWebler, consoleMessage) {
          if (kDebugMode) {
            print(consoleMessage);
          }
        },
      ),
    );
  }
}
