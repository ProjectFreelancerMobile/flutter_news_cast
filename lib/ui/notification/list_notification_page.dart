import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_news_cast/app/app_pages.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/base/base_page.dart';
import 'package:flutter_news_cast/ui/widgets/base_scaffold_widget.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';

import '../../ui/notification/list_notification_controller.dart';
import '../../utils/data_util.dart';
import '../../utils/date_time_utils.dart';
import '../main/widget/home_noti_empty_view.dart';
import '../main/widget/home_notify_tk_item_view.dart';
import '../widgets/tabcustom/flutter_toggle_tab.dart';

//ignore: must_be_immutable
class ListNotificationPage extends BasePage<ListNotificationController> {
  var inputFormat = DateFormat('dd-MM-yyyy HH:mm:ss');
  var datetimeFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget buildContentView(BuildContext context, ListNotificationController controller) {
    controller.getListNotification();
    return ScaffoldBase(
      isPadding: false,
      imageBackground: controller.themeMain(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 46.ws, left: 16.ws, right: 16.ws),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TouchableOpacity(
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: colorPrimary,
                        size: 24.ws,
                      ),
                      onPressed: () => Get.offAllNamed(AppRoutes.MAIN),
                    ),
                    Text('Thông báo', style: text20.semiBold.textColorMainDark),
                    SizedBox(width: 16.ws),
                    /*Container(
                      width: 30.ws,
                      height: 30.ws,
                      decoration: BoxDecoration(
                        color: Colors.red.shade600,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text('3', style: text14.textColorWhite),
                      ),
                    ),*/
                    Row(
                      children: [
                        Assets.icons.notification.icNotiSetting.svg(width: 40.ws),
                        SizedBox(width: 12.ws),
                        Assets.icons.notification.icNotiSearch.svg(width: 40.ws),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.ws),
                FlutterToggleTab(
                  width: 128.ws,
                  borderRadius: 8,
                  height: 44.ws,
                  isShadowEnable: true,
                  selectedIndex: controller.pageIndex.value,
                  selectedBackgroundColors: [Color(0xFF2183db)],
                  unSelectedBackgroundColors: [Colors.white],
                  selectedTextStyle: text13.bold.textColorWhite,
                  unSelectedTextStyle: text13.semiBold.textColorTextGrey,
                  labels: controller.menu,
                  selectedLabelIndex: (index) {
                    controller.onTabChanged(index);
                  },
                  isScroll: true,
                ),
                SizedBox(height: 10.ws),
              ],
            ),
          ),
          Expanded(
            child: controller.listNotification.length == 0
                ? Center(child: HomeNotifyEmptyView())
                : ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      final item = controller.listNotification[controller.listNotification.length - index - 1].toString();
                      final isAddMoney = getDataType(item);
                      final userName = getDataUserName(item);
                      final money = getDataMoney(item);
                      final note = getDataNote(item);
                      final date = getDataDate(item);
                      final datetime = readTimeDayAndHourNoti(int.tryParse(date));
                      final stk = controller.user.soTaiKhoan;
                      var totalMoney = formatCurrencyRaw(int.tryParse(getDataSoDu(item)) ?? 0);
                      if (totalMoney == '0') {
                        totalMoney = controller.user.getTotalMoney;
                      }
                      print('listNotification::' + item.toString());
                      return HomeNotifyTKView(
                          isAddMoney: isAddMoney,
                          userName: userName,
                          soTK: stk,
                          totalMoney: totalMoney,
                          money: money,
                          note: note,
                          date: datetime,
                          onPressed: () => {} //openNotificationDetail(controller.user, item, isAddMoney, userName, money, note, datetime),
                          );
                    },
                    itemCount: controller.listNotification.length,
                  ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
