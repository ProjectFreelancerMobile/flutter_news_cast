import 'package:flutter/material.dart';
import 'package:flutter_news_cast/app/app_controller.dart';
import 'package:flutter_news_cast/app/app_pages.dart';
import 'package:get/get.dart';

import '../../res/style.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  final appController = Get.find<AppController>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      // if (kDebugMode) {
      //   return Get.offNamed(AppRoutes.MAIN);
      // }
      switch (appController.authState.value) {
        case AuthState.unauthorized:
          return Get.offNamed(AppRoutes.INITIAL);
        case AuthState.authorized:
          return Get.offNamed(AppRoutes.MAIN);
        case AuthState.new_install:
          return Get.offNamed(AppRoutes.MAIN);
        case AuthState.uncompleted:
          return Get.offNamed(AppRoutes.MAIN);
        default:
          return Get.offNamed(AppRoutes.MAIN);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.icons.icLogoSplash.svg(width: 100.ws, height: 150.hs),
            SizedBox(height: 20),
            Text(
              textLocalization('appName').toUpperCase(),
              style: text34.bold.textColorWhite,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
