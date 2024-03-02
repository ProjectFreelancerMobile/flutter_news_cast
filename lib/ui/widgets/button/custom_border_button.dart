import 'package:flutter/material.dart';

import '../../../res/theme/theme_service.dart';

class CustomBorderButton extends StatefulWidget {
  final String text;
  final TextStyle? textStyle;
  final Function() onPressed;
  final double? radius;
  final double? width;
  final double? height;
  final int? elevation;
  final bool? isEnable;
  final Color? borderColor;

  CustomBorderButton(
      {required this.text,
      required this.textStyle,
      required this.onPressed,
      this.radius = 14,
      this.width = 120,
      this.height = 40,
      this.elevation = 0,
      this.isEnable = false,
      this.borderColor});

  @override
  State<StatefulWidget> createState() => _CustomBorderButtonState();
}

class _CustomBorderButtonState extends State<CustomBorderButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.isEnable! ? widget.onPressed() : null,
      child: Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: widget.isEnable! ? getColor().themeColorWhite : getColor().themeColorEBEBEC,
          border: Border.all(width: 1, color: widget.borderColor ?? getColor().themeColorPrimary),
          borderRadius: BorderRadius.all(Radius.circular(widget.radius!)),
        ),
        child: Text(
          widget.text,
          style: widget.textStyle,
        ),
      ),
    );
  }
}
