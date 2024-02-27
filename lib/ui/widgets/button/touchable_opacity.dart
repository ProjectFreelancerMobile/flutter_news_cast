import 'package:flutter/material.dart';

class TouchableOpacity extends StatelessWidget {
  final Widget child;
  final Function()? onPressed;

  TouchableOpacity({
    Key? key,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: child,
    );
  }
}
