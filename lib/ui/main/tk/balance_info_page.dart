import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_news_cast/app/app_pages.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/base/base_page.dart';
import 'package:flutter_news_cast/ui/main/home/home_controller.dart';
import 'package:flutter_news_cast/ui/widgets/base_scaffold_widget.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';
import 'package:flutter_news_cast/ui/widgets/default_appbar.dart';

import '../../widgets/animation/ExpandedSection.dart';

//ignore: must_be_immutable
class BalanceInfoPage extends BasePage<HomeController> {
  @override
  Widget buildContentView(BuildContext context, HomeController controller) {
    return ScaffoldBase(
      resizeToAvoidBottomInset: false,
      imageBackground: controller.themeMain(),
      appBar: DefaultAppbar(
        appBarStyle: AppBarStyle.BACK,
        title: 'Tài khoản',
      ),
      body: Column(
        children: [
          controller.showInfoFull.value
              ? ExpandedSection(
                  expand: controller.showInfoFull.value,
                  child: buildWidgetInfoBalance(),
                )
              : TouchableOpacity(
                  child: buildWidgetInfo('Tài khoản thanh toán (1)'),
                  onPressed: () {
                    controller.onChangeVisibleInfo();
                  },
                ),
          SizedBox(height: 14.ws),
          buildWidgetInfo('Tài khoản vay'),
          SizedBox(height: 14.ws),
          buildWidgetInfo('Tài khoản thẻ tín dụng'),
          SizedBox(height: 14.ws),
          buildWidgetInfo('Trái phiếu VietinBank'),
        ],
      ),
    );
  }

  buildWidgetInfoBalance() => Container(
        width: double.infinity,
        height: 360.ws,
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
                    children: [
                      Text('Tài khoản thanh toán(1)', style: text14.bold.textColorMainDark),
                      TouchableOpacity(
                        child: Assets.icons.info.icArrowDown.svg(width: 12.ws),
                        onPressed: () {
                          controller.onChangeVisibleInfo();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 60.ws,
                    child: Row(
                      children: [
                        Text(controller.showInfoMoney.value ? '${controller.user.getTotalMoney} VND' : '••••••••', style: text20.bold.textColorPrimary),
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
                  Divider(),
                  SizedBox(height: 10.ws),
                  TouchableOpacity(
                    onPressed: () {
                      Get.toNamed(AppRoutes.NAV_BANK_INFO);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.user.soTaiKhoan, style: text16.semiBold.textColorPrimary),
                            Text(controller.user.displayName ?? '', style: text16.medium.textColorBlack),
                            Text('Số dư khả dụng:${controller.showInfoMoney.value ? '${controller.user.getTotalMoney} VND' : '••••••••'}', style: text14.medium.textColorTextGrey),
                          ],
                        ),
                        Assets.icons.info.icArrowRight.svg(width: 12.ws, height: 12.ws),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.ws),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFFf2f5f8),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.rs), bottomRight: Radius.circular(8.rs)),
                ),
                padding: EdgeInsets.all(16.ws),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    buildWidgetPayment(Assets.icons.info.icInfoVi2.svg(), 'Mở tài khoản số đẹp'),
                    SizedBox(height: 10.ws),
                    buildWidgetPayment(Assets.icons.info.icInfoVi.svg(), 'Đặt & quản lý Alias'),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  buildWidgetPayment(Widget icon, String title) => Container(
        width: double.infinity,
        height: 50.ws,
        padding: EdgeInsets.all(16.ws),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.rs)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [icon, Text(title, style: text14.bold.textColorBlue)],
        ),
      );

  buildWidgetInfo(String title) => Container(
        width: double.infinity,
        height: 50.ws,
        padding: EdgeInsets.all(16.ws),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.rs)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Text(title, style: text14.bold.textColorMainDark)),
            Assets.icons.info.icArrowDown.svg(width: 12.ws),
          ],
        ),
      );
}
