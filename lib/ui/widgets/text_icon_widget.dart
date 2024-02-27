import 'package:flutter/material.dart';

class TextIconWidget extends StatelessWidget {
  Widget? icon;
  String? text;
  TextStyle? textStyle;
  double? componentPadding;

  TextIconWidget({Key? key, this.icon, this.text, this.textStyle, this.componentPadding = 6}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) icon!,
        SizedBox(
          width: componentPadding,
        ),
        Text(
          text ?? "",
          style: textStyle,
        )
      ],
    );
  }
}
