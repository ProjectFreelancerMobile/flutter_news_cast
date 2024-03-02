import 'package:flutter/widgets.dart';
import 'package:flutter_news_cast/res/style.dart';

class EmptyItemView extends StatelessWidget {
  final double padding;

  EmptyItemView({required this.padding});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.ws, horizontal: padding),
            child: Assets.icons.icLine.svg(),
          ),
          alignment: Alignment.centerRight,
        ),
        Text(
          textLocalization('service.empty'),
          style: text14.textColor141414,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
