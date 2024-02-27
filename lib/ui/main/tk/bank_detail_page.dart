import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/base/base_page.dart';
import 'package:flutter_news_cast/ui/main/home/home_controller.dart';
import 'package:flutter_news_cast/ui/main/tk/tab/function_tab.dart';
import 'package:flutter_news_cast/ui/widgets/base_scaffold_widget.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';
import 'package:flutter_news_cast/ui/widgets/default_appbar.dart';

import 'tab/history_tab.dart';

class BankDetailPage extends BasePage<HomeController> {
  @override
  Widget buildContentView(BuildContext context, HomeController controller) {
    controller.getListNotification();
    return ScaffoldBase(
      resizeToAvoidBottomInset: false,
      isPaddingHorizontal: false,
      imageBackground: controller.themeMain(),
      appBar: DefaultAppbar(
        appBarStyle: AppBarStyle.BACK,
        title: 'TK Thanh toán',
        actions: [
          Row(
            children: [
              Assets.icons.info.icInfoViWhite.svg(width: 26.ws),
              Icon(Icons.keyboard_arrow_down, color: Colors.white),
            ],
          ),
        ],
      ),
      body: DefaultTabController(
        initialIndex: 0,
        length: 3,
        child: Column(
          children: [
            buildWidgetInfoBalance(),
            Expanded(
              child: Container(
                color: colorBackground,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      height: 50.ws,
                      child: TabBar(
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        indicatorColor: Colors.red.shade800,
                        labelStyle: text16.semiBold.textColorMainDark,
                        unselectedLabelStyle: text16.semiBold.textColorTextGrey,
                        tabs: [
                          Tab(text: 'Chức năng'),
                          Tab(text: 'Lịch sử giao dịch'),
                          Tab(text: 'Thông tin'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          FunctionTab(),
                          HistoryTab(),
                          SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildWidgetInfoBalance() => Container(
    width: double.infinity,
        height: 220.ws,
        margin: EdgeInsets.only(bottom: 32.ws, left: 16.ws, right: 16.ws),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.rs)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.ws),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controller.user.soTaiKhoan, style: text16.semiBold.textColorPrimary),
                          SizedBox(height: 12.ws),
                          Text(controller.user.displayName ?? '', style: text16.medium.textColorBlack),
                        ],
                      ),
                      Row(
                        children: [
                          Assets.icons.info.icInfoCopy.svg(width: 22.ws),
                          SizedBox(width: 16.ws),
                          Assets.icons.info.icInfoQrcode.svg(width: 22.ws),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30.ws),
                  Text('Số dư khả dụng', style: text15.medium.textColorTextGrey),
                  SizedBox(
                    height: 50.ws,
                    child: Row(
                      children: [
                        Text(controller.showInfoMoney.value ? '${controller.user.getTotalMoney} VND' : '••••••••  VND', style: text20.bold.textColorPrimary),
                        SizedBox(width: 8.ws),
                        TouchableOpacity(
                          onPressed: () {
                            controller.onChangeVisibleInfoMoney();
                          },
                          child: controller.showInfoMoney.value ? Assets.icons.info.icInfoEyes.svg(width: 18.ws) : Assets.icons.info.icInfoEyesOpen.svg(width: 18.ws),
                        ),
                      ],
                    ),
                  ),
                  Text('Số dư tài khoản: ${controller.showInfoMoney.value ? '${controller.user.getTotalMoney} VND' : '••••••••  VND'}', style: text15.medium.textColorTextGrey),
                ],
              ),
            ),
          ],
        ),
      );
}
