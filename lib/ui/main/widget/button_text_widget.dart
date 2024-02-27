import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../../widgets/dividercustom.dart';

class ButtonTextSimpleWidget extends StatelessWidget {
  ButtonTextSimpleWidget({required this.title, this.isClick = false, this.isIcon = false});

  final String title;
  final bool isClick;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 30.ws,
          decoration: BoxDecoration(
            color: isClick ? colorBackground : colorHomeBgGrey,
            borderRadius: BorderRadius.all(Radius.circular(4.rs)),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.ws),
              child: isIcon
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Assets.icons.info.icInfoSearch.svg(width: 12.ws, height: 12.ws),
                        SizedBox(width: 8.ws),
                        Text(title, style: isClick ? text13.semiBold.textColorPrimary : text13.semiBold.textColorTextGreyLight),
                      ],
                    )
                  : Text(title, style: isClick ? text13.semiBold.textColorPrimary : text13.semiBold.textColorTextGreyLight),
            ),
          ),
        ),
        DividerCustom(),
      ],
    );
  }
}
