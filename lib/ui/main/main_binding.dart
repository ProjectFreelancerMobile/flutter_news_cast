import 'package:get/get.dart';

import '../../ui/main/home/home_controller.dart';
import '../../ui/main/main_controller.dart';
import 'settings/settings_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
    //Home
    Get.put(HomeController());

    //Service
    //Get.put(ServiceController());

    //Settings
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
