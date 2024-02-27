import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

class ScaffoldBase extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final ImageProvider<Object>? imageBackground;
  final bool? resizeToAvoidBottomInset;
  final bool? isPadding;
  final bool? isPaddingHorizontal;
  final Color? color;

  ScaffoldBase({
    Key? key,
    required this.body,
    this.appBar,
    this.color,
    this.resizeToAvoidBottomInset = true,
    this.isPadding = true,
    this.isPaddingHorizontal = true,
    this.bottomNavigationBar,
    this.imageBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      bottomNavigationBar: bottomNavigationBar,
      body: imageBackground != null
          ? Container(
              padding: isPadding == true
                  ? EdgeInsets.only(
                      top: 120.ws,
                      left: isPaddingHorizontal == true ? 16.ws : 0,
                      right: isPaddingHorizontal == true ? 16.ws : 0,
                    )
                  : EdgeInsets.zero,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageBackground!,
                  fit: BoxFit.fill,
                ),
              ),
              child: body,
            )
          : Container(
              color: color,
              padding: isPadding == true
                  ? EdgeInsets.only(
                      top: 120.ws,
                      left: isPaddingHorizontal == true ? 16.ws : 0,
                      right: isPaddingHorizontal == true ? 16.ws : 0,
                    )
                  : EdgeInsets.zero,
              child: body,
            ),
    );
  }
}
