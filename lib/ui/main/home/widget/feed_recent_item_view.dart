import 'package:flutter/material.dart';
import 'package:flutter_news_cast/data/storage/key_constant.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

class FeedRecentItemView extends StatelessWidget {
  final int type;
  final String url;
  final String content;
  final bool isBookmark;
  final VoidCallback? onPressed;
  final VoidCallback? onPressedRemove;

  FeedRecentItemView({
    required this.isBookmark,
    required this.type,
    required this.url,
    required this.content,
    required this.onPressed,
    required this.onPressedRemove,
  });

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onPressed: onPressed,
      child: isBookmark
          ? buildItem()
          : SwipeActionCell(
              key: ObjectKey(url),
              trailingActions: <SwipeAction>[
                SwipeAction(
                  title: textLocalization('home.delete'),
                  style: text14.textColorWhite,
                  widthSpace: 60.ws,
                  onTap: (CompletionHandler handler) async {
                    if (onPressedRemove != null) {
                      onPressedRemove!();
                    }
                  },
                  color: Colors.red,
                ),
              ],
              child: buildItem(),
            ),
    );
  }

  Widget buildItem() => Padding(
        padding: const EdgeInsets.only(top: 12, right: 12),
        child: Row(
          children: [
            SizedBox(
              height: 20.ws,
              width: 20.ws,
              child: buildIcon(type.typeTitle),
            ),
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
      );

  Widget buildIcon(RSS_TITLE type) {
    switch (type) {
      case RSS_TITLE.THANHNIEN:
        return Assets.icons.icThanhnien.image();
      case RSS_TITLE.YOUTUBE:
        return Assets.icons.icYoutube.image();
      case RSS_TITLE.VIMEO:
        return Assets.icons.icVimeo.image();
      case RSS_TITLE.DAILYMOTION:
        return Assets.icons.icDailymotion.image();
      case RSS_TITLE.THEXIFFY:
        return Assets.icons.icThexiffy.image();
      default:
        return Assets.icons.icGoogle.image();
    }
  }
}
