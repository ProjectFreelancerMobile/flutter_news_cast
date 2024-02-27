import 'package:get/instance_manager.dart';
import 'package:flutter_news_cast/ui/settings/settings_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController());
  }
}
