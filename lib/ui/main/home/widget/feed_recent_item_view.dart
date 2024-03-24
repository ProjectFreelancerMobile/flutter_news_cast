import 'package:flutter/material.dart';
import 'package:flutter_news_cast/data/storage/key_constant.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';
import 'package:flutter_news_cast/ui/widgets/image_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';

class BookmarkItemView extends StatelessWidget {
  final int type;
  final String urlIcon;
  final String content;
  final bool isRemove;
  final VoidCallback? onPressed;
  final VoidCallback? onPressedRemove;

  BookmarkItemView({
    this.isRemove = true,
    required this.type,
    required this.urlIcon,
    required this.content,
    required this.onPressed,
    required this.onPressedRemove,
  });

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onPressed: onPressed,
      child: isRemove
          ? SwipeActionCell(
              key: ObjectKey(urlIcon),
              trailingActions: <SwipeAction>[
                SwipeAction(
                  title: textLocalization('home.delete'),
                  style: text16.textColorWhite,
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
            )
          : buildItem(),
    );
  }

  Widget buildItem() => Padding(
        padding: const EdgeInsets.only(top: 12, right: 12),
        child: Row(
          children: [
            SizedBox(
              height: 20.ws,
              width: 20.ws,
              child: buildIcon(type.typeTitle, pathImg: urlIcon),
            ),
            SizedBox(width: 16.ws),
            Expanded(
              child: Text(
                content,
                style: text16.textColor141414,
                textAlign: TextAlign.start,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );

  Widget buildIcon(RSS_TITLE type, {String? pathImg}) {
    //print('pathImg:::' + pathImg.toString());
    if (pathImg != null && pathImg.contains('assets')) {
      return SvgPicture.asset(pathImg);
    } else if (pathImg?.contains('http') == true) {
      return CircleNetworkImage(
        url: pathImg,
        size: 24.ws,
      );
    }
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
