import 'package:get/instance_manager.dart';

import '../../ui/notification/list_notification_controller.dart';

class ListNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ListNotificationController());
  }
}
