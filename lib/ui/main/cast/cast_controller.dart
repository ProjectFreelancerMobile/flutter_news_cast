// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_cast/data/api/models/rss/post_model.dart';
import 'package:flutter_news_cast/res/theme/theme_service.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/api/repositories/rss_repository.dart';
import '../../base/base_controller.dart';
import '../home/home_controller.dart';

class CastController extends BaseController {
  final _rssRepository = Get.find<RssRepository>();
  TextEditingController textSearchCl = TextEditingController();
  PostModel? postModel;

  bool get isShowScreenError => false;

  bool get isHasLoadWeb => _isHasLoadWeb$.value;
  var _isHasLoadWeb$ = false.obs;

  bool get isHasEditUrl => _isHasEditUrl$.value;
  var _isHasEditUrl$ = false.obs;

  bool get isHasBookmark => _isHasBookmark$.value;
  var _isHasBookmark$ = false.obs;

  String get postTitle => postModel?.title ?? '';

  bool get isHasDoneUrl => !isHasEditUrl && isHasLoadWeb;
  late WebViewController webController;

  @override
  void onInit() async {
    super.onInit();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(getColor().bgThemeColorBackground)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              loadWeb(true);
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
  }

  void initUrlCast(PostModel? postModel) async {
    if (postModel == null) return;
    this.postModel = postModel;
    _isHasBookmark$.value = await getBookMark(postModel);
    if (postModel.link.isNotEmpty) {
      textSearchCl.text = postModel.link;
      commitURL(textSearchCl.text, postModel: postModel);
    }
  }

  void clearAddress() {
    postModel = null;
    _isHasLoadWeb$.value = false;
    textSearchCl.text = '';
  }

  Future<void> reloadWeb() async {
    showLoading();
    if (defaultTargetPlatform == TargetPlatform.android) {
      webController.reload();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      webController.loadRequest(Uri.parse(textSearchCl.text));
    }
  }

  void commitURL(String? url, {bool isInputEdit = false, PostModel? postModel}) {
    if (url?.isNotEmpty == true) {
      print('commitURL:$url');
      updatePostRecent(postModel);
      var urlWeb = Uri.parse(url!);
      if (urlWeb.scheme.isEmpty) {
        urlWeb = Uri.parse("https://www.google.com/search?q=$url");
      } else {
        urlWeb = Uri.parse(url.contains('http') == true ? (url ?? '') : ('https:///www.${url ?? ''}'));
      }
      showLoading();
      webController.loadRequest(urlWeb);
    } else {
      loadWeb(false);
    }
  }

  void onChangeUrl() {
    _isHasEditUrl$.value = true;
  }

  void loadWeb(bool isDone) {
    _isHasEditUrl$.value = false;
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
    if (isHasDoneUrl)
      await reloadWeb();
    else
      textSearchCl.clear();
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

  //Bookmark
  void saveBookMark() async {
    if (textSearchCl.text.isEmpty) return;
    _isHasBookmark$.value = !isHasBookmark;
    //final icon = await webController?.getFavicons();
    //final iconUrl = icon?.first.url.rawValue;
    print('saveBookMark::' + isHasBookmark.toString());
    var postBookmark = await getCreatePostModel();
    postBookmark.favorite = isHasBookmark;
    _rssRepository.updatePostStatus(
      postBookmark,
      bookMark: isHasBookmark,
      readTime: DateTime.now(),
    );
    Get.find<HomeController>().getListBookMark();
  }

  void updatePostRecent(PostModel? postModel) async {
    var postBookmark = postModel;
    if (postBookmark == null) {
      postBookmark = await getCreatePostModel();
    }
    print('updatePostRecent::' + postBookmark.toString());
    _rssRepository.updatePostStatus(postBookmark, readTime: DateTime.now());
  }

  Future<bool> getBookMark(PostModel postModel) {
    return _rssRepository.getBookmark(postModel);
  }

  Future<PostModel> getCreatePostModel() async {
    return postModel ??
        PostModel(
          title: await webController.getTitle() ?? '',
          link: textSearchCl.text,
          image: '',
          //iconUrl
          content: await webController.getTitle() ?? '',
          pubDate: DateTime.now(),
          favorite: isHasBookmark,
          fullText: false,
          isUrlCast: true,
        );
  }

  @override
  void dispose() {
    print('disposedisposedisposedispose');
    clearAddress();
    textSearchCl.dispose();
    super.dispose();
  }
}
