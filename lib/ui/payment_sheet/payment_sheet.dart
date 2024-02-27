import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_news_cast/ui/payment/payment_controller.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';

import '../../res/style.dart';
import '../widgets/input/text_form_field_widget.dart';

Future<void> openPaymentBank(PaymentController controller) {
  controller.loadJsonAssetListBank();
  return Get.bottomSheet(
    isScrollControlled: true,
    Container(
      height: Get.height * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.rs), topRight: Radius.circular(12.rs)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 24.ws),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  colorGradientLight,
                  colorGradientDark,
                ],
              ),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12.rs), topRight: Radius.circular(12.rs)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Chọn ngân hàng', style: text14.bold.textColorWhite),
                TouchableOpacity(
                  onPressed: () => Get.back(),
                  child: SizedBox(height: 50.ws, width: 50.ws, child: Icon(Icons.close, color: Colors.white)),
                ),
              ],
            ),
          ),
          DTextFromField(
            hintText: 'Tìm theo tên ngân hàng',
            keyboardType: TextInputType.text,
            controller: controller.textBankCl,
            prefixPadding: 0,
            contentPadding: EdgeInsets.only(bottom: 12.ws),
            prefixConstraints: BoxConstraints(minWidth: 32.ws, maxWidth: 32.ws, maxHeight: 32.ws, minHeight: 32.ws),
            textStyle: text18.semiBold.textColorBlack,
            textHintStyle: text18.semiBold.textColorTextGreyLight,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            prefixIcon: Padding(
              child: Assets.icons.payment.icCkSearch.svg(width: 50.ws),
              padding: EdgeInsets.only(left: 8.ws, bottom: 4.ws),
            ),
            onChange: (value) {
              controller.onSearchBank(value);
            },
          ),
          Expanded(
            child: Obx(
              () => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.ws),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = controller.listBankSearch[index];
                    return TouchableOpacity(
                      onPressed: () {
                        controller.onPickBank(item);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                              padding: EdgeInsets.all(6.ws),
                              child: Image.asset(item.logo ?? '', width: 30.ws, height: 30.ws),
                            ),
                            SizedBox(width: 10.ws),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(height: 4.ws),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(item.shortName ?? '', style: text14.semiBold.textColorBlack, maxLines: 2),
                                      SizedBox(width: 8),
                                      Assets.icons.payment.icCkNhanh24.svg(height: 20.ws),
                                    ],
                                  ),
                                  SizedBox(height: 4.ws),
                                  Text(item.name ?? '', style: text13.textColorBlack),
                                  SizedBox(height: 4.ws),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: controller.listBankSearch.length,
                ),
              ),
            ),
          )
        ],
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.rs),
    ),
    backgroundColor: colorWhite,
    elevation: 1,
  );
}

/*
Future<void> openNotificationDetail(TUser user, String item, bool isTypeAdd, String userName, String money, String note, DateTime datetime) {
  return Get.bottomSheet(
    isScrollControlled: true,
    Container(
      height: Get.height * 0.95,
      padding: EdgeInsets.symmetric(vertical: 16.ws, horizontal: 24.ws),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isTypeAdd ? Assets.images.payment.bgPaymentSuccess.image().image : Assets.images.payment.bgPaymentSuccessTrutien.image().image,
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12.rs), topRight: Radius.circular(12.rs)),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TouchableOpacity(onPressed: () => Get.back(), child: Icon(Icons.close, color: Colors.black, size: 34.ws)),
                TouchableOpacity(onPressed: () => Get.back(), child: Assets.icons.home.icTkSend.svg(width: 26.ws)),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.ws),
              child: isTypeAdd ? Assets.icons.home.icThemTien.svg(width: 60.ws) : Assets.icons.home.icMoneyTruTien.svg(width: 60.ws),
            ),
            Assets.icons.logo.icLogoRowColorText.svg(height: 24.ws),
            SizedBox(height: 16.ws),
            Row(
              children: [
                Text(isTypeAdd ? 'VND ' : '-VND ', style: text28.semiBold.textColorTextGrey),
                Text(
                  formatCurrencyRaw(int.tryParse(money) ?? 0),
                  style: isTypeAdd ? text28.semiBold.textColorBlack.copyWith(color: colorGreen) : text28.semiBold.textColorBlack,
                ),
              ],
            ),
            Text(
              formatDate(datetime, DATE_TIME_FORMAT_NOTIFICATION) ?? '',
              style: text18.textColorBlack,
            ),
            SizedBox(height: 16.ws),
            Text(isTypeAdd ? 'Tới tài khoản' : 'Từ tài khoản', style: text18.textColorTextGrey),
            Text(user.displayName ?? '', style: text22.semiBold.textColorBlack),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(user.soTaiKhoan, style: text18.textColorBlack),
                Assets.icons.payment.icPaymentCopy.svg(width: 20.ws),
              ],
            ),
            Text('Techcombank', style: text18.textColorBlack),
            SizedBox(height: 16.ws),
            if (!isTypeAdd) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tới tài khoản', style: text18.textColorTextGrey),
                  Text(userName, style: text22.semiBold.textColorBlack),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(getDataSTK(item), style: text18.textColorBlack),
                      Assets.icons.payment.icPaymentCopy.svg(width: 20.ws),
                    ],
                  ),
                  Text(getDataBank(item), style: text18.textColorBlack),
                  SizedBox(height: 16.ws),
                ],
              ),
            ],
            Text('Lời nhắn', style: text18.textColorBlack),
            Text(note, style: text22.semiBold.textColorBlack),
            SizedBox(height: 16.ws),
            Text('Mã giao dịch: ${getDataMaGD(item)}', style: text12.semiBold.textColorBlack),
            if (!isTypeAdd) ...[
              SizedBox(height: 140.ws),
              Align(alignment: Alignment.bottomCenter, child: Text('Bạn gặp vấn đề với giao dịch này?', style: text16.textColorPrimary)),
              SizedBox(height: 32.ws),
            ],
          ],
        ),
      ),
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.rs),
    ),
    backgroundColor: colorWhite,
    elevation: 1,
  );
}*/
