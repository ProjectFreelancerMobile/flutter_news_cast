// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_news_cast/data/api/repositories/rss_repository.dart';
import 'package:get/get.dart';

import '../../../app/app_controller.dart';
import '../../base/base_controller.dart';
import '../main_controller.dart';

class RssController extends BaseController {
  final _mainController = Get.find<MainController>();
  final _rssRepository = Get.find<RssRepository>();
  final _appController = Get.find<AppController>();
  final urlRss = Get.arguments as String;
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(isInspectable: false, mediaPlaybackRequiresUserGesture: false, allowsInlineMediaPlayback: true, iframeAllowFullscreen: true);
  PullToRefreshController? pullToRefreshController;
  double progress = 0;

  bool get isShowScreenError => false;

  @override
  void onClose() {
    print('HomeController:onClose');
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    pullToRefreshController = kIsWeb
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS) {
                webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );
    Future.delayed(Duration(milliseconds: 500), () {
      webViewController?.loadUrl(urlRequest: URLRequest(url: WebUri(urlRss)));
    });
  }
}
