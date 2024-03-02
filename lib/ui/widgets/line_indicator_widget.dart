import 'package:flutter/cupertino.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:get/get.dart';

class LineIndicatorWidget extends GetWidget {
  final int totalStep;
  final RxInt currentStep;
  final unselectedColor;
  final selectedColor;

  LineIndicatorWidget(this.totalStep, this.currentStep, {this.selectedColor = colorPrimary, this.unselectedColor = colorB2B2B2});

  @override
  Widget build(BuildContext context) {
    return Obx(() => _buildIndicator());
  }

  Widget _buildIndicator() {
    List<Widget> items = [];
    for (int i = 0; i < totalStep; i++) {
      // từ phần tử thứ 2 trở đi sẽ thêm khoảng cách giữa các phần tử vào
      if (i != 0)
        items.add(SizedBox(
          width: 5,
        ));
      items.add(Container(
        height: 6,
        width: i == currentStep.value ? 18 : 6,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: i == currentStep.value ? selectedColor : unselectedColor),
      ));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
  }
}
