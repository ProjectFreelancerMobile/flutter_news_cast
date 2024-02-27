import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/base/base_page.dart';
import 'package:flutter_news_cast/ui/widgets/base_scaffold_widget.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';
import 'package:flutter_news_cast/ui/widgets/default_appbar.dart';

import '../../app/app_pages.dart';
import '../widgets/icon_text/icons_component.dart';
import 'payment_controller.dart';

//ignore: must_be_immutable
class PaymentWelcomePage extends BasePage<PaymentController> {
  @override
  Widget buildContentView(BuildContext context, PaymentController controller) {
    return ScaffoldBase(
      resizeToAvoidBottomInset: false,
      color: Color(0xFFf2f5f8),
      isPaddingHorizontal: false,
      appBar: DefaultAppbar(
        appBarStyle: AppBarStyle.BACK,
        title: 'Chuyển & nhận tiền',
        style: text16.bold.textColorMainDark,
        leadingColor: colorPrimary,
      ),
      body: Column(
        children: [
          buildWidgetTinhNang(),
          SizedBox(height: 12.ws),
          buildWidgetInfo(),
        ],
      ),
    );
  }

  buildWidgetTinhNang() => buildWidgetContainer(
        [
          TouchableOpacity(
            onPressed: () => Get.toNamed(AppRoutes.NAV_PAYMENT),
            child: buildColumnTextImageMenu(
              size: 50.ws,
              Assets.icons.home.icCkIcon1.svg(),
              'Chuyển tiền\ntrong\nVietinBank',
              maxline: 3,
            ),
          ),
          TouchableOpacity(
            onPressed: () => Get.toNamed(AppRoutes.NAV_PAYMENT),
            child: buildColumnTextImageMenu(
              size: 50.ws,
              Assets.icons.home.icCkIcon2.svg(),
              'Chuyển tiền\nliên\nngân hàng',
              maxline: 3,
            ),
          ),
          buildColumnTextImageMenu(
            size: 50.ws,
            Assets.icons.home.icCkIcon3.svg(),
            'Chuyển tiền\nchứng khoán\n',
            maxline: 3,
          ),
          buildColumnTextImageMenu(
            size: 50.ws,
            Assets.icons.home.icCkIcon4.svg(),
            'Gửi tiền\nmừng\n',
            maxline: 3,
          ),
        ],
        [
          buildColumnTextImageMenu(
            size: 50.ws,
            Assets.icons.home.icCkIcon5.svg(),
            'Bán ngoại tệ\n\n',
            maxline: 3,
          ),
          Stack(
            children: [
              Positioned(
                child: buildColumnTextImageMenu(
                  size: 50.ws,
                  Assets.icons.home.icCkIcon6.svg(),
                  'Mua/\Chuyển\nngoại tệ\n',
                  maxline: 3,
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Assets.icons.info.icInfoNew.svg(height: 12.ws),
              )
            ],
          ),
          TouchableOpacity(
            child: buildColumnTextImageMenu(
              size: 50.ws,
              Assets.icons.home.icCkIcon7.svg(),
              'Chuyển 24/7\n mã QR\n',
              maxline: 3,
            ),
            onPressed: () {
              controller.resetPayment();
              Get.toNamed(AppRoutes.QRCODE);
            },
          ),
          buildColumnTextImageMenu(
            size: 50.ws,
            Assets.icons.home.icCkIcon8.svg(),
            'Western\nunion\n',
            maxline: 3,
          ),
        ],
      );

  buildWidgetInfo() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 40.ws,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4.rs)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 0.5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icons.home.icCkIcon9.svg(height: 20.ws),
                      SizedBox(width: 6),
                      Text('Đặt lịch chuyển tiền', style: text14.semiBold.textColorPrimary),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12.ws),
              Expanded(
                child: Container(
                  height: 40.ws,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(4.rs)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 0.5),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icons.home.icCkIcon10.svg(height: 20.ws),
                      SizedBox(width: 6),
                      Text('Cài đặt hạn mức', style: text14.semiBold.textColorPrimary),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.ws, horizontal: 16.ws),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Người nhận gần đây', style: text16.bold.textColorMainDark),
                Text('Thêm mới', style: text12.semiBold.textColorPrimary),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 60.ws,
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.ws),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Danh bạ trống. Xin lưu số tài khoản/số thẻ của người\nnhận để giao dịch thuận tiện hơn.',
                style: text13.medium.textColorTextGreyLight,
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      );

  buildWidgetContainer(List<Widget> listTop, List<Widget> listBottom) => Container(
        width: double.infinity,
        height: 245.ws,
        padding: EdgeInsets.symmetric(horizontal: 16.ws),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.ws),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: listTop),
            SizedBox(height: 8.ws),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: listBottom),
          ],
        ),
      );
}
