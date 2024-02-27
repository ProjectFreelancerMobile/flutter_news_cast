import 'package:flutter/material.dart';

class LineRoundButton extends StatelessWidget {
  final Color? lineColor;
  final TextStyle? textStyle;
  final String text;
  final double? radius;
  final double? lineWidth;
  final EdgeInsetsGeometry? padding;

  LineRoundButton({required this.text, this.lineColor = Colors.black, this.textStyle, this.radius = 5.0, this.padding, this.lineWidth = 0.5});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius!), border: Border.all(color: lineColor!, width: lineWidth!)),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
