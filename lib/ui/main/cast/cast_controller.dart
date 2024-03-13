// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_news_cast/data/api/models/rss/post_model.dart';
import 'package:get/get.dart';

import '../../../data/api/repositories/rss_repository.dart';
import '../../base/base_controller.dart';
import '../../widgets/debound_util.dart';
import '../home/home_controller.dart';

class CastController extends BaseController {
  final _rssRepository = Get.find<RssRepository>();
  TextEditingController textSearchCl = TextEditingController();
  final postRss = Get.arguments?['item'] as PostModel?;

  bool get isShowScreenError => false;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
    isInspectable: false,
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllowFullscreen: true,
    transparentBackground: true,
  );
  PullToRefreshController? pullToRefreshController;

  bool get isHasLoadWeb => _isHasLoadWeb$.value;
  var _isHasLoadWeb$ = false.obs;

  bool get isHasBookmark => _isHasBookmark$.value;
  var _isHasBookmark$ = false.obs;

  String get postTitle => postRss?.title ?? '';

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
              await reloadWeb();
            },
          );
  }

  void initUrlCast(PostModel? postModel) {
    if (postModel == null) return;
    _isHasBookmark$.value = postModel.favorite;
    if (postModel.link.isNotEmpty) {
      textSearchCl.text = postModel.link;
      commitURL(textSearchCl.text);
    }
  }

  Future<void> reloadWeb() async {
    showLoading();
    if (defaultTargetPlatform == TargetPlatform.android) {
      webViewController?.reload();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      webViewController?.loadUrl(urlRequest: URLRequest(url: await webViewController?.getUrl()));
    }
  }

  void commitURL(String? url) {
    print('commitURL:$url');
    if (url?.isNotEmpty == true) {
      DeBouncer.run(() {
        showLoading();
        final urlWeb = url?.contains('http') == true ? (url ?? '') : ('https:///www.${url ?? ''}');
        webViewController?.loadUrl(urlRequest: URLRequest(url: WebUri(urlWeb)));
      });
    } else {
      loadWeb(false);
    }
  }

  void loadWeb(bool isDone) {
    print('loadWeb:$isDone');
    if (textSearchCl.text.isEmpty) {
      _isHasLoadWeb$.value = false;
    } else {
      _isHasLoadWeb$.value = isDone;
    }
    if (isDone) hideLoading();
  }

  void clearOrReload() async {
    print('clearOrReload');
    await reloadWeb();
    // if (isHasLoadWeb)
    //   textSearchCl.clear();
    // else
    //   await reloadWeb();
  }

  void saveBookMark() {
    if (textSearchCl.text.isEmpty) return;
    _isHasBookmark$.value = !isHasBookmark;
    _rssRepository.updatePostStatus(
      PostModel(
        title: textSearchCl.text,
        link: textSearchCl.text,
        image: '',
        content: textSearchCl.text,
        pubDate: DateTime.now(),
        favorite: true,
        fullText: false,
        isUrlCast: true,
      ),
      bookMark: isHasBookmark,
      readTime: null,
    );
    Get.find<HomeController>().getListBookMark();
  }

  String? validatorURL(String fieldName) {
    return (GetUtils.isNullOrBlank(textSearchCl.text) == true)
        ? 'sign_up_msg_is_required'.trParams(
            {
              'field': fieldName,
            },
          )
        : GetUtils.isLengthLessThan(textSearchCl.text, 3)
            ? 'sign_up_msg_is_at_least_3_characters'.trParams(
                {
                  'field': fieldName,
                },
              )
            : null;
  }

  @override
  void dispose() {
    textSearchCl.dispose();
    super.dispose();
  }
}
