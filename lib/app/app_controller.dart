import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/languages/localization_service.dart';
import '../../res/theme/app_theme.dart';
import '../../res/theme/theme_service.dart';
import '../app/app_pages.dart';
import '../data/api/api_constants.dart';
import '../data/api/models/TUser.dart';
import '../data/api/models/payment/payment_item.dart';
import '../data/api/rest_client.dart';
import '../data/storage/my_storage.dart';
import '../res/style.dart';
import 'base_app_config.dart';

class AppController extends GetxController {
  Environment? env;
  Rx<Locale?>? locale;
  Rx<ThemeData?>? themeData;
  Rx<AuthState> authState = AuthState.unauthorized.obs;
  TUser? user;
  PaymentItem paymentItem = PaymentItem();
  var indexTheme = 0.obs;

  void resetPayment() {
    paymentItem = PaymentItem();
  }

  void updateAppTheme(int index) {
    indexTheme.value = index;
  }

  ImageProvider<Object> themeMain() {
    print('themeMain::'+ indexTheme.toString());
    if (indexTheme == 0) {
      return Assets.images.imgThemeBgTet.image().image;
    } else if (indexTheme == 1) {
      return Assets.images.imgThemeBgMain.image().image;
    } else if (indexTheme == 2) {
      return Assets.images.imgThemeBgMain2.image().image;
    } else {
      return Assets.images.imgThemeBgMain.image().image;
    }
  }

  init(Environment environment) async {
    this.env = environment;
    await Future.wait([initStorage()]);
    await setupLocator();
    await initTheme();
    await initLanguage();
    await initAuth();
    final storage = Get.find<MyStorage>();
    indexTheme.value = await storage.getAppTheme();
    //initPhotos();
  }

  Future<void> initAuth() async {
    final storage = Get.find<MyStorage>();
    user = await storage.getUserInfo();
    print('initAuth::success:${user}');
    if (user != null) {
      await initApi();
      if (user?.userExist == true) {
        authState.value = AuthState.authorized;
      } else {
        authState.value = AuthState.uncompleted;
      }
    } else {
      await initApi();
      authState.value = AuthState.unauthorized;
    }
  }

  Future<void> initStorage() async {
    final storage = Get.put(MyStorage());
    await storage.init();
  }

  Future<void> initPhotos() async {
    //Get.put(PhotoProvider()).init();
  }

  logout() async {
    user = null;
    locale = null;
    themeData = null;
    await Get.find<MyStorage>().logout();
    Get.offAllNamed(AppRoutes.MAIN);
  }

  Future<void> initTheme() async {
    await Get.put(ThemeService()).init();
    final themeService = Get.find<ThemeService>();
    themeData = themeService.themeData.obs;
    //Lang nghe su thay doi theme khi luu vao storage
    themeService.store.box.listenKey(MyStorage.APP_THEME, (value) {
      if (value != null) if (themeData != null) {
        themeData!.value = appThemeData[themeService.getAppTheme(value)];
      } else {
        themeData = appThemeData[themeService.getAppTheme(value)].obs;
      }
    });
  }

  Future<void> initLanguage() async {
    await Get.put(LocalizationService()).init();
    final localeService = Get.find<LocalizationService>();
    locale = localeService.getLocale.obs;
    //Lang nghe su thay doi theme khi luu vao storage
    localeService.store.box.listenKey(MyStorage.APP_LANGUAGE, (value) {
      if (value != null) locale!.value = Locale(value);
    });
  }

  initApi({String? token}) async {
    String baseUrl;
    // init api
    switch (env!) {
      case Environment.dev:
        baseUrl = BASE_URL_DEV;
        break;
      case Environment.prod:
        baseUrl = BASE_URL_PROD;
        break;
    }
    RestClient.instance.init(
      baseUrl,
      accessToken: token ?? "",
    );
    //Get.put(PushNotificationManager()).init();
  }

  Future<void> updateUserInfo(TUser userInfo) async {
    this.user = userInfo;
    if (user!.taiKhoanChuyenTien.isNotEmpty) {
      authState.value = AuthState.authorized;
      Get.offAllNamed(AppRoutes.MAIN);
    } else {
      authState.value = AuthState.uncompleted;
      Get.offAllNamed(AppRoutes.SPLASH);
    }
  }

  Future<void> updateOnlyUserInfo(TUser userInfo) async {
    this.user = userInfo;
  }

  @override
  void onClose() {
    // Close all service
    Get.reset();
    super.onClose();
  }

  updateFirebaseToken({String? token}) async {
    // if (token == null) {
    //   token = await Get.find<MyStorage>().getDeviceToken();
    // } else {
    //   Get.find<MyStorage>().saveDeviceToken(token);
    // }
    // if (user != null) {
    //   String deviceId = await getDeviceId();
    //   String verName = packageInfo.version;
    //   String verCode = packageInfo.buildNumber;
    //   Get.find<UserRepository>().updateFirebaseToken(
    //       token: token!,
    //       deviceId: deviceId,
    //       verName: verName,
    //       verCode: verCode);
    // }
  }
}

enum AuthState { unauthorized, authorized, uncompleted, new_install }
