import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';

import '../../../widgets/dividercustom.dart';

class FunctionTab extends StatelessWidget {
  const FunctionTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8.rs), topRight: Radius.circular(8.rs)),
      ),
      margin: EdgeInsets.only(top: 16.ws, bottom: 32.ws, left: 8.ws, right: 8.ws),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8.ws),
            buildWidgetInfo(Assets.icons.info.icInfoMoney.svg(), 'Chuyển tiền trong VietinBank'),
            buildWidgetInfo(Assets.icons.info.icInfoMoney.svg(), 'Chuyển tiền liên ngân hàng'),
            buildWidgetInfo(Assets.icons.info.icInfoMoneyWorld.svg(), 'Chuyển tiền quốc tế', isNew: true),
            buildWidgetInfo(Assets.icons.info.icInfoVi.svg(), 'Đặt/quản lý Alias tài khoản'),
            buildWidgetInfo(Assets.icons.info.icInfoTietkiem.svg(), 'Gửi tiết kiệm thường'),
            buildWidgetInfo(Assets.icons.info.icInfoTietkiem.svg(), 'Gửi tiết kiệm rút gốc linh hoạt', isNew: true),
            buildWidgetInfo(Assets.icons.info.icInfoShip.svg(), 'Đổi gói tài khoản'),
            buildWidgetInfo(Assets.icons.info.icInfoLink.svg(), 'Liên kết ví tài khoản'),
            buildWidgetInfo(Assets.icons.info.icInfoDelete.svg(), 'Đóng tài khoản', isRemove: true),
          ],
        ),
      ),
    );
  }

  buildWidgetInfo(Widget icon, String title, {bool isNew = false, bool isRemove = false}) => Column(
        children: [
          Container(
            width: double.infinity,
            height: 45.ws,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.rs)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.ws),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(child: icon, height: 24.ws, width: 24.ws),
                  SizedBox(width: 8.ws),
                  Expanded(
                    child: isNew == true
                        ? Row(
                            children: [
                              Text(title, style: text15.semiBold.textColorPrimary),
                              SizedBox(width: 8.ws),
                              Assets.icons.info.icInfoNew.svg(width: 24.ws),
                            ],
                          )
                        : Text(title, style: isRemove == true ? text15.semiBold.textColorPrimary.copyWith(color: Color(0xFFc52f4c)) : text15.semiBold.textColorPrimary),
                  ),
                  Assets.icons.info.icArrowRight.svg(width: 12.ws, height: 12.ws),
                ],
              ),
            ),
          ),
          DividerCustom(),
        ],
      );
}
