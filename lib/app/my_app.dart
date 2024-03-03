import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import '../../res/languages/localization_service.dart';
import '../data/api/models/notification_item.dart';
import '../res/style.dart';
import 'app_controller.dart';
import 'app_pages.dart';

class MyApp extends GetWidget<AppController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Obx(
        () => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: textLocalization('appName'),
          translations: LocalizationService(),
          locale: controller.locale?.value,
          //theme: controller.themeData?.value,
          initialRoute: _getRoute(),
          getPages: AppPages.pages,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'), // English
            const Locale('vi', 'VN'), // Vietname
          ],
        ),
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
        return AppRoutes.MAIN;
      case AuthState.authorized:
        return AppRoutes.MAIN;
      case AuthState.new_install:
        return AppRoutes.MAIN;
      case AuthState.uncompleted:
        return AppRoutes.UPDATE_PROFILE;
      default:
        return AppRoutes.MAIN;
    }
  }
}

mixin HandleNotificationMixin {
  handleNotification(NotificationItem notificationItem) async {}
}
