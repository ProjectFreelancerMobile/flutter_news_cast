import 'package:get/get.dart';

class PaymentItem {
  String name;
  List<String> icons;
  RxBool isSelected;

  PaymentItem({required this.name, required this.icons, required this.isSelected});
}
