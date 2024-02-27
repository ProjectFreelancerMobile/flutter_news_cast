import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_news_cast/app/app_controller.dart';
import 'package:flutter_news_cast/app/app_pages.dart';

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
    Future.delayed(const Duration(seconds: 1), () {
      initNavigation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Assets.images.imgSplash.image().image,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Future<dynamic>? initNavigation() {
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
  }

  @override
  void dispose() {
    super.dispose();
  }
}
