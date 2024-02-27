import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_news_cast/app/app_pages.dart';
import 'package:flutter_news_cast/res/style.dart';
import 'package:flutter_news_cast/ui/base/base_page.dart';
import 'package:flutter_news_cast/ui/widgets/button/touchable_opacity.dart';

import '../widgets/qrcode/src/ai_barcode_scanner.dart';
import 'qrcode_controller.dart';

//ignore: must_be_immutable
class QRCodePage extends BasePage<QRCodeController> {
  @override
  Widget buildContentView(BuildContext context, QRCodeController controller) {
    controller.startScanQR();
    return Scaffold(
      body: Stack(
        children: [
          AiBarcodeScanner(
            borderRadius: 0,
            cutOutBottomOffset: 120.ws,
            bottomBar: SizedBox(),
            overlayColor: Color(0xCC425460),
            //0x66263844
            borderColor: colorMainLight,
            borderLength: 16,
            borderWidth: 6.0,
            cutOutSize: 270.ws,
            controller: controller.cameraController,
            onScan: (String value) {
              controller.scanDecodeQRCode(value, (payment) {
                debugPrint('scanDecodeQRCode::::' + payment.toString());
                //openPaymentPaymentSend(context, controller.paymentItem, controller)
                Get.toNamed(AppRoutes.PAYMENT_INFO, arguments: true);
              });
            },
          ),
          Positioned(
            top: 50.ws,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.ws),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TouchableOpacity(
                    onPressed: () => Get.back(),
                    child: Icon(Icons.arrow_back, size: 24.ws, color: Colors.white),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Assets.icons.qrcode.icScanVietin.svg(height: 18.ws),
                          SizedBox(width: 12.ws),
                          Transform.translate(
                            offset: Offset(0, 3.ws),
                            child: Assets.icons.qrcode.icScanVnpay.svg(height: 18.ws),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.ws),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Assets.icons.qrcode.icScanVietqr.svg(height: 14.ws),
                          SizedBox(width: 12.ws),
                          Transform.translate(
                            offset: Offset(0, 3.ws),
                            child: Assets.icons.qrcode.icScanNapas.svg(height: 14.ws),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.ws),
                      Row(
                        children: [
                          Assets.icons.qrcode.icScanVisa.svg(height: 12.ws),
                          SizedBox(width: 12.ws),
                          Assets.icons.qrcode.icScanEvn.svg(height: 14.ws),
                        ],
                      ),
                    ],
                  ),
                  TouchableOpacity(
                      onPressed: () {
                        return;
                        controller.scanQRCodeTest((payment) {
                          debugPrint('scanDecodeQRCode::::' + payment.toString());
                          Get.toNamed(AppRoutes.PAYMENT_INFO, arguments: true);
                        });
                      },
                      child: Assets.icons.qrcode.icScanFlash.svg(width: 14.ws)),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: Get.height / 3,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Assets.icons.qrcode.icScanDiscount.svg(width: 60.ws),
                    SizedBox(height: 6.ws),
                    Text(
                      'Mã khuyến\nmãi đang có',
                      style: text12.semiBold.textColorWhite,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(width: 40.ws),
                Column(
                  children: [
                    Assets.icons.qrcode.icScanQrcode.svg(width: 60.ws),
                    SizedBox(height: 6.ws),
                    Text(
                      'Mã QR cá\nnhân',
                      style: text12.semiBold.textColorWhite,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(width: 40.ws),
                Column(
                  children: [
                    Assets.icons.qrcode.icScanShop.svg(width: 60.ws),
                    SizedBox(height: 6.ws),
                    Text(
                      'Lịch sử địa\nđiểm quét mã',
                      style: text12.semiBold.textColorWhite,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 70.ws,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.ws), topRight: Radius.circular(10.ws)),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Transform.translate(
                      offset: Offset(0, -6.ws),
                      child: Text('Chọn ảnh trong máy', style: text14.semiBold.textColorMainDark),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
