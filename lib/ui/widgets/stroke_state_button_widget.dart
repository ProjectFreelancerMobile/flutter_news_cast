// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../../res/theme/theme_service.dart';

class StrokeStateButton extends StatefulWidget {
  final bool enable;
  final String? text;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final Color? borderColor;
  final Color? disableBorderColor;
  final TextStyle? textStyle;
  final TextStyle? disableTextStyle;
  final VoidCallback? onPressed;
  final double? radius;

  StrokeStateButton(
      {required this.enable,
      this.text,
      this.textStyle,
      this.disableTextStyle,
      this.width,
      this.height = 50,
      this.padding,
      this.borderColor,
      this.disableBorderColor,
      this.onPressed,
      this.radius = 5});

  @override
  State<StatefulWidget> createState() => _StrokeStateButtonState();
}

class _StrokeStateButtonState extends State<StrokeStateButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: widget.padding,
      splashColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.radius!),
        side: BorderSide(color: widget.enable ? widget.borderColor ?? getColor().themeColorB2B2B2 : widget.disableBorderColor ?? getColor().themeColorD3D3D4),
      ),
      onPressed: widget.enable ? widget.onPressed ?? () {} : () {},
      child: Text(
        widget.text ?? "",
        style: widget.enable ? widget.textStyle ?? text18.textColor141414 : widget.disableTextStyle ?? text18.textColor141414,
      ),
    );
  }
}

class ChangePhoneText extends StatefulWidget {
  final bool enable;
  final String? text;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final TextStyle? disableTextStyle;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;

  ChangePhoneText(
      {required this.enable,
      this.text,
      this.textStyle,
      this.disableTextStyle,
      this.width,
      this.height = 50,
      this.onPressed,
      this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6)});

  @override
  State<StatefulWidget> createState() => _ChangePhoneTextState();
}

class _ChangePhoneTextState extends State<ChangePhoneText> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.enable ? widget.onPressed ?? () {} : null,
      child: Container(
        padding: widget.padding,
        alignment: Alignment.center,
        child: Text(
          widget.text ?? "",
          style: widget.enable ? widget.textStyle ?? text18.textColor777777 : widget.disableTextStyle ?? text18.textColorB2B2B2,
        ),
      ),
    );
  }
}
