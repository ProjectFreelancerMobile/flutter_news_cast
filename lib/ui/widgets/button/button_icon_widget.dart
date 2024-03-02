import 'package:flutter/material.dart';

import '../../../res/theme/theme_service.dart';

class ButtonIconWidget extends StatefulWidget {
  final double width;
  final double height;
  final double? radius;
  final Color background;
  final Widget icon;
  final double? borderWidth;

  ButtonIconWidget({Key? key, required this.icon, required this.width, required this.height, required this.background, this.radius = 3, this.borderWidth = 0}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ButtonIconWidgetState();
}

class _ButtonIconWidgetState extends State<ButtonIconWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(widget.radius!)),
          border: Border.all(color: getColor().themeColorFF6F15, width: widget.borderWidth!),
          color: widget.background),
      child: widget.icon,
    );
  }
}
