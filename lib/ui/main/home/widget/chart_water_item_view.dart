import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_news_cast/res/style.dart';

class WaterItemView extends StatelessWidget {
  final num waterValue;

  WaterItemView({required this.waterValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.ws,
      height: 200.hs,
      padding: EdgeInsets.symmetric(horizontal: 10.ws, vertical: 8.ws),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  width: 60.ws,
                  height: waterValue.abs() * 9.hs,
                  decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8.rs), topRight: Radius.circular(8.rs)),
                  ),
                ),
                Flexible(
                  child: Container(
                    width: 60.ws,
                    height: double.infinity,
                    color: color02F800,
                  ),
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('5', style: text14.textColor141414),
              Text('0', style: text14.textColor141414),
              Text('-5', style: text14.textColor141414),
              Text('-10', style: text14.textColor141414),
              Text('-15', style: text14.textColor141414),
              Text('-20', style: text14.textColor141414),
            ],
          ),
        ],
      ),
    );
  }
}
