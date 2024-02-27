import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/base/base_page.dart';
import 'package:flutter_news_cast/ui/main/home/home_controller.dart';
import 'package:flutter_news_cast/ui/main/widget/home_notify_item_view.dart';

import '../../../../utils/data_util.dart';
import '../../../../utils/date_time_utils.dart';
import '../../../widgets/dividercustom.dart';
import '../../widget/button_text_widget.dart';
import '../../widget/home_noti_empty_view.dart';

class HistoryTab extends BasePage<HomeController> {
  @override
  Widget buildContentView(BuildContext context, HomeController controller) {
    return Column(
      children: [
        Container(color: colorHomeBgGrey, height: 16.ws),
        buildWidgetHistory(),
      ],
    );
  }

  buildWidgetHistory() => Expanded(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.ws, horizontal: 8.ws),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Giao dịch gần đây', style: text16.semiBold.textColorBlack),
              SizedBox(height: 10.ws),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ButtonTextSimpleWidget(title: '2 tuần', isClick: true),
                  ButtonTextSimpleWidget(title: '1 tháng'),
                  ButtonTextSimpleWidget(title: '2 tháng'),
                  ButtonTextSimpleWidget(title: 'Tìm kiếm', isIcon: true),
                ],
              ),
              DividerCustom(),
              SizedBox(height: 10.ws),
              Expanded(
                child: controller.listNotification.length == 0
                    ? Center(child: HomeNotifyEmptyView())
                    : ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        separatorBuilder: (context, index) {
                          return DividerCustom();
                        },
                        itemBuilder: (context, index) {
                          final item = controller.listNotification[controller.listNotification.length - index - 1].toString();
                          print('listNotification::' + item.toString());
                          final isAddMoney = getDataType(item);
                          final money = getDataMoney(item);
                          final note = getDataNote(item);
                          final date = getDataDate(item);
                          final datetime = readTimeDayAndHour(int.tryParse(date));
                          var totalMoney = formatCurrencyRaw(int.tryParse(getDataSoDu(item)) ?? 0);
                          if (totalMoney == '0') {
                            totalMoney = controller.user.getTotalMoney;
                          }
                          print('totalMoney::' + totalMoney.toString());
                          return HomeNotifyView(
                              isAddMoney: isAddMoney,
                              totalMoney: totalMoney,
                              money: money,
                              note: note,
                              dateTimeTitle: datetime,
                              onPressed: () => {} //openNotificationDetail(controller.user, item, isAddMoney, userName, money, note, datetime),
                              );
                        },
                        itemCount: controller.listNotification.length,
                      ),
              ),
            ],
          ),
        ),
      );
}
