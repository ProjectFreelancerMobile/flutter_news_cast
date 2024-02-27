import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../../../res/theme/theme_service.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Widget? widgetChild;
  final TextStyle textStyle;
  final Color? textColor;
  final Function() onPressed;
  final double? radius;
  final double? width;
  final double? height;
  final int? elevation;
  final bool? isEnable;
  final Color? background;
  final ImageProvider<Object>? imageBackground;
  final Gradient? gradient;
  final BoxBorder? boxBorder;

  CustomButton({
    required this.text,
    required this.textStyle,
    required this.onPressed,
    this.widgetChild,
    this.radius = 8,
    this.width = 120,
    this.height = 60,
    this.elevation = 0,
    this.isEnable = false,
    this.textColor,
    this.background,
    this.imageBackground,
    this.boxBorder,
    this.gradient,
  });

  @override
  State<StatefulWidget> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.isEnable == true ? widget.onPressed() : null,
      child: Container(
        width: widget.width,
        height: widget.height?.ws,
        alignment: Alignment.center,
        decoration: widget.imageBackground != null
            ? BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(widget.radius != null ? widget.radius!.ws : 8.ws)),
                border: widget.boxBorder,
                image: DecorationImage(
                  image: widget.imageBackground!,
                  fit: BoxFit.fill,
                ),
              )
            : BoxDecoration(
                color: widget.isEnable == true ? widget.background ?? getColor().themeColorBackground : getColor().themeColorGrey,
                borderRadius: BorderRadius.all(Radius.circular(widget.radius != null ? widget.radius!.ws : 8.ws)),
                gradient: widget.gradient,
                border: widget.boxBorder,
              ),
        child: widget.widgetChild ??
            Text(
              widget.text,
              style: widget.isEnable == true
                  ? (widget.textColor != null ? widget.textStyle.copyWith(color: widget.textColor) : widget.textStyle)
                  : widget.textStyle.copyWith(color: colorTextGrey),
            ),
      ),
    );
  }
}
