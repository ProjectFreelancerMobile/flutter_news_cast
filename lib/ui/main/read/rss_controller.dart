// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_news_cast/data/api/models/rss/post_model.dart';
import 'package:flutter_news_cast/data/api/repositories/rss_repository.dart';
import 'package:flutter_news_cast/ui/main/home/home_controller.dart';
import 'package:get/get.dart';

import '../../../app/app_controller.dart';
import '../../base/base_controller.dart';
import '../main_controller.dart';

class RssController extends BaseController {
  final _mainController = Get.find<MainController>();
  final _rssRepository = Get.find<RssRepository>();
  final _appController = Get.find<AppController>();
  final postRss = Get.arguments?['item'] as PostModel?;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    useShouldInterceptRequest: true,
    isInspectable: false,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllowFullscreen: true,
  );
  PullToRefreshController? pullToRefreshController;

  bool get isShowScreenError => false;

  String get postTitle => postRss?.title ?? '';

  bool get isHasBookmark => _isHasBookmark$.value;
  var _isHasBookmark$ = false.obs;

  @override
  void onClose() {
    print('HomeController:onClose');
    super.onClose();
  }

  @override
  void onInit() async {
    super.onInit();
    print('RssController:::' + postRss.toString());
    _isHasBookmark$.value = await getBookMark();
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
    updatePost();
    Future.delayed(Duration(milliseconds: 200), () {
      webViewController?.loadUrl(urlRequest: URLRequest(url: WebUri(postRss?.link ?? '')));
    });
  }

  void updateStateBookmark() {
    _isHasBookmark$.value = !isHasBookmark;
  }

  void saveBookMark() {
    if (postRss == null) return;
    updateStateBookmark();
    _rssRepository.updatePostStatus(postRss!, bookMark: isHasBookmark, readTime: DateTime.now());
    Get.find<HomeController>().getListBookMark();
  }

  void updatePost() {
    if (postRss == null) return;
    _rssRepository.updatePostStatus(postRss!, readTime: DateTime.now());
  }

  Future<bool> getBookMark() {
    if (postRss == null) return Future.value(false);
    return _rssRepository.getBookmark(postRss!);
  }
}
