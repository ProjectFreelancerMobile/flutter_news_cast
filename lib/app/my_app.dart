import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_news_cast/ui/main/home/home_controller.dart';
import 'package:get/get.dart';

import '../../res/languages/localization_service.dart';
import '../data/api/models/notification_item.dart';
import '../res/style.dart';
import 'app_controller.dart';
import 'app_pages.dart';

class TravelApp extends GetWidget<AppController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Obx(
        () => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: textLocalization('appName'),
            translations: LocalizationService(),
            locale: controller.locale?.value,
            theme: controller.themeData?.value,
            initialRoute: _getRoute(),
            getPages: AppPages.pages,
            defaultTransition: Transition.rightToLeft,
            transitionDuration: Duration(milliseconds: 0),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) => Overlay(
                  initialEntries: [
                    if (child != null) ...[
                      OverlayEntry(
                        builder: (context) => child,
                      ),
                    ],
                  ],
                ),
            supportedLocales: [
              const Locale('en', 'US'), // English
              const Locale('vi', 'VN'), // Vietname
            ],
            navigatorKey: Get.key,
            routingCallback: (routing) {
              if (routing?.current == AppRoutes.MAIN && routing?.previous != AppRoutes.SPLASH) {
                try {
                  Get.find<HomeController>().autoRefreshList();
                } catch (e) {}
              }
            }),
      ),
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }

  String _getRoute() {
    if (kDebugMode) {
      return AppRoutes.SPLASH;
    }
    switch (controller.authState.value) {
      case AuthState.unauthorized:
        return AppRoutes.INITIAL;
      case AuthState.authorized:
        return AppRoutes.MAIN;
      case AuthState.new_install:
        return AppRoutes.MAIN;
      case AuthState.uncompleted:
        return AppRoutes.UPDATE_PROFILE;
      default:
        return AppRoutes.SPLASH;
    }
  }
}

mixin HandleNotificationMixin {
  handleNotification(NotificationItem notificationItem) async {}
}
