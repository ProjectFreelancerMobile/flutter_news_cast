import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../../../res/theme/theme_service.dart';

class DataEmptyWidget extends StatelessWidget {
  final Color? background;
  final String? textEmpty;

  DataEmptyWidget({this.background, this.textEmpty});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: background ?? getColor().background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.imgIcEmpty.image(),
          SizedBox(
            height: 10,
          ),
          Text(
            textEmpty ?? textLocalization('data.empty'),
            style: text16.textColor141414,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
