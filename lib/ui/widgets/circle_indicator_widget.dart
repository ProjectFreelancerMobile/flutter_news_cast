import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../../res/theme/theme_service.dart';

class CircleIndicatorWidget extends StatefulWidget {
  final int totalStep;
  final int currentStep;
  final Color? unselectedColor;
  final Color? selectedColor;
  final double size;
  final double? itemMargin;

  CircleIndicatorWidget(this.size, this.totalStep, this.currentStep, {this.selectedColor, this.unselectedColor, this.itemMargin});

  @override
  State<StatefulWidget> createState() => _CircleIndicatorWidgetState();
}

class _CircleIndicatorWidgetState extends State<CircleIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildIndicator();
  }

  Widget _buildIndicator() {
    List<Widget> items = [];
    for (int i = 0; i < widget.totalStep; i++) {
      // từ phần tử thứ 2 trở đi sẽ thêm khoảng cách giữa các phần tử vào
      if (i != 0)
        items.add(SizedBox(
          width: widget.itemMargin ?? 8.ws,
        ));
      items.add(Container(
        height: widget.size,
        width: i == widget.currentStep ? widget.size * 3 : widget.size,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.size / 2),
            color: i == widget.currentStep ? widget.selectedColor ?? getColor().themeColorPrimary : widget.unselectedColor ?? getColor().themeColorB2B2B2),
      ));
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
  }
}
