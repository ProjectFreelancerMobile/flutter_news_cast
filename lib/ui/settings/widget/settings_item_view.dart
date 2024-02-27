import 'package:flutter/widgets.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../../widgets/button/touchable_opacity.dart';

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
    this.isIconNext = false,
    required this.title,
    this.isActionTitleRight = false,
    this.isHighlightTitleRight = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      child: Container(
        height: 46.ws,
        padding: EdgeInsets.only(right: 10.ws, top: 8.ws, bottom: 8.ws),
        child: Row(
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 10.ws),
            ],
            Expanded(child: Text(title, style: text14.textColorBlack, overflow: TextOverflow.ellipsis, maxLines: 1)),
            if (titleRight != null) ...[
              Text(titleRight ?? '', style: isActionTitleRight ? text14.textColorPrimary : (isHighlightTitleRight ? text14.textColorTextGrey : text14.textColorBlack)),
              SizedBox(width: 6.ws),
            ],
            if (isIconNext) ...[
              //Assets.icons.icSettingsNext.svg(width: 8.ws),
            ]
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
