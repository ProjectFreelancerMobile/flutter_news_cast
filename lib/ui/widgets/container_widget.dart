import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

class ContainerBase extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final Color? color;
  final bool isMargin;

  ContainerBase({Key? key, required this.child, this.height, this.width, this.color, this.isMargin = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color ?? colorWhite, borderRadius: BorderRadius.all(Radius.circular(8.rs))),
      height: height ?? 48.hs,
      width: width ?? double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMargin ? 16.ws : 0),
      child: child,
    );
  }
}
