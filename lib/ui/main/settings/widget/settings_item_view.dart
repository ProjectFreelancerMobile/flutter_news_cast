import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../../../widgets/button/touchable_opacity.dart';

class AccountItemView extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String? titleRight;
  final bool isIconNext;
  final bool isActionTitleRight;
  final bool isHighlightTitleRight;
  final VoidCallback onPressed;

  AccountItemView({
    this.icon,
    this.titleRight,
    this.isIconNext = true,
    required this.title,
    this.isActionTitleRight = false,
    this.isHighlightTitleRight = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      child: Container(
        height: 36.ws,
        padding: EdgeInsets.only(right: 10.ws, top: 8.ws, bottom: 8.ws),
        child: Row(
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 10.ws),
            ],
            Expanded(child: Text(title, style: text14.textColor141414, overflow: TextOverflow.ellipsis, maxLines: 1)),
            if (titleRight != null) ...[
              Text(titleRight ?? '', style: isActionTitleRight ? text14.textColorPrimary : (isHighlightTitleRight ? text14.textColorD3D3D4 : text14.textColor141414)),
              SizedBox(width: 10.ws),
            ],
            if (isIconNext) ...[
              Assets.icons.icSettingsNext.svg(width: 8.ws),
            ]
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
