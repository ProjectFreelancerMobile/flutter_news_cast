import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../../data/api/models/TUser.dart';
import '../../res/theme/theme_service.dart';
import '../../utils/date_time_utils.dart';
import 'image_widget.dart';

class UserRoleWidget extends StatelessWidget {
  final TUser user;
  final double? avatarSize;
  final String createDate;

  UserRoleWidget({required this.user, this.avatarSize = 56, required this.createDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            width: avatarSize,
            height: avatarSize,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(28.ws)),
                border: Border.all(
                  color: getColor().themeColorPrimary,
                  width: 1,
                )),
            child: AvatarNetworkImage(
              width: (avatarSize! - 6),
              height: (avatarSize! - 6),
              radius: (avatarSize! - 6) / 2,
              url: user.name ?? "",
              userName: user.name,
              textStyle: text18.bold.textColorWhite,
            ),
          ),
          SizedBox(
            width: 10.ws,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name!, style: text14.medium.textColor141414),
              SizedBox(
                height: 2.ws,
              ),
              Text("${readTimeStampBySecond(createDate)} trước", style: text12.textColorB2B2B2)
            ],
          )
        ],
      ),
    );
  }
}
