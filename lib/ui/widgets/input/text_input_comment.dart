import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

class TextInputComment extends StatelessWidget {
  final Color? background;
  final double? radius;
  final TextEditingController controller;
  final double? width;
  final double? height;
  final String hint;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final bool? isInput;
  final VoidCallback? onPressed;

  TextInputComment(
      {required this.controller,
      required this.hint,
      this.background = Colors.white,
      this.radius = 5,
      this.width = 200,
      this.height = 50,
      this.hintStyle,
      this.textStyle,
      this.isInput = true,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 10.ws, vertical: 0.ws),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(radius!)), color: background),
      child: TextField(
        style: textStyle,
        controller: controller,
        scrollPadding: EdgeInsets.all(0),
        enableInteractiveSelection: isInput,
        enabled: isInput,
        decoration: new InputDecoration(hintText: hint, hintStyle: hintStyle, border: InputBorder.none),
      ),
    );
  }
}
