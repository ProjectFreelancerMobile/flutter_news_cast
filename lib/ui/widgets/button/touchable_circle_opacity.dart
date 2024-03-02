import 'package:flutter/material.dart';

import '../../../res/theme/theme_service.dart';

class TouchableCircleOpacity extends StatelessWidget {
  final Widget icon;
  final double size;
  final Function()? onPressed;

  TouchableCircleOpacity({
    Key? key,
    required this.icon,
    required this.size,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: size,
      icon: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: getColor().themeColorB2B2B2.withOpacity(0.7), borderRadius: BorderRadius.all(Radius.circular(size / 2))),
        child: icon,
      ),
    );
  }
}
