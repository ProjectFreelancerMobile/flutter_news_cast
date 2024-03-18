import 'package:flutter/material.dart';

class ButtonIconTextWidget extends StatelessWidget {
  final Widget? icon;
  final Widget? text;
  final Function()? onPressed;

  ButtonIconTextWidget({
    Key? key,
    this.icon,
    this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final style = TextButton.styleFrom(
      padding: EdgeInsets.zero,
      minimumSize: Size(50, 30),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      alignment: Alignment.centerLeft,
    );
    return text != null
        ? TextButton(
            onPressed: onPressed,
            child: text!,
            style: style,
          )
        : icon != null
            ? IconButton(
                onPressed: onPressed,
                icon: icon!,
                style: style,
              )
            : SizedBox();
  }
}
