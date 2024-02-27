import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/widgets/dividercustom.dart';
import 'package:flutter_news_cast/utils/data_util.dart';

import '../../widgets/button/touchable_opacity.dart';

class HomeNotifyTKView extends StatelessWidget {
  final bool isAddMoney;
  final String userName;
  final String soTK;
  final String totalMoney;
  final String money;
  final String note;
  final String date;
  final VoidCallback onPressed;

  HomeNotifyTKView(
      {required this.isAddMoney,
      required this.userName,
      required this.soTK,
      required this.money,
      required this.totalMoney,
      required this.note,
      required this.date,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      child: Container(
        width: double.infinity,
        height: 165.ws,
        padding: EdgeInsets.symmetric(horizontal: 10.ws, vertical: 8.ws),
        margin: EdgeInsets.only(top: 16.ws, left: 16.ws, right: 16.ws),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6.rs)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Assets.icons.logo.icNotifLogo.svg(width: 30.ws),
                    SizedBox(width: 6),
                    Text(date, style: text12.textNoti.textColorMainDarkBlack),
                  ],
                ),
                Assets.icons.notification.icNotiMenu.svg(height: 18.ws),
              ],
            ),
            DividerCustom(),
            Text('Thời gian: $date', style: text14.textNoti.textColorMainDarkBlack),
            Text('Tài khoản: $soTK', style: text14.textNoti.textColorMainDarkBlack),
            Row(
              children: [
                Text('Giao dịch: ', style: text14.textNoti.textColorMainDarkBlack),
                Text(
                  (isAddMoney ? '+' : '-') + formatCurrencyRaw(int.tryParse(money) ?? 0),
                  style: text14.bold.textColorMainDarkBlack.copyWith(color: isAddMoney ? colorAddMoney : colorSubMoney),
                ),
              ],
            ),
            Row(
              children: [
                Text('Số dư hiện tại: ', style: text14.textNoti.textColorMainDarkBlack),
                Text(
                  totalMoney,
                  style: text14.bold.textColorMainDarkBlack,
                ),
              ],
            ),
            Text(
              'Nội dung: $note',
              style: text14.textNoti.textColorMainDarkBlack,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
