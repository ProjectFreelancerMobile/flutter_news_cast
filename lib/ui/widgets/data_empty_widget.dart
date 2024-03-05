import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../../../res/theme/theme_service.dart';

class DataEmptyWidget extends StatelessWidget {
  final Color? background;

  DataEmptyWidget({this.background});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: background ?? getColor().bgThemeColorWhite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.imgIcEmpty.image(),
          SizedBox(
            height: 10,
          ),
          Text(
            textLocalization('data.empty'),
            style: text16.textColor141414,
          )
        ],
      ),
    );
  }
}
