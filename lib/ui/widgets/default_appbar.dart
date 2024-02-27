// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/style.dart';

enum AppBarStyle { NONE, BACK, CLOSE }

class DefaultAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Color? color;
  final String? title;
  final TextStyle? style;
  final String? leading;
  final Color? leadingColor;
  final bool? isIconBank;
  final bool? isIconBankCenter;
  final List<Widget>? actions;
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
    this.isIconBankCenter = true,
    this.isIconBank = false,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: actions,
        leading: isIconBank == true && isIconBankCenter == false ? iconBankCustom() : buildWidgetLeading(appBarStyle, leading),
        title: isIconBank == true
            ? iconBankCustom()
            : Text(
                title ?? "",
                style: style ?? text18.semiBold.textColorWhite,
              ),
        backgroundColor: color ?? Colors.transparent,
        elevation: 0,
        bottom: tabBar,
      ),
    );
  }

  Widget iconBankCustom() => Assets.icons.logo.icTextVietinIpay.svg(height: 18.ws);

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
      : IconButton(
          icon: Icon(
            isClose == true ? Icons.close : Icons.arrow_back_rounded,
            color: leadingColor ?? colorWhite,
            size: 24.ws,
          ),
          onPressed: () {
            onPress != null ? onPress!() : Get.back();
          },
        );

  @override
  Size get preferredSize => Size.fromHeight((height ?? 58).ws);
}
