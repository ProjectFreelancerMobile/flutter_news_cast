import 'package:custom_clippers/custom_clippers.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/base/base_page.dart';
import 'package:flutter_news_cast/ui/widgets/base_scaffold_widget.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';

import '../../app/app_pages.dart';
import '../../data/api/api_constants.dart';
import '../../utils/data_util.dart';
import '../../utils/local_notification_manager.dart';
import '../widgets/MultipleRoundedPointsClipper.dart';
import 'payment_controller.dart';

//ignore: must_be_immutable
class PaymentSuccessPage extends BasePage<PaymentController> {
  @override
  Widget buildContentView(BuildContext context, PaymentController controller) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showNotification(controller.user.bienDong.lastOrNull ?? '', controller.user);
    });
    double widthImage = Get.width - 32.ws;
    return ScaffoldBase(
      resizeToAvoidBottomInset: true,
      imageBackground: controller.themeMain(),
      isPadding: false,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 46.ws),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.ws),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TouchableOpacity(
                    child: Assets.icons.payment.icCkHome.svg(height: 22.ws),
                    onPressed: () => Get.offAllNamed(AppRoutes.MAIN),
                  ),
                  Text('Kết quả giao dịch', style: text16.bold.textColorWhite),
                  Assets.icons.payment.icCkCall.svg(height: 22.ws),
                ],
              ),
            ),
            SizedBox(height: 24.ws),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildDetailBill(widthImage),
                    buildWidgetButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildDetailBillOld() => ClipPath(
        clipper: MultipleRoundedPointsClipperCustom(Sides.vertical, heightOfPoint: 0, numberOfPoints: 1),
        child: Container(
          width: double.infinity,
          height: 555.ws,
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 32.ws),
          child: Column(
            children: [
              SizedBox(height: 30.ws),
              buildWidgetLogo(),
              DottedLine(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                lineLength: double.infinity,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: colorPrimary.withOpacity(0.4),
              ),
              SizedBox(height: 10.ws),
              buildWidgetInfo(),
              DottedLine(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                lineLength: double.infinity,
                lineThickness: 1.0,
                dashLength: 4.0,
                dashColor: colorPrimary.withOpacity(0.4),
              ),
              SizedBox(height: 20.ws),
              buildWidgetAction(),
            ],
          ),
        ),
      );

  buildDetailBill(double widthImage) => SizedBox(
        width: widthImage,
        height: widthImage * 1.9,
        child: Stack(
          children: [
            Assets.icons.payment.bgCk.svg(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.ws),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: widthImage / 2.5,
                    child: buildWidgetLogo(),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: widthImage * 0.9,
                    child: buildWidgetInfo(),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: widthImage / 1.8,
                    child: buildWidgetAction(),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  buildWidgetLogo() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24.ws),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Assets.icons.payment.icCkLogo.svg(height: 34.ws),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(DateFormat(DATE_TIME_FORMAT2).format(DateTime.now()), style: text12.textColorTextGrey),
                  Text(controller.paymentItem.numberBill, style: text13.textColorTextGrey),
                ],
              ),
            ],
          ),
          SizedBox(height: 14.ws),
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFe9ffe8),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(12.ws),
            child: Text(
              'Chuyển tiền liên ngân hàng thành công!',
              style: text12.bold.textColorTextGreyLight.copyWith(
                color: colorAddMoney,
              ),
            ),
          ),
        ],
      );

  buildWidgetInfo() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.ws),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Từ tài khoản', style: text15.medium.textColorTextGrey),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(controller.user.soTaiKhoan.replaceRange(0, 7, '********'), style: text14.medium.textColorBlack),
                  Text(controller.user.displayName ?? '', style: text14.medium.textColorBlack),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.ws),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Đến tài khoản', style: text15.medium.textColorTextGrey),
              Flexible(
                child: SizedBox(
                  width: 260.ws,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(controller.paymentItem.stk, style: text14.bold.textColorBlack),
                      Text(
                        controller.paymentItem.userNameFromSTK ?? controller.nameTKCKInfo,
                        style: text14.bold.textColorBlack,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.ws),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ngân hàng', style: text15.medium.textColorTextGrey),
              Flexible(
                child: SizedBox(
                  width: 260.ws,
                  child: Text(
                    controller.paymentItem.bankDetail?.name ?? '',
                    style: text14.medium.textColorBlack,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.ws),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Số tiền', style: text15.medium.textColorTextGrey),
              Flexible(
                child: SizedBox(
                  width: 260.ws,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(formatCurrency(controller.paymentItem.amount), style: text14.bold.textColorPrimary),
                      Text(
                        controller.paymentItem.money,
                        style: text14.bold.textColorPrimary,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.ws),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Phí', style: text15.medium.textColorTextGrey),
              Text('Miễn phí', style: text14.medium.textColorBlack),
            ],
          ),
          SizedBox(height: 12.ws),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nội dung', style: text15.medium.textColorTextGrey),
              Flexible(
                child: SizedBox(
                  width: 260.ws,
                  child: Text(
                    controller.paymentItem.note,
                    style: text14.medium.textColorBlack,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  buildWidgetAction() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Assets.icons.payment.icCkBgSuccess.svg(height: 140.ws),
          SizedBox(height: 20.ws),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Assets.icons.payment.icCkDownload.svg(height: 18.ws),
                  SizedBox(width: 6),
                  Text(
                    'Tải về',
                    style: text13.bold.textColorBlue,
                  ),
                ],
              ),
              Row(
                children: [
                  Assets.icons.payment.icCkShare.svg(height: 20.ws),
                  SizedBox(width: 6),
                  Text(
                    'Chia sẻ',
                    style: text13.bold.textColorBlue,
                  ),
                ],
              )
            ],
          ),
        ],
      );

  buildWidgetButton() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.ws, vertical: 60.ws),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 46.hs),
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              onPressed: () => Get.offNamedUntil(AppRoutes.PAYMENT_WELCOME, ModalRoute.withName(AppRoutes.MAIN)),
              child: Text('Lưu danh bạ', style: text14.bold.textColorPrimary),
            ),
            SizedBox(height: 16.ws),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 46.hs),
                backgroundColor: Colors.white,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              onPressed: () => Get.offNamedUntil(AppRoutes.PAYMENT_WELCOME, ModalRoute.withName(AppRoutes.MAIN)),
              child: Text('Giao dịch tiếp', style: text14.bold.textColorPrimary),
            ),
          ],
        ),
      );
}
