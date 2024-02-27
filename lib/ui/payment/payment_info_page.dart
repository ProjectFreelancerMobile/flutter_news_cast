import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:flutter_news_cast/data/storage/key_constant.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/base/base_page.dart';
import 'package:flutter_news_cast/ui/payment/payment_controller.dart';
import 'package:flutter_news_cast/ui/widgets/default_appbar.dart';

import '../../utils/data_util.dart';
import '../../utils/toast_util.dart';
import '../widgets/base_scaffold_widget.dart';
import '../widgets/button/touchable_opacity.dart';
import '../widgets/dividercustom.dart';
import '../widgets/input/text_form_field_widget.dart';
import 'widget/button_next.dart';

//ignore: must_be_immutable
class PaymentInfoPage extends BasePage<PaymentController> {
  @override
  Widget buildContentView(BuildContext context, PaymentController controller) {
    controller.onUpdatePaymentStep(PAYMENT_TYPE.INFO);
    return ScaffoldBase(
      resizeToAvoidBottomInset: false,
      isPaddingHorizontal: false,
      appBar: DefaultAppbar(
        appBarStyle: AppBarStyle.BACK,
        title: 'Chuyển tiền liên ngân hàng',
        style: text15.bold.textColorMainDark,
        leadingColor: colorPrimary,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.ws),
            child: Assets.icons.payment.icCkMoney.svg(height: 22.ws),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.ws),
                    child: Column(
                      children: [
                        buildWidgetInfo(),
                        SizedBox(height: 10),
                        buildWidgetPrice(),
                        SizedBox(height: 10.ws),
                        buildWidgetNote(),
                        SizedBox(height: 10.ws),
                        buildWidgetNapas(),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.ws),
                  buildWidgetPolicy(),
                  SizedBox(height: 100.ws),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                height: 120.ws,
                color: Colors.white,
                padding: EdgeInsets.only(top: 24.ws, bottom: 44.ws, left: 16.ws, right: 16.ws),
                child: ButtonNext(
                  onPress: () {
                    controller.navPaymentDetailsInfo((error) {
                      showMessage(error);
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildWidgetInfo() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Từ tài khoản', style: text14.bold.textColorMainDark),
                  SizedBox(height: 4),
                  Text(controller.user.soTaiKhoan, style: text16.semiBold.textColorMainDark),
                  Text(formatCurrency(controller.user.balance), style: text14.medium.textColorTextGreyLight),
                ],
              ),
              Assets.icons.info.icArrowDown.svg(width: 12.ws),
            ],
          ),
          DividerCustom(),
          SizedBox(height: 20.ws),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Đến tài khoản', style: text14.bold.textColorMainDark),
                  SizedBox(height: 4),
                  Text(controller.paymentItem.stk, style: text16.semiBold.textColorMainDark),
                  Text(controller.paymentItem.userNameFromSTK ?? controller.nameTKCKInfo, style: text16.semiBold.textColorMainDark),
                ],
              ),
              TouchableOpacity(
                onPressed: () => Get.back(),
                child: Assets.icons.payment.icCkPencil.svg(height: 20.ws),
              ),
            ],
          ),
          DividerCustom(),
          SizedBox(height: 20.ws),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ngân hàng nhận', style: text14.bold.textColorMainDark),
                  SizedBox(
                    width: Get.width - 40.ws,
                    child: Text(
                      controller.paymentItem.bankDetail?.name ?? '',
                      style: text16.semiBold.textColorMainDark,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(),
            ],
          ),
          DividerCustom(),
        ],
      );

  buildWidgetPrice() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DTextFromField(
            hintText: 'Số tiền',
            keyboardType: TextInputType.number,
            controller: controller.textPriceCl,
            contentPadding: EdgeInsets.symmetric(vertical: 12.ws),
            prefixPadding: 10.ws,
            strokeColor: Colors.transparent,
            alignLabelWithHint: controller.hasEditPrice.value,
            textStyle: text14.semiBold.textColorBlack,
            textHintStyle: text14.semiBold.textColorTextGreyLight,
            textLabelHintStyle: text18.bold.textColorBlack,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusNode: controller.myFocusNodePrice,
            rightIcon: controller.hasEditPrice.value
                ? TouchableOpacity(
                    child: Assets.icons.payment.icCkClose.svg(),
                    onPressed: () {
                      controller.onCheckEdit(isClear: true);
                    },
                  )
                : null,
            inputFormatters: [ThousandsFormatter()],
            onChange: (value) {
              controller.onUpdateMoney(value);
            },
          ),
          if (controller.hasEditPrice.value) ...[
            Text(controller.moneyText.value, style: text14.medium.textColorTextGreyLight),
          ],
          SizedBox(height: 6),
          DividerCustom(),
        ],
      );

  buildWidgetNote() => DTextFromField(
        hintText: 'Nội dung',
        keyboardType: TextInputType.text,
        controller: controller.textNoteCl,
        contentPadding: EdgeInsets.symmetric(vertical: 12.ws),
        prefixPadding: 10.ws,
        alignLabelWithHint: controller.hasEditNote.value,
        textStyle: text14.semiBold.textColorBlack,
        textHintStyle: text14.semiBold.textColorTextGreyLight,
        textLabelHintStyle: text18.bold.textColorBlack,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusNode: controller.myFocusNodeNote,
      );

  buildWidgetNapas() => Container(
        color: Color(0xFFe7f3f9),
        padding: EdgeInsets.all(12.ws),
        child: Column(
          children: [
            Row(
              children: [
                Text('Đây là dịch vụ chuyển tiền nhanh', style: text13.medium.textColorMainDark),
                SizedBox(width: 6),
                Assets.icons.payment.icCkNapas.svg(height: 18.ws),
              ],
            ),
            SizedBox(height: 8),
            Text('Giao dịch của Quý khách sẽ được chuyển ngay không phân biệt giờ, ngày nghỉ hay ngày lễ.', style: text13.medium.textColorTextGreyLight),
          ],
        ),
      );

  buildWidgetPolicy() => Column(
        children: [
          Container(
            width: double.infinity,
            color: Color(0xFFf2f5f8),
            padding: EdgeInsets.only(left: 16.ws, top: 30.ws),
            height: 60.ws,
            child: Text('THÔNG TIN BẢO HIỂM TÀI KHOẢN', style: text12.bold.textColorTextGrey),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.ws, vertical: 16.ws),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Assets.icons.payment.icCkCheckbox.svg(width: 26.ws),
                        SizedBox(width: 6.ws),
                        SizedBox(
                          width: Get.width - 100.ws,
                          child: Text(
                            'Tham gia miễn phí Bảo hiểm an ninh mạng ',
                            style: text14.medium.textColorBlack,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    Assets.icons.payment.icCkAlertDot.svg(width: 10.ws),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 32.ws),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bảo vệ lên đến 50 triệu đồng cho gian lận chuyển tiền do liên lạc điện tử giả mạo, truy cập website giả mạo, bị cài đặt phần mềm độc hại.',
                        style: text14.medium.textColorBlack,
                      ),
                      Text('Xem thông tin', style: text14.bold.textColorBlue.copyWith(color: Color(0xFF4b95dc))),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
}
