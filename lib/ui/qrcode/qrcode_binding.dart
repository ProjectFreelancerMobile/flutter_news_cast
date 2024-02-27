import 'package:get/instance_manager.dart';

import 'qrcode_controller.dart';

class QRCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(QRCodeController());
  }
}
