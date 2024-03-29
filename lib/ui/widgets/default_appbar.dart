// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';
import 'package:get/get.dart';

import '../../res/style.dart';
import '../../res/theme/theme_service.dart';
import 'button/text_button_widget.dart';

enum AppBarStyle { NONE, BACK, CLOSE }

class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;
  final String? title;
  final TextStyle? style;
  final String? leading;
  final Color? leadingColor;
  final List<Widget>? actions;
  final bool? isLeft;
  final double? height;
  AppBarStyle? appBarStyle = AppBarStyle.NONE;

  final VoidCallback? onPress;
  final PreferredSizeWidget? tabBar;

  DefaultAppbar({
    this.leading,
    this.title,
    this.style,
    this.color,
    this.actions,
    this.height,
    this.leadingColor,
    this.onPress,
    this.tabBar,
    this.appBarStyle = AppBarStyle.NONE,
    this.isLeft = false,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: isLeft == true
          ? TouchableOpacity(
              child: buildTitle(),
              onPressed: () => Get.back(),
            )
          : buildTitle(),
    );
  }

  Widget buildTitle() {
    return Padding(
      padding: EdgeInsets.only(left: 16.ws, top: 10.ws),
      child: AppBar(
        centerTitle: isLeft == true ? false : true,
        automaticallyImplyLeading: false,
        actions: actions,
        leading: buildWidgetLeading(appBarStyle, leading),
        title: isLeft == true
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.ws),
                child: Text(
                  title ?? "",
                  style: style ?? text18.medium.textColor141414,
                ),
              )
            : Text(
                title ?? "",
                style: style ?? text18.medium.textColor141414,
              ),
        leadingWidth: 7.ws,
        backgroundColor: color ?? Colors.transparent,
        elevation: 0,
        bottom: tabBar,
      ),
    );
  }

  Widget buildWidgetLeading(AppBarStyle? appBarStyle, String? leading) {
    switch (appBarStyle) {
      case AppBarStyle.NONE:
        return SizedBox();
      case AppBarStyle.BACK:
        return buildClose(isClose: false, leading: leading);
      case AppBarStyle.CLOSE:
        return buildClose(isClose: true, leading: leading);
      default:
        return SizedBox();
    }
  }

  Widget buildClose({bool? isClose, String? leading}) => leading != null
      ? IconButton(
          icon: Image.asset(
            leading,
            fit: BoxFit.cover,
            color: leadingColor,
            width: 36.ws,
            height: 36.ws,
            filterQuality: FilterQuality.high,
          ),
          onPressed: () {
            onPress != null ? onPress!() : Get.back();
          },
        )
      : ButtonIconTextWidget(
          icon: Assets.icons.icBack.svg(color: getColor().themeColor141414),
          onPressed: () {
            onPress != null ? onPress!() : Get.back();
          },
        );

  @override
  Size get preferredSize => Size.fromHeight((height ?? 58).ws);
}
