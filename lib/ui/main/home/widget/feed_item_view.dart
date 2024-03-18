import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';

import '../../../widgets/image_widget.dart';

class FeedItemView extends StatelessWidget {
  final String url;
  final String content;
  final VoidCallback? onPressed;

  FeedItemView({required this.url, required this.content, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onPressed: onPressed,
      child: Container(
        width: 180.ws,
        height: 120.ws,
        margin: EdgeInsets.only(right: 10.ws),
        child: Column(
          children: [
            RoundNetworkImage(
              url: url,
              width: 180.ws,
              height: 100.ws,
            ),
            SizedBox(height: 6.ws),
            Text(
              content,
              style: text16.textColor141414,
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
