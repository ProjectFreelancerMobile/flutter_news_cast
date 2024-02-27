import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../button/touchable_opacity.dart';

class TextInputSearch extends StatelessWidget {
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

  TextInputSearch(
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
      padding: EdgeInsets.symmetric(horizontal: 10.ws),
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(radius!)), color: background),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            DImages.searchGray,
            width: 16.ws,
            height: 16.ws,
          ),
          SizedBox(
            width: 5.ws,
          ),
          TouchableOpacity(
            child: SizedBox(
              width: (width! - 65),
              child: TextField(
                style: textStyle,
                controller: controller,
                scrollPadding: EdgeInsets.all(0),
                enableInteractiveSelection: isInput,
                enabled: isInput,
                decoration: new InputDecoration(hintText: hint, hintStyle: hintStyle, border: InputBorder.none),
              ),
            ),
            onPressed: () {
              if (onPressed != null) onPressed!();
            },
          ),
          Spacer(),
          Image.asset(
            DImages.textClear,
            width: 16.ws,
            height: 16.ws,
          ),
        ],
      ),
    );
  }
}
