import 'package:flutter/material.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/base/base_page.dart';
import 'package:flutter_news_cast/ui/payment/payment_controller.dart';
import 'package:flutter_news_cast/ui/payment/widget/button_next.dart';
import 'package:flutter_news_cast/ui/widgets/default_appbar.dart';
import 'package:flutter_news_cast/utils/toast_util.dart';

import '../../utils/data_util.dart';
import '../widgets/count_down_timer_widget.dart';

//ignore: must_be_immutable
class PaymentDetailPage extends BasePage<PaymentController> {
  @override
  Widget buildContentView(BuildContext context, PaymentController controller) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: DefaultAppbar(
        appBarStyle: AppBarStyle.BACK,
        title: 'Xác nhận giao dịch',
        style: text15.bold.textColorMainDark,
        leadingColor: colorPrimary,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  buildDetailDetail(),
                  SizedBox(height: 360.ws),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 340.ws,
                decoration: BoxDecoration(
                  color: Color(0xFFf2f5f8),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12.rs), topRight: Radius.circular(12.rs)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 0.5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: 10.ws),
                    Assets.icons.payment.icCkLine.svg(height: 6.ws),
                    SizedBox(height: 10.ws),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.ws, vertical: 16.ws),
                      child: Column(
                        children: [
                          buildWidgetOTP(context),
                          ButtonNext(
                            title: 'Xác nhận & hoàn tất',
                            onPress: () {
                              controller.navPaymentDetailsCK((error) {
                                showMessage(error);
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildDetailDetail() => Padding(
        padding: EdgeInsets.symmetric(vertical: 16.ws, horizontal: 16.ws),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Từ tài khoản', style: text15.textColorTextGrey),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(controller.user.soTaiKhoan.replaceRange(0, 7, '********'), style: text16.medium.textColorBlack),
                    Text(controller.user.displayName ?? '', style: text16.medium.textColorBlack),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.ws),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Đến tài khoản', style: text15.textColorTextGrey),
                Flexible(
                  child: SizedBox(
                    width: 260.ws,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(controller.paymentItem.stk, style: text16.bold.textColorBlack),
                        Text(
                          controller.paymentItem.userNameFromSTK ?? controller.nameTKCKInfo,
                          style: text16.bold.textColorBlack,
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
            SizedBox(height: 16.ws),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ngân hàng', style: text15.textColorTextGrey),
                Flexible(
                  child: SizedBox(
                    width: 260.ws,
                    child: Text(
                      controller.paymentItem.bankDetail?.name ?? '',
                      style: text16.medium.textColorBlack,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.ws),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Số tiền', style: text16.textColorTextGrey),
                Flexible(
                  child: SizedBox(
                    width: 260.ws,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(formatCurrency(controller.paymentItem.amount), style: text16.bold.textColorPrimary),
                        Text(
                          controller.paymentItem.money,
                          style: text16.bold.textColorPrimary,
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
            SizedBox(height: 16.ws),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Phí', style: text16.textColorTextGrey),
                Text('Miễn phí', style: text16.medium.textColorBlack),
              ],
            ),
            SizedBox(height: 16.ws),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nội dung', style: text16.textColorTextGrey),
                Flexible(
                  child: SizedBox(
                    width: 260.ws,
                    child: Text(
                      controller.paymentItem.note,
                      style: text16.medium.textColorBlack,
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.ws),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 160.ws,
                  child: Text(
                    'Phương thức xác thực',
                    style: text16.textColorTextGrey,
                    maxLines: 2,
                  ),
                ),
                Text('SOFT OTP', style: text16.medium.textColorBlack),
              ],
            ),
          ],
        ),
      );

  buildWidgetOTP(BuildContext context) => Column(
        children: [
          Container(
            color: Color(0xFFfefae6),
            padding: EdgeInsets.symmetric(horizontal: 12.ws, vertical: 12.ws),
            child: Row(
              children: [
                Assets.icons.payment.icCkAlert.svg(height: 22.ws),
                SizedBox(width: 8.ws),
                Text(
                  'Vui lòng kiểm tra kỹ thông tin trước khi xác nhận',
                  style: text11.textColorBlack,
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.ws),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mã xác nhận giao dịch bằng hình thức Soft OTP của Quý khách được hiển thị dưới đây.',
                  style: text14.semiBold.textColorBlack,
                  maxLines: 2,
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      'Thời gian hiệu lực Soft OTP:  ',
                      style: text14.bold.textColorBlack,
                    ),
                    buildCountDownTimer(context),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 50.ws,
                  margin: EdgeInsets.symmetric(vertical: 16.ws),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.rs)),
                    border: Border.all(color: colorMainLight, width: 1),
                  ),
                  child: Center(
                    child: Text(
                      controller.generateOTP(),
                      style: text28.bold.textColorBlue,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );

  Widget buildCountDownTimer(BuildContext context) => CountDownTimerWidget(
        start: 15,
        textStyle: text14.bold.textColorBlack,
        endCountDown: () {},
        onResend: () {},
      );
}
