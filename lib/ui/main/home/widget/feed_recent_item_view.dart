import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';

class FeedRecentItemView extends StatelessWidget {
  final String url;
  final String content;
  final VoidCallback? onPressed;

  FeedRecentItemView({required this.url, required this.content, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onPressed: onPressed,
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
    );
  }
}
