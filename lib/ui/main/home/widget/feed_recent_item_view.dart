import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

class FeedRecentItemView extends StatelessWidget {
  final String url;
  final String content;
  final VoidCallback? onPressed;
  final VoidCallback? onPressedRemove;

  FeedRecentItemView({
    required this.url,
    required this.content,
    required this.onPressed,
    required this.onPressedRemove,
  });

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onPressed: onPressed,
      child: SwipeActionCell(
        key: ObjectKey(url),
        trailingActions: <SwipeAction>[
          SwipeAction(
            title: textLocalization('home.delete'),
            style: text12.textColorWhite,
            widthSpace: 60.ws,
            onTap: (CompletionHandler handler) async {
              if (onPressedRemove != null) {
                onPressedRemove!();
              }
            },
            color: Colors.red,
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.only(top: 12, right: 12),
          child: Row(
            children: [
              Assets.icons.icGoogle.image(),
              SizedBox(width: 16.ws),
              Expanded(
                child: Text(
                  content,
                  style: text14.textColor141414,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
