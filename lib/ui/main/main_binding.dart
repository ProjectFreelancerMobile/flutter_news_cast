import 'package:get/get.dart';

import '../../ui/main/home/home_controller.dart';
import '../../ui/main/main_controller.dart';
import 'cast/cast_controller.dart';
import 'settings/settings_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
    //Home
    Get.put(HomeController());
    //Cast
    Get.lazyPut(
      () => CastController(),
      tag: Get.arguments?['id'].toString() ?? '',
      fenix: true,
    );

    //Settings
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
