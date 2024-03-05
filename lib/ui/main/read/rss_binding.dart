import 'package:get/get.dart';
import 'rss_controller.dart';


class RssBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RssController());
  }
}
