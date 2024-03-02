import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../res/images.dart';
import '../../res/theme/text_theme.dart';
import '../../res/theme/theme_service.dart';
import '../../ui/widgets/button/touchable_opacity.dart';

class LikeWidget extends GetWidget {
  final RxBool isLike;
  final RxInt totalLike;
  final double iconSize;
  final VoidCallback? onFavorite;

  LikeWidget({required this.isLike, required this.totalLike, this.iconSize = 32, this.onFavorite});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          TouchableOpacity(
            child: Obx(
              () => Image.asset(
                DImages.iconLike,
                width: iconSize,
                height: iconSize,
                color: isLike.value ? getColor().themeColorPrimary : getColor().themeColorB2B2B2,
              ),
            ),
            onPressed: () {
              if (onFavorite != null) onFavorite!();
            },
          ),
          Obx(
            () => Text("${totalLike.value} lượt thích", style: text14.textColor777777, textAlign: TextAlign.left),
          )
        ],
      ),
    );
  }
}
