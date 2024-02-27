import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../../widgets/button/touchable_opacity.dart';

class NotificationItemView extends StatefulWidget {
  final String title;
  final VoidCallback onPressed;
  final Function(bool) onSwitch;

  NotificationItemView({required this.title, required this.onPressed, required this.onSwitch});

  @override
  State<NotificationItemView> createState() => _NotificationItemViewState();
}

class _NotificationItemViewState extends State<NotificationItemView> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      child: Container(
        height: 48.ws,
        padding: EdgeInsets.symmetric(horizontal: 10.ws, vertical: 8.ws),
        child: Row(
          children: [
            Text(widget.title, style: text14.textColorBlack),
            Spacer(),
            Switch(
              value: isSwitched,
              onChanged: (value) {
                setState(() {
                  widget.onSwitch(value);
                  isSwitched = value;
                });
              },
              inactiveTrackColor: colorBgGrey,
              inactiveThumbColor: colorWhite,
              activeTrackColor: colorPrimary,
              activeColor: colorWhite,
            )
          ],
        ),
      ),
      onPressed: widget.onPressed,
    );
  }
}
