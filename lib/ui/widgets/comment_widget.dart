import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../res/images.dart';
import '../../res/theme/text_theme.dart';
import '../../res/theme/theme_service.dart';
import '../../ui/widgets/button/touchable_opacity.dart';

class CommentWidget extends GetWidget {
  final RxInt totalComment;
  final double iconSize;
  final VoidCallback? onComment;

  CommentWidget({required this.totalComment, this.iconSize = 32, this.onComment});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TouchableOpacity(
        child: Row(
          children: [
            Image.asset(
              DImages.iconComment,
              width: iconSize,
              height: iconSize,
              color: getColor().themeColorB2B2B2,
            ),
            Obx(() => Text("${totalComment.value} bình luận", style: text14.textColor777777, textAlign: TextAlign.left))
          ],
        ),
        onPressed: () {
          if (onComment != null) onComment!();
        },
      ),
    );
  }
}
