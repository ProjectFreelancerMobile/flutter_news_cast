import 'package:flutter/material.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/base/base_page.dart';
import 'package:flutter_news_cast/ui/widgets/base_scaffold_widget.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';
import 'package:flutter_news_cast/ui/widgets/default_appbar.dart';

import '../../utils/toast_util.dart';
import '../main/widget/button_text_widget.dart';
import '../payment_sheet/payment_sheet.dart';
import '../widgets/input/text_form_field_widget.dart';
import 'payment_controller.dart';
import 'widget/button_next.dart';

//ignore: must_be_immutable
class PaymentPage extends BasePage<PaymentController> {
  @override
  Widget buildContentView(BuildContext context, PaymentController controller) {
    return ScaffoldBase(
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppbar(
        appBarStyle: AppBarStyle.BACK,
        title: 'Chuyển tiền liên ngân hàng',
        style: text15.bold.textColorMainDark,
        leadingColor: colorPrimary,
      ),
      body: Column(
        children: [
          Row(
            children: [
              ButtonTextSimpleWidget(title: 'Tới số tài khoản', isClick: true),
              SizedBox(width: 12.ws),
              ButtonTextSimpleWidget(title: 'Tới số thẻ'),
            ],
          ),
          SizedBox(height: 12.ws),
          buildWidgetInfo(),
          SizedBox(height: 24.ws),
          if (controller.isShowButtonInfo) ...[
            ButtonNext(
              title: 'Tiếp tục',
              onPress: () {
                controller.navPaymentDetails((error) {
                  showMessage(error);
                });
              },
            ),
          ]
        ],
      ),
    );
  }

  buildWidgetInfo() => Column(
        children: [
          DTextFromField(
            hintText: 'Số tài khoản',
            keyboardType: TextInputType.number,
            controller: controller.textStkCl,
            contentPadding: EdgeInsets.symmetric(vertical: 12.ws),
            prefixPadding: 10.ws,
            alignLabelWithHint: controller.hasEditStk.value,
            textStyle: text14.semiBold.textColorBlack,
            textHintStyle: text14.semiBold.textColorTextGreyLight,
            textLabelHintStyle: text18.bold.textColorBlack,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusNode: controller.myFocusNodeStk,
            rightIcon: controller.hasEditStk.value
                ? TouchableOpacity(
                    child: Assets.icons.payment.icCkClose.svg(),
                    onPressed: () {
                      controller.onCheckEdit(isClear: true);
                    },
                  )
                : null,
            suffixIcon: Assets.icons.payment.icCkQrcode.svg(width: 30.ws),
            onChange: (value) {
              controller.onCheckEdit(isName: true);
            },
          ),
          TouchableOpacity(
            child: DTextFromField(
              enabled: false,
              hintText: 'Ngân hàng nhận',
              keyboardType: TextInputType.text,
              controller: controller.textBankCl,
              contentPadding: EdgeInsets.symmetric(vertical: 12.ws),
              prefixPadding: 10.ws,
              alignLabelWithHint: controller.hasEditBank.value,
              textStyle: text14.semiBold.textColorBlack,
              textHintStyle: text14.semiBold.textColorTextGreyLight,
              textLabelHintStyle: text18.bold.textColorBlack,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Icon(Icons.keyboard_arrow_down_outlined, color: colorMainDark),
            ),
            onPressed: (){
              openPaymentBank(controller);
            },
          ),
        ],
      );

  buildWidgetMoney(bool isQrCode) => Row(
        children: [
          Text('VND', style: text28.semiBold.textColorBlack),
          SizedBox(width: 10.ws),
          SizedBox(
            width: 200.ws,
            height: 46.ws,
            child: DTextFromField(
              hintText: 'số tiền?',
              keyboardType: TextInputType.number,
              controller: controller.textPriceCl,
              strokeColor: Colors.transparent,
              contentPadding: EdgeInsets.symmetric(vertical: 6.ws),
              textStyle: text28.semiBold.textColorPrimary,
              textHintStyle: text28.semiBold.textColorTextGreyLight,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              inputFormatters: [ThousandsFormatter()],
              focusNode: controller.myFocusNodePrice,
              onTapOutside: (val) {
                controller.onUpdatePaymentPriceType(isQrCode);
              },
              onFieldSubmitted: (val) {
                controller.onUpdatePaymentPriceType(isQrCode);
              },
              onComplete: () {
                controller.onUpdatePaymentPriceType(isQrCode);
              },
            ),
          ),
        ],
      );

  buildWidgetNote() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('với lời nhắn', style: text28.semiBold.textColorBlack),
          Expanded(
            child: DTextFromField(
              hintText: 'nội dung?',
              keyboardType: TextInputType.multiline,
              controller: controller.textNoteCl,
              maxLines: 3,
              strokeColor: Colors.transparent,
              contentPadding: EdgeInsets.zero,
              textStyle: text28.semiBold.textColorPrimary,
              textHintStyle: text28.semiBold.textColorTextGreyLight,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              focusNode: controller.myFocusNodeNote,
              onTapOutside: (val) {
                controller.onUpdatePaymentNoteType();
              },
              onFieldSubmitted: (val) {
                controller.onUpdatePaymentNoteType();
              },
              onComplete: () {
                controller.onUpdatePaymentNoteType();
              },
            ),
          ),
        ],
      );

  buildWidgetNoteQRCode() => Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            width: double.infinity,
            height: 60.ws,
            child: DTextFromField(
              hintText: 'nội dung?',
              keyboardType: TextInputType.text,
              controller: controller.textNoteCl,
              maxLines: 1,
              strokeColor: Colors.grey.withOpacity(0.9),
              isUnderBorder: false,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.ws, vertical: 8.ws),
              textStyle: text18.textColorTextGreyLight,
              textHintStyle: text18.textColorTextGreyLight,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              focusNode: controller.myFocusNodeNote,
              onTapOutside: (val) {
                controller.onUpdatePaymentNoteType();
              },
              onFieldSubmitted: (val) {
                controller.onUpdatePaymentNoteType();
              },
              onComplete: () {
                controller.onUpdatePaymentNoteType();
              },
            ),
          ),
        ),
      );
}
