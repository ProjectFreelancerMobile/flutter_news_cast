// ignore_for_file: invalid_use_of_protected_member
import 'package:favicon/favicon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_cast/data/api/models/rss/post_model.dart';
import 'package:get/get.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/api/repositories/rss_repository.dart';
import '../../../res/style.dart';
import '../../../res/theme/theme_service.dart';
import '../../base/base_controller.dart';

class CastController extends BaseController {
  final _rssRepository = Get.find<RssRepository>();
  TextEditingController textSearchCl = TextEditingController();
  PostModel? postModel;

  final focusNode = FocusNode().obs;

  bool get isShowScreenError => false;

  bool get isHasLoadWeb => _isHasLoadWeb$.value;
  var _isHasLoadWeb$ = false.obs;

  bool get isHasCanBack => _isHasCanBack$.value;
  var _isHasCanBack$ = false.obs;

  bool get isHasEditUrl => _isHasEditUrl$.value;
  var _isHasEditUrl$ = false.obs;

  bool get isHasBookmark => _isHasBookmark$.value;
  var _isHasBookmark$ = false.obs;

  String get postTitle => postModel?.title ?? '';

  bool get isHasDoneUrl => !isHasEditUrl && isHasLoadWeb;
  late WebViewController webController;
  bool isFirstFromHome = false;

  @override
  void onInit() async {
    super.onInit();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(getColor().bgThemeColorBackground)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) async {
            if (progress == 100) {
              loadWeb(true);
            }
          },
          onPageStarted: (String url) {
            Future.delayed(Duration(seconds: 1), () {
              updateStateCanBack(url: url);
              checkPostStatus(postModel, url);
            });
          },
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            postModel = null;
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
    if (postModel.link.isNotEmpty) {
      isFirstFromHome = true;
      textSearchCl.text = postModel.link;
      commitURL(textSearchCl.text, postModel: postModel);
    }
  }

  void initBackground() {
    webController.setBackgroundColor(getColor().bgThemeColorBackground);
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
    _isHasBookmark$.value = false;
    if (url?.isNotEmpty == true) {
      this.postModel = postModel;
      print('this.postModel::' + this.postModel.toString());
      showLoading();
      var urlWeb;
      var urlFull = url ?? '';
      if (isInputEdit) {
        if (!urlFull.contains('http://') || urlFull.contains('https://')) {
          urlFull = ('http://$urlFull');
        }
        print('urlFull::' + urlFull.toString());
        final isUrl = urlFull.isUrl();
        print('listString::' + isUrl.toString());

        if (isUrl) {
          urlWeb = Uri.parse(urlFull);
        } else {
          urlWeb = Uri.parse("https://www.google.com/search?q=$url");
        }
      } else {
        urlWeb = Uri.parse(urlFull);
      }
      print('urlWeb::' + urlWeb.toString() + "postModel::" + this.postModel.toString());
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

  void updateStateCanBack({String? url}) async {
    if (!isFirstFromHome) {
      postModel = null;
    } else {
      isFirstFromHome = false;
    }
    _isHasCanBack$.value = await webController.canGoBack();
    if (url != null) {
      textSearchCl.text = url;
    } else {
      webController.currentUrl().then((value) {
        if (value != null) {
          textSearchCl.text = value;
        }
      });
    }
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
    if (postModel != null) {
      if (postModel?.title == null || postModel?.title.length == 0) {
        postModel?.title = await webController.getTitle() ?? textSearchCl.text;
      }
      postModel?.favorite = isHasBookmark;
      print('saveBookMark::' + postModel.toString());
      await _rssRepository.updatePostStatus(
        postModel!,
        bookMark: isHasBookmark,
        readTime: postModel?.readDate,
      );
    }
  }

  void checkPostStatus(PostModel? postModelItem, String? url) async {
    print('checkPostStatus::$url');
    if (postModelItem != null) {
      print('checkPostBookmark:0000::' + postModel.toString());
      _isHasBookmark$.value = postModelItem.favorite;
      postModel?.readDate = DateTime.now();
    } else {
      _rssRepository.getPostBookmark(url).then((value) {
        if (value != null) {
          print('checkPostBookmark:1111::' + value.toString());
          postModel = value;
          _isHasBookmark$.value = value.favorite;
        }
      });
    }
    if (postModel == null) {
      _isHasBookmark$.value = postModel?.favorite ?? false;
      postModel = await getCreatePostModel(url);
      print('checkPostBookmark:3333::' + postModel.toString());
    }
    if (postModel != null) {
      _rssRepository.updatePostStatus(postModel!, bookMark: postModel!.favorite, readTime: postModel!.readDate);
    }
  }

  Future<PostModel> getCreatePostModel(String? url) async {
    print('postModel::' + postModel.toString());
    if (postModel != null) {
      return postModel!;
    } else {
      final title = await webController.getTitle() ?? textSearchCl.text;
      var iconUrl;
      try {
        iconUrl = await FaviconFinder.getBest(url ?? '');
      } catch (e) {
        if (url?.contains('zingmp3.vn') == true) {
          iconUrl = Favicon(Assets.icons.icZingmp3.path);
        } else {
          iconUrl = null;
        }
      }
      print('title:::' + title.toString());
      //final idPost = await _rssRepository.getIdPost();
      return postModel ??
          PostModel(
            //id: idPost,
            title: title,
            link: url ?? textSearchCl.text,
            icon: iconUrl?.url ?? '',
            image: iconUrl?.url ?? '',
            content: title,
            readDate: DateTime.now(),
            pubDate: DateTime.now(),
            favorite: false,
            fullText: false,
          );
    }
  }

  @override
  void dispose() {
    print('disposedisposedisposedispose');
    clearAddress();
    textSearchCl.dispose();
    super.dispose();
  }
}
