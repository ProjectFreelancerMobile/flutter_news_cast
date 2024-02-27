import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/utils/data_util.dart';

import '../../widgets/button/touchable_opacity.dart';

class HomeNotifyView extends StatelessWidget {
  final bool isAddMoney;
  final String money;
  final String totalMoney;
  final String note;
  final String dateTimeTitle;
  final VoidCallback onPressed;

  HomeNotifyView({required this.isAddMoney, required this.totalMoney, required this.money, required this.note, required this.dateTimeTitle, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      child: Container(
        width: double.infinity,
        height: 76.ws,
        padding: EdgeInsets.symmetric(horizontal: 10.ws, vertical: 8.ws),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dateTimeTitle, style: text13.textNoti.textColorBlack),
                Text('Số tiền', style: text14.textNoti.textColorTextGreyLight),
                Text('Số dư', style: text14.textNoti.textColorTextGreyLight)
              ],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    note,
                    style: text13.textNoti.textColorTextGreyLight,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    (isAddMoney ? '+' : '-') +
                        formatCurrencyRaw(
                          int.tryParse(money) ?? 0,
                        ) +
                        ' VND',
                    style: text13.semiBold.textColorBlack.copyWith(color: isAddMoney ? colorAddMoney : colorSubMoney),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '$totalMoney VND',
                    style: text13.semiBold.textColorTextGreyLight,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
