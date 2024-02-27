import 'package:get/get.dart';

import '../../ui/main/home/home_controller.dart';
import '../../ui/main/main_controller.dart';
import '../notification/list_notification_controller.dart';
import '../settings/settings_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
    //Home
    Get.put(HomeController());
    //Notification
    Get.put(ListNotificationController());
    //Settings
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
