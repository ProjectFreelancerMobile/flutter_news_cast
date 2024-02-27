import 'package:get/instance_manager.dart';

import '../add_user/add_user_controller.dart';

class AddUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddUserController());
  }
}
